//
//  WMATAResponse.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/25/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

struct WMATAResponse : Codable {
    
    let stations:[Stations]
}

struct Stations:Codable{
    
    let address : Addres?
    let code : String?
    let lat : Float?
    let lineCode1 : String?
    let lineCode2 : String?
    let lineCode3 : String?
    let lineCode4 : String?
    let lon : Float?
    let name : String?
    
    
    enum CodingKeys: String, CodingKey {
        case address
        case code = "Code"
        case lat = "Lat"
        case lineCode1 = "LineCode1"
        case lineCode2 = "LineCode2"
        case lineCode3 = "LineCode3"
        case lineCode4 = "LineCode4"
        case lon = "Lon"
        case name = "Name"
      
    }
    
    
    struct Addres : Codable {
        
        let city : String?
        let state : String?
        let street : String?
        let zip : String?
        
        
        enum CodingKeys: String, CodingKey {
            case city = "City"
            case state = "State"
            case street = "Street"
            case zip = "Zip"
        }
        
    }
    
}

