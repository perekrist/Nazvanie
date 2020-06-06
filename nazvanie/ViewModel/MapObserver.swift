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
        
        AF.request(baseURL, method: .post, parameters: ["data": data], encoding: JSONEncoding.default ).responseJSON { (data) in
                        
            let json = try? JSON(data: data.data!)
            
            if json != nil {
                let error = json!["error"].stringValue

                let results = json!["answer"].arrayValue

                for result in results {
                    print(result)
                    self.models.append(MapModel(adress: result[0].stringValue, lat: result[2].stringValue, lng: result[1].stringValue))
                }
            }
            print("load..")
        }
    }
}
