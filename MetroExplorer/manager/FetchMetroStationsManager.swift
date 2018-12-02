//
//  FetchMetroStationsManager.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/26/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

protocol FetchStationDelegate {
    func stationFound(_ stations: [StationModel])
    func stationsNotFound()
}

class FetchMetroStationsManager {
    // delegate is like interface
    var delegate: FetchStationDelegate?
    
    func fetchStations() {
        
        let urlString = "https://api.wmata.com/Rail.svc/json/jStations"
        let parameters = ["LineCode":"GR"]
        let headers = ["api_key":"1a0a683e85d84207babfbae2647236ba"]
        
        var urlComponents = URLComponents(string:urlString)
        
        var queryItems = [URLQueryItem]()
        
        
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
       urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
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
                
                //HERE - decoding was successful
                
                var stations = [StationModel]()
                
                for station in wmataResponse.Stations {
                    
                   let station = StationModel(name: station.Name, address: station.Address.Street)
                    
                    stations.append(station)
                }
                
                //now what do we do with the gyms????
                print(stations)
                
                self.delegate?.stationFound(stations)
                
                
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
