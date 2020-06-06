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
    
    private let baseURL = ""
    
    @Published var model: MapModel = MapModel(error: "", adress: "", lat: 56.501041, lng: 84.992455)
    
    
    func put(data: String) {
        let url = baseURL + ""
//        AF.request(url, method: .put, parameters: ["data": data]).responseJSON { (data) in
//            let json = try! JSON(data: data.data!)
//
//            let error = json["error"].stringValue
//            let answer = json["answer"].stringValue
//
//            self.model = MapModel(error: error, adress: answer, lat: 0, lng: 0)
//
//        }
    }
    
    
    
    
}
