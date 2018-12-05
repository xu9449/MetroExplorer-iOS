//
//  FavoriteTableViewCell.swift
//  MetroExplorer
//
//  Created by 许科欣 on 12/4/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var AddressLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    
    @IBOutlet weak var LandmarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
