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
                
}
}
}
}
