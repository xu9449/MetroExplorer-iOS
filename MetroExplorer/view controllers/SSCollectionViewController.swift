//
//  SSCollectionViewController.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/23/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SSCollectionViewController: UICollectionViewController{
    let items = ["0", "1", "3"]
    
    @IBOutlet internal weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

        cell.MyLabel.text = items[indexPath.item]
        
        // Configure the cell

        return cell
    }
    func collectionView( collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

}
