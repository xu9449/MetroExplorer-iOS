//
//  YelpResponse.swift
//  MetroExplorer
//
//  Created by 许科欣 on 12/2/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

struct YelpResponse: Codable {
    
    let businesses: [Businesses]
    
}

struct Businesses: Codable {
     let imageURL = URL(string:"https://i.pinimg.com/236x/d6/45/5e/d6455ee8a3b0cb4495f141d3076db3d7--psy-kawaii.jpg")
    let name: String
    let image_url: URL?
    let rating: Double?
    let location: Location
    let coordinates: Coordinates
    
}

struct Location: Codable {
    
    let display_address: [String]?
    
}

struct Coordinates: Codable {
    
    let latitude: Double?
    let longitude: Double?
    
}





