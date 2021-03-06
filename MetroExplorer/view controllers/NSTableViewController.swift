//
//  NSTableViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/13/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class NSTableViewController: UITableViewController {


    var nearestStations = SampleData.generateStationsData()

}

extension NSTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearestStations.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearestStationCell", for: indexPath)
        
        let neareStstations = nearestStations[indexPath.row]
        cell.textLabel?.text = neareStstations.name
        cell.detailTextLabel?.text = neareStstations.area
        return cell
    
    
}
}
