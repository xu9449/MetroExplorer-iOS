//
//  StationDetailViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/24/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit
import MapKit
class StationDetailViewController: UIViewController {
    var name = ""
    var address = " "
    var rating = Double?(0.0)
    var imageurl = URL(string: "https://s3-media3.fl.yelpcdn.com/bphoto/oAqE0UE3Gah-pWgroY2V3g/o.jpg")
    var lat = Double?(0)
    var lon = Double?(0)
    @IBOutlet weak var findDirectionButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    @IBOutlet weak var DetailAddressLabel: UILabel!
    @IBOutlet weak var DetailRatingLabel: UILabel!
    @IBOutlet weak var DetailNameLabel: UILabel!
    @IBAction func FindDirectionButtonPressed(_ sender: Any) {
        let latitude: CLLocationDegrees = lat ?? 39.04
        let longitude: CLLocationDegrees = lon ?? -120.98
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
        
        
        
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
        
        
        let shareText = "check out my favorite landmark."
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 

        print (name)
        self.DetailAddressLabel.text = address
        self.DetailNameLabel.text = name
        if let myNumber = rating {
            self.DetailRatingLabel.text = "Rating: \(myNumber)"
            
        }else {
            self.DetailRatingLabel.text = "N/A"
        }
        self.DetailImage.load(url: imageurl!)
        
        
        
       
    }
    

}


