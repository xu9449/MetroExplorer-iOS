//
//  FetchNearestStationManager.swift
//  MetroExplorer
//
//  Created by 许科欣 on 12/6/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

protocol FetchNearestStationDelegate {
    func neareststationFound(_ landmarks: [NearestStation])
    func neareststationNotFound(reason: FetchNearestStationManager.FailureReason)
}

class FetchNearestStationManager{
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    
    var delegate: FetchNearestStationDelegate?
    
func fetchNearestStation(latitude: Double, longitude: Double) {
    
    var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
    
    urlComponents.queryItems = [
        URLQueryItem(name: "term", value: "Metro"),
        URLQueryItem(name: "latitude", value: String(latitude)),
        URLQueryItem(name: "longitude", value: String(longitude))
    ]
    
    let headers = ["Authorization":"Bearer zjH3xIw86DTgjpgtPB7tnE4Bt1Fyw-5tMV6REva6qBxtt8x7s5wlaARRoQYN8hZjs6hrS2mWAq9hQrvch__9oY6Pa61MjN5YPtYuSycOkerOf7Uvl8SgpbH6k0EEXHYx"]
    let url = urlComponents.url!
    
    
    
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //PUT CODE HERE TO RUN UPON COMPLETION
        print("request complete")
        
        
        guard let response = response as? HTTPURLResponse else {
            
            
            self.delegate?.neareststationNotFound(reason: .noResponse)
            
            
            return
        }
        
        guard response.statusCode == 200 else {
            self.delegate?.neareststationNotFound(reason: .non200Response)
            
            return
        }
        //HERE - response is NOT nil and IS 200
        
        guard let data = data else {
            
            
            self.delegate?.neareststationNotFound(reason: .noData)
            
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let yelpResponse = try decoder.decode(YelpResponse.self, from: data)
            
            //HERE - decoding was successful
            
            var neareststations = [NearestStation]()
            
            
            print(yelpResponse.businesses)
            
            for businesse in yelpResponse.businesses {
                
                
                
                let neareststation = NearestStation(name: businesse.name!)
                
                
                
                
                neareststations.append(neareststation)
                
            }
            print(neareststations)
            
            self.delegate?.neareststationFound(neareststations)
            
            
        } catch let error {
            //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
            print("codable failed - bad data format")
            print(error.localizedDescription)
            
            self.delegate?.neareststationNotFound(reason: .badData)
        }
    }
    
    print("execute request")
    task.resume()
}
}
