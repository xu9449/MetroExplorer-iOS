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

class WMATAAPIManager{
    var delegate: FetchStationDelegate?
    func fetchStations() {
        var urlComponents = URLComponents(string:"https://api.wmata.com/Rail.svc/json/jStations?LineCode=GR")!
        urlComponents.queryItems = [
            URLQueryItem(name: "LineCode", value: "GR")
        ]
        // what's this for?
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
//                let WMATAResponse = decoder.decode(WMATAResponse.self, from: data)
//
//                var Stations = [Stations]
//
//                for Stations in WMATAResponse.response.Stations {
//                    let name = Stations.Name.joined(separator: " ")
//
//                    for Adress in WMATAResponse.response.Adress{
//                        let Street = Stations.Adress.Street
//                    }
//
//                    let gym = Gym(name: venue.name, address: address, iconUrl: iconUrl)
//
//                    stations.append(stations)
                }
                
//                //now what do we do with the gyms????
//                print(Stations)
//
//                self.delegate?.stationsFound(Stations)
//
//
//            } catch let error {
//                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
//                print("codable failed - bad data format")
//                print(error.localizedDescription)
//
//                self.delegate?.stationsNotFound()
//            }
    }
//
//        print("execute request")
//        task.resume()
  }
}
    
                


