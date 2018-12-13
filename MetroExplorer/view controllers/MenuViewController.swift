//
//  MenuViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/27/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Press the Seclection button to show the list of metro stations.
    @IBAction func NearestButtonPressed(_ sender: Any) {
        print("Select station")
        performSegue(withIdentifier: "NearestSegue", sender: self)    }
    
    // Press the Nearest button to show the nearest station's name and landmarks near it.
    @IBAction func SelectionButtonPressed(_ sender: Any) {
        print("Nearest station")
        performSegue(withIdentifier: "SelectionSegue", sender: self)    }
    
}




