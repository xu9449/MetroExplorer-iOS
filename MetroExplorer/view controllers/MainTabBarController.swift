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
    @IBOutlet weak var TabBar: UITabBar!
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("ddd")

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor(red: 38/255, green: 196/255, blue: 133/255, alpha: 1)

        // Do any additional setup after loading the view.
    }
    
//    override var shouldAutorotate: Bool {
//        if let viewController = self.viewControllers?[self.selectedIndex] {
//            return viewController.shouldAutorotate
//        }
//        return super.shouldAutorotate
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if let viewController = self.viewControllers?[self.selectedIndex] {
//            return viewController.supportedInterfaceOrientations
//        }
//        return super.supportedInterfaceOrientations
//    }
//    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        if let viewController = self.viewControllers?[self.selectedIndex] {
//            return viewController.preferredInterfaceOrientationForPresentation
//        }
//        return super.preferredInterfaceOrientationForPresentation
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
