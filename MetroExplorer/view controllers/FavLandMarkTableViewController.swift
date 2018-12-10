//
//  FavLandMarkTableViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 12/4/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class FavLandMarkTableViewController: UITableViewController {
    
    let favlandmarksKey = "favlandmarks"
    
    var favLandmarks = [FavLandmark](){
        didSet{
            tableView.reloadData()
        }
    }
    

    
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
       // tableView.rowHeight = UITableView.automaticDimension
       // tableView.estimatedRowHeight = 150
        favLandmarks = PersistenceManager.sharedInstance.fetchFavLandmarks()           }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
        
    }
    
    
    func viewLoadSetup(){
       // tableView.rowHeight = UITableView.automaticDimension
      //  tableView.estimatedRowHeight = 150
        favLandmarks = PersistenceManager.sharedInstance.fetchFavLandmarks()    
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favLandmarks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteTableViewCell
        let favlandmark = favLandmarks[indexPath.row]

        cell.AddressLabel.text = favlandmark.location
        cell.DateLabel.text = String(favlandmark.date!)
        cell.LandmarkImage.load(url: favlandmark.imageurl!)
        cell.NameLabel.text = favlandmark.name
        
        
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let userDefaults = UserDefaults.standard
        if (editingStyle == .delete) {
            favLandmarks.remove(at: indexPath.item)
            //tableView.deleteRows(at:[indexPath], with: .bottom)
            let encoder = JSONEncoder()
            let encodedLandmarks = try? encoder.encode(favLandmarks)
            userDefaults.set(encodedLandmarks, forKey: favlandmarksKey)        }
    }
}
