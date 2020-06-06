//
//  MapModel.swift
//  nazvanie
//
//  Created by Кристина Перегудова on 06.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation

struct MapModel: Identifiable {
    var id: Int
    var error: String
    var adress: String
    var lat: Double
    var lng: Double
}
