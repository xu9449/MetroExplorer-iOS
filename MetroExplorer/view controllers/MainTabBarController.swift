//
//  MainTabBarController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 12/8/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var MyFavLandMarks = [FavLandmark]()
    let fetchLandmarksManager = FetchLandmarksManager()
    
    @IBOutlet weak var TabBar: UITabBar!
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        showbadgeValue()
        
    }
    override func viewDidLoad() {
        
        showbadgeValue()
        super.viewDidLoad()
        tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)
        
    }
    
    func showbadgeValue(){
        
        MyFavLandMarks = PersistenceManager.sharedInstance.fetchFavLandmarks()
        tabBar.items?[1].badgeValue = String(MyFavLandMarks.count)
        
    }
    
}
