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
    
    private var timer: Timer?
    private let baseURL = "https://einavza.herokuapp.com/4/str"
    
    @Published var models: [MapModel] = []
    @Published var query = ""  {
        didSet {
            if self.query != "" {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
                    self.put(data: self.query)
                })
            }
        }
    }
    
    
    func put(data: String) {
        print(data)
        self.models.removeAll()
        
        AF.request(baseURL, method: .post, parameters: ["data": data], encoding: JSONEncoding.default ).responseJSON { (data) in
            
            let json = try? JSON(data: data.data!)
            print(json)
            
            if json != nil {
                let error = json!["error"].stringValue
                
                let results = json!["answer"].arrayValue
                
                for result in results {
                    self.models.append(MapModel(adress: result[0].stringValue, lat: result[2].stringValue, lng: result[1].stringValue))
                }
            } else {
                print("error")
            }
        }
    }
}
