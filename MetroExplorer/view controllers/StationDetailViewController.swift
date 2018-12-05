//
//  StationDetailViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/24/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {
    var name = ""
    var address = " "
    var rating = " "
    var imageurl = URL(string: "https://s3-media3.fl.yelpcdn.com/bphoto/oAqE0UE3Gah-pWgroY2V3g/o.jpg")
    @IBOutlet weak var findDirectionButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    @IBOutlet weak var DetailAddressLabel: UILabel!
    @IBOutlet weak var DetailRatingLabel: UILabel!
    @IBOutlet weak var DetailNameLabel: UILabel!
    @IBAction func FindDirectionButtonPressed(_ sender: Any) {
        
    }
    @IBAction func SaveButtonPressed(_ sender: Any) {
        let favname = DetailNameLabel.text
        let favaddress = DetailAddressLabel.text
        let favimageUrl = imageurl
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium

        let timeString = "The save time is: \(dateFormatter.string(from: Date() as Date))"
        let favdate = timeString
        
        let favLandmark = FavLandmark(name: favname!, imageurl: favimageUrl!, location: favaddress! ,date: favdate)
        PersistenceManager.sharedInstance.saveLandmark(favlandmark: favLandmark)
    }
    
    @IBAction func ShareButtonPressed(_ sender: Any) {
        
        
        let shareText = "check out my pushup record"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 

        print (name)
        self.DetailAddressLabel.text = address
        self.DetailNameLabel.text = name
        self.DetailRatingLabel.text = String(rating)
        self.DetailImage.load(url: imageurl!)
        
        
        
       
    }
    

}


