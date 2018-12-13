//
//  MetroStationsViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/27/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit
import MBProgressHUD

class MetroStationsViewController: UITableViewController, UISearchBarDelegate {
    var fromSelectedStation = true
    var stationlat = 0.0
    var stationlon = 0.0
    var stationname = " "
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tblView: UITableView!
    
    var stations = [StationModel]()
    var currentStations = [StationModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationManager = FetchMetroStationsManager()
        fetchMetroStationManager.delegate = self 
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        fetchMetroStationManager.fetchStations()
        setUpSearchBar()
    }
    
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    //Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentStations = stations;
            return
        }
        currentStations = stations.filter({station -> Bool in
            guard let text = searchBar.text else {return false}
            return station.name.contains(text)
        })
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        
        return currentStations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as!
        StationTableViewCell
        
        let station = currentStations[indexPath.row]
        cell.stationNameLabel.text = station.name
        cell.stationAddressLabel.text = station.address
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let vc2 = storyboard?.instantiateViewController(withIdentifier:"LandMarkViewController")as?LandMarkViewController
        vc2?.stationlat = station.lat
        vc2?.stationlon = station.lon
        vc2?.fromSelectedStation = true
        vc2?.stationname = station.name 
        self.navigationController?.pushViewController(vc2!, animated: true)
    }
}

extension MetroStationsViewController: FetchStationDelegate {
    
    
    func stationFound(_ stations: [StationModel]) {
        
        print("stations found - here they are in the controller!")
        print(stations.count)
        DispatchQueue.main.async {
            self.stations = stations
            self.currentStations = stations
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
        
    }
    
    func stationsNotFound(reason: FetchMetroStationsManager.FailureReason) {
        
        let fetchMetroStationManager = FetchMetroStationsManager()
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)            
            let alertController = UIAlertController(title: "Problem fetching location", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    fetchMetroStationManager.fetchStations()
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
                
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


