//
//  WMATAResponse.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/25/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

struct Station : Codable {
    
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
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try Addres(from: decoder)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        lat = try values.decodeIfPresent(Float.self, forKey: .lat)
        lineCode1 = try values.decodeIfPresent(String.self, forKey: .lineCode1)
        lineCode2 = try values.decodeIfPresent(String.self, forKey: .lineCode2)
        lineCode3 = try values.decodeIfPresent(String.self, forKey: .lineCode3)
        lineCode4 = try values.decodeIfPresent(String.self, forKey: .lineCode4)
        lon = try values.decodeIfPresent(Float.self, forKey: .lon)
        name = try values.decodeIfPresent(String.self, forKey: .name)
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
//        init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            city = try values.decodeIfPresent(String.self, forKey: .city)
//            state = try values.decodeIfPresent(String.self, forKey: .state)
//            street = try values.decodeIfPresent(String.self, forKey: .street)
//            zip = try values.decodeIfPresent(String.self, forKey: .zip)
//        }
        
        
    }
    
}

