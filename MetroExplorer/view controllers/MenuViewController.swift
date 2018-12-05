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
    
    @IBAction func NearestButtonPressed(_ sender: Any) {
        print("Select station")
        performSegue(withIdentifier: "NearestSegue", sender: self)    }
    
    
    @IBAction func SelectionButtonPressed(_ sender: Any) {
        print("Nearest station")
        
        performSegue(withIdentifier: "SelectionSegue", sender: self)    }

}


    

