//
//  LandMarkViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/27/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit
import MBProgressHUD


private let reuseIdentifier = "Cell"

class LandMarkViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let locationDetector = LocationDetector()
    let fetchLandmarksManager = FetchLandmarksManager()
    
    var landmarks = [Landmark](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationDetector.delegate = self
        fetchLandmarksManager.delegate = self
        
        fetchLandmarks()
    }
    
    private func fetchLandmarks(){
//
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        locationDetector.findLocation()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return landmarks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let landmark = landmarks[indexPath.row]

        

        cell.MyLabel.text = landmark.name
        cell.landmarksImage.load(url: landmark.imageurl  )
        

        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let vc = storyboard?.instantiateViewController(withIdentifier:"StationDetailViewController")as?StationDetailViewController
            let landmark = landmarks[indexPath.row]
        let a = "Rating: "
        
        vc?.name = landmark.name
        vc?.address = landmark.location
        vc?.rating =  a + String(landmark.rating)
        vc?.imageurl = landmark.imageurl
        self.navigationController?.pushViewController(vc!, animated: true)

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    

    
    
    
    
}

extension LandMarkViewController: FetchLandMarksDelegate {
    
    
    func landmarksFound(_ landmarks: [Landmark]) {
        print("landmarks found - here they are in the controller!")
       
        DispatchQueue.main.async {
            self.landmarks = landmarks
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alertController = UIAlertController(title: "Problem fetching landmarks", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchLandmarks()
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
                
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
        
      
        
    }
    
    
}

extension LandMarkViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
        fetchLandmarksManager.fetchLandmarks(latitude: latitude, longitude: longitude)
    }
    
    func locationNotDetected() {
        print("no location found :(")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            //TODO: Show a AlertController with error
        }
    }
}
