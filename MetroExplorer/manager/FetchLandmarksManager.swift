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
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason)
}

class FetchLandmarksManager{
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    
    var delegate: FetchLandMarksDelegate?

    func fetchLandmarks(latitude: Double, longitude: Double) {
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: "landmark"),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude))
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
        

        
        
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                //PUT CODE HERE TO RUN UPON COMPLETION
                print("request complete")
                
                
                guard let response = response as? HTTPURLResponse else {
                    
                    
                    self.delegate?.landmarksNotFound(reason: .noResponse)
                    
                    
                    return
                }
                
                guard response.statusCode == 200 else {
                    self.delegate?.landmarksNotFound(reason: .non200Response)
                    
                    return
                }
                //HERE - response is NOT nil and IS 200
                
                guard let data = data else {
                   
                    
                    self.delegate?.landmarksNotFound(reason: .noData)
                    
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
                        
                        let address = businesse.location.display_address?.joined(separator: " ")
                      
                        let landmark = Landmark(name: businesse.name!, imageurl: businesse.image_url!, rating: businesse.rating!, location: address!)
                        
                        
                   

                        landmarks.append(landmark)
                        
                    }
                    
                    
                    print(landmarks)
                    
                    self.delegate?.landmarksFound(landmarks)
                    
                    
                } catch let error {
                    //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                    print("codable failed - bad data format")
                    print(error.localizedDescription)
                    
                    self.delegate?.landmarksNotFound(reason: .badData)
                }
            }
            
            print("execute request")
            task.resume()
        }
}
