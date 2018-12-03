//
//  LandMarkViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/27/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit



private let reuseIdentifier = "Cell"

class LandMarkViewController: UICollectionViewController {
    
    var landmarks = [Landmark](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchLandmarksManager = FetchLandmarksManager()
        fetchLandmarksManager.delegate = self
        
        fetchLandmarksManager.fetchLandmarks()
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
//        let defaulturl = URL(string: "https://s3-media2.fl.yelpcdn.com/bphoto/2EljPz-cdiTQa6wTsIbI7Q/o.jpg")
//
        cell.MyLabel.text = landmark.name
        cell.landmarksImage.load(url: landmark.imageurl )
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        performSegue(withIdentifier: "DetailSague", sender: self)
        
    }
    

    
    
    
    
}

extension LandMarkViewController: FetchLandMarksDelegate {
    func landmarksFound(_ landmarks: [Landmark]) {
        print("landmarks found - here they are in the controller!")
       
        DispatchQueue.main.async {
            self.landmarks = landmarks
        }
    }
    
    func landmarksNotFound() {
        print("no landmarks found")
        
      
        
    }
    
    
}
