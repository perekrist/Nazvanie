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

class MapObserver: ObservableObject {
    
    private let baseURL = "https://einavza.herokuapp.com/4/str"
    
    @Published var models: [MapModel] = [MapModel(error: "", adress: "", lat: 56.501041, lng: 84.992455), MapModel(error: "", adress: "", lat: 58.501041, lng: 89.992455)]
    
    
    func put(data: String) {
        
        let url = baseURL
        AF.request(url, method: .put, parameters: ["data": data]).responseJSON { (data) in
            print(data)
            
            let json = try! JSON(data: data.data!)
            let error = json["error"].stringValue
            
            if error == "" {
                let results = json["answer"].arrayValue
                
                for i in results {
                    print(i.stringValue)
                }
                
            } else {
                print(error)
            }
            
        }
    }
}
