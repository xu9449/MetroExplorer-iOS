//
//  WMATAAPIManager.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/21/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

protocol FetchStationDelegate {
    func stationFound(_ stations: [Station])
    func stationsNotFound()
}

class WMATAAPIManager {
    // delegate is like interface
    var delegate: FetchStationDelegate?
    
    func fetchStations() {
        var urlComponents = URLComponents(string:"https://api.wmata.com/Rail.svc/json/jStations?LineCode=GR")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "LineCode", value: "GR")
        ]
        
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or 200")
                
                self.delegate?.stationsNotFound()
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.stationsNotFound()
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let wmataResponse = try decoder.decode(WMATAResponse.self, from: data)
                
                var stations = [Station]()
                
                for station in wmataResponse.stations{
//                    let name = station.name!.joined(seperator: " ")
//                    let address = venue.location.formattedAddress.joined(separator: " ")
//
//                    let iconPrefix = venue.categories.first?.icon.prefix
//                    let iconSuffix = venue.categories.first?.icon.suffix
//
//                    var iconUrl: String? = nil
//
//                    if let iconPrefix = iconPrefix, let iconSuffix = iconSuffix {
//                        iconUrl = "\(iconPrefix)44\(iconSuffix)"
                    
                    let station = Station(name:station.name!, linecode1: station.lineCode1 ?? "None", linecode2: station.lineCode2, linecode3: station.lineCode3, Address: station.address?.city ?? "None")
//                    let gym = Gym(name: venue.name, address: address, iconUrl: iconUrl)
                    stations.append(station)
                    
                }
                
                //now what do we do with the gyms????
                
                print(stations)
                self.delegate?.stationFound(stations)
//                self.delegate?.gymsFound(gyms)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.stationsNotFound()
            }
        }
        
        print("execute request")
        task.resume()
    }
}


