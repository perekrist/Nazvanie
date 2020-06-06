//
//  MapObserver.swift
//  nazvanie
//
//  Created by Кристина Перегудова on 06.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class MapObserver: ObservableObject {
    
    private let baseURL = "https://einavza.herokuapp.com/4/str"
    
    @Published var models: [MapModel] = []
    
    
    func put(data: String) {
        self.models.removeAll()
        
        let url = baseURL
        print(data)
        AF.request(url, method: .put, parameters: ["data": data]).responseJSON { (data) in
            
            print(data)
            
            let json = try? JSON(data: data.data!)
            
            if json != nil {
                let error = json!["error"].stringValue
                
                if error == "" {
                    let results = json!["answer"].arrayValue
                    
                    for i in results {
                        print(i.stringValue)
                        self.addLocation(address: i.stringValue)
                    }
                    
                } else {
                    print(error)
                }
            }
            
        }
    }
    
    func addLocation(address: String) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("no location")
                    return
            }
            self.models.append(MapModel(adress: address, lat: location.coordinate.latitude, lng: location.coordinate.longitude))
        }
    }
}
