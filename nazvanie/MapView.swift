//
//  MapView.swift
//  nazvanie
//
//  Created by Кристина Перегудова on 06.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    }
}
