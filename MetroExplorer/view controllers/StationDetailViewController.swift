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
    var imageurl = URL(string: "https://i.pinimg.com/236x/d6/45/5e/d6455ee8a3b0cb4495f141d3076db3d7--psy-kawaii.jpg")
    var lat = Double?(0)
    var lon = Double?(0)
    
    @IBOutlet weak var findDirectionButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var DetailImage: UIImageView!
    
    @IBOutlet weak var DetailAddressLabel: UILabel!
    @IBOutlet weak var DetailRatingLabel: UILabel!
    @IBOutlet weak var DetailNameLabel: UILabel!
    
    // Map Direction Part
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
    
    // Save the landmark to the favorite landmarks tableview
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        
        let favname = DetailNameLabel.text
        let favaddress = DetailAddressLabel.text
        let favimageUrl = imageurl
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .medium
        
        let timeString = "The saving time is: \(dateFormatter.string(from: Date() as Date))"
        let favdate = timeString
        let favLandmark = FavLandmark(name: favname!, imageurl: favimageUrl!, location: favaddress! ,date: favdate)
        // update the favorite view
        PersistenceManager.sharedInstance.saveLandmark(favlandmark: favLandmark)
        
    }
    
    //  Press the Share Button: share the detail of the landmark to others.
    @IBAction func ShareButtonPressed(_ sender: Any) {
        
        let shareText = "Check out my favorite landmark." + "\nName: " + name + "\nAddress: " + address
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.DetailAddressLabel.text = address
        self.DetailNameLabel.text = name
        if let myNumber = rating {
            self.DetailRatingLabel.text = "Rating: \(myNumber)"
        }else {
            self.DetailRatingLabel.text = "N/A"
        }
        self.DetailImage.load(url: imageurl ?? URL(string: "https://i.pinimg.com/236x/d6/45/5e/d6455ee8a3b0cb4495f141d3076db3d7--psy-kawaii.jpg")!)
        
    }
}


