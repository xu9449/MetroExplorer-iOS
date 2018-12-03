//
//  FetchLandmarksManager.swift
//  MetroExplorer
//
//  Created by 许科欣 on 11/26/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation

protocol FetchLandMarksDelegate {
    func landmarksFound(_ landmarks: [Landmark])
    func landmarksNotFound()
}

class FetchLandmarksManager{
    
    var delegate: FetchLandMarksDelegate?

    func fetchLandmarks() {
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: "landmark"),
            URLQueryItem(name: "latitude", value: "38.900140"),
            URLQueryItem(name: "longitude", value: "-77.049447")
        ]
        
//            let urlString = "https://api.yelp.com/v3/businesses/search"
//            let parameters = ["term":"landmarks%26Historical Buildings",
//                              "latitude":"38.900140",
//                              "longitude":"-77.049447"]
            let headers = ["Authorization":"Bearer zjH3xIw86DTgjpgtPB7tnE4Bt1Fyw-5tMV6REva6qBxtt8x7s5wlaARRoQYN8hZjs6hrS2mWAq9hQrvch__9oY6Pa61MjN5YPtYuSycOkerOf7Uvl8SgpbH6k0EEXHYx"]
        let url = urlComponents.url!
        
       
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
//            var urlComponents = URLComponents(string:urlString)
//            
//            var queryItems = [URLQueryItem]()
            
            
            
//            for (key, value) in parameters {
//                queryItems.append(URLQueryItem(name: key, value: value))
//            }
        
//            urlComponents?.queryItems = queryItems
//
//            var request = URLRequest(url: (urlComponents?.url)!)
//            request.httpMethod = "GET"
        
        
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                //PUT CODE HERE TO RUN UPON COMPLETION
                print("request complete")
                
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("response is nil or 200")
                    
                    self.delegate?.landmarksNotFound()
                    
                    return
                }
                
                //HERE - response is NOT nil and IS 200
                
                guard let data = data else {
                    print("data is nil")
                    
                    self.delegate?.landmarksNotFound()
                    
                    return
                }
                
                //HERE - data is NOT nil
                
                let decoder = JSONDecoder()
                
                do {
                    let yelpResponse = try decoder.decode(YelpResponse.self, from: data)
                    
                    //HERE - decoding was successful
                    
                    var landmarks = [Landmark]()
                    
                    print(yelpResponse.businesses)
                    
                    for businesse in yelpResponse.businesses {
                        
                        let landmark = Landmark(name: businesse.name, imageurl: businesse.image_url)
                        
                        landmarks.append(landmark)
                    }
                    
                    
                    print(landmarks)
                    
                    self.delegate?.landmarksFound(landmarks)
                    
                    
                } catch let error {
                    //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                    print("codable failed - bad data format")
                    print(error.localizedDescription)
                    
                    self.delegate?.landmarksNotFound()
                }
            }
            
            print("execute request")
            task.resume()
        }
}
