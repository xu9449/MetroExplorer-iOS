//
//  WMATAResponse.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/25/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

struct WMATAResponse: Codable {
    
    let Stations: [Stations]
    
}

struct Stations: Codable {
    
    let Address: Address
    let Name: String
    let Lat: Double
    let Lon: Double
        
}

struct Address: Codable {
    
    let Street: String
    
}
