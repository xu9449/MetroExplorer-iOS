//
//  MetroStationsViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/27/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit
import MBProgressHUD

class MetroStationsViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tblView: UITableView!
    
    var stations = [StationModel]() {
        didSet{
            tableView.reloadData()
        }
    }

//    var searchStation = [StationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationManager = FetchMetroStationsManager()
        fetchMetroStationManager.delegate = self 
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        fetchMetroStationManager.fetchStations()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as!
        StationTableViewCell
     
        let station = stations[indexPath.row]
        cell.stationNameLabel.text = station.name
        cell.stationAddressLabel.text = station.address
        
      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SelectionSeque2", sender: self)
    }
    
}



extension MetroStationsViewController: FetchStationDelegate {
    
    
    
    
    func stationFound(_ stations: [StationModel]) {
        print("stations found - here they are in the controller!")
        print(stations.count)
        DispatchQueue.main.async {
            self.stations = stations
            
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

//extension MetroStationsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//        searchStation = stations.filter($0.prefix(searchText.count)})
//    }
//}
