//
//  MetroStationsViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/27/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class MetroStationsViewController: UITableViewController {
    
    var stations = [StationModel]() {
        didSet{
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationManager = FetchMetroStationsManager()
        fetchMetroStationManager.delegate = self 
        
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
            
            
        }    }
    
    func stationsNotFound() {
        print("no stations found")
    }
}
