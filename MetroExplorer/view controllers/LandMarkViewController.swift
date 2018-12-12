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
    let fetchNearestStationManager = FetchNearestStationManager()
    var fromSelectedStation = false
    var stationlat = Double?(38.900140)
    var stationlon = Double?(-77.049447)
    var stationname = String?("Metro Station")
    
    
    var landmarks = [Landmark](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    var nearestStations = [NearestStation](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationDetector.delegate = self
        fetchLandmarksManager.delegate = self
        fetchNearestStationManager.delegate = self
        
        fetchLandmarks()
        
    }
    
    private func fetchLandmarks(){
        
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        if(fromSelectedStation == true){
            
            self.title = stationname
            fetchLandmarksManager.fetchLandmarks(latitude: stationlat!, longitude: stationlon!)
            
        }else{
            locationDetector.findLocation()
          //  locationDetector.gameTimer.invalidate()
            
        }
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return landmarks.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let landmark = landmarks[indexPath.row]
        
        cell.MyLabel.text = landmark.name
        cell.landmarksImage.load(url: landmark.imageurl!)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier:"StationDetailViewController")as?StationDetailViewController
        let landmark = landmarks[indexPath.row]
        
        vc?.name = landmark.name ?? "nil"
        vc?.address = landmark.location ?? "nil"
        vc?.rating = landmark.rating
        vc?.imageurl = landmark.imageurl
        vc?.lat = landmark.lat
        vc?.lon = landmark.lon
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
    func locationDetected(latitude: Double?, longitude: Double?) {
        
        fetchNearestStationManager.fetchNearestStation(latitude: latitude ?? 38.900140, longitude: longitude ?? -77.049447)
        fetchLandmarksManager.fetchLandmarks(latitude: latitude ?? 38.900140, longitude: longitude ?? -77.049447)
        
    }
    
    func locationNotDetected() {
        print("no location found :(")
        DispatchQueue.main.async {
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alertController = UIAlertController(title: "Problem fetching location",message:" " ,preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}

extension LandMarkViewController: FetchNearestStationDelegate {
    
    func neareststationFound(_ neareststations: [NearestStation]) {
        print("Nearest station found - here they are in the controller!")
        
        DispatchQueue.main.async {
            
            self.nearestStations = neareststations
            print(self.nearestStations)
            self.title = self.nearestStations[0].name
            self.stationlat = self.nearestStations[0].lat ?? 38.900140
            self.stationlon = self.nearestStations[0].lon ?? -77.049447
            self.fetchLandmarksManager.fetchLandmarks(latitude: self.stationlat!, longitude: self.stationlon!)
        }
    }
    
    func neareststationNotFound(reason: FetchNearestStationManager.FailureReason) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Problem fetching nearest station", message: reason.rawValue, preferredStyle: .alert)
            
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
