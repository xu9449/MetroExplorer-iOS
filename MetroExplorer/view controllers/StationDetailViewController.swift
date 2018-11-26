//
//  StationDetailViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/24/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {
    @IBAction func ShareButtonPressed(_ sender: Any) {
        let shareText = "check out my pushup record"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
