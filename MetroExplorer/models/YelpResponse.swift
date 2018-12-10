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
   
    let name: String?
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





