//
//  ViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/12/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }

    @IBAction func NearestButtonPressed(_ sender: Any) {
        print("find nearest station")
        performSegue(withIdentifier: "NearestSegue", sender: self)    }
    
    
    @IBAction func SelectionButtonPressed(_ sender: Any) {
        print("find selection station")
        performSegue(withIdentifier: "SelectionSegue", sender: self)    }
    
    
   
    
    

}

