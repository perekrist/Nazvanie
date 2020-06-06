//
//  ContentView.swift
//  nazvanie
//
//  Created by Кристина Перегудова on 06.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var query = ""

    @ObservedObject private var CSVobserver = CSVObserver()
    @ObservedObject private var mapObserver = MapObserver()
    
    @State private var locations = [MKPointAnnotation]()
    
    @State private var row = ""
    
    var body: some View {
        ZStack {
            MapView(annotations: locations)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding()
                        TextField("Search...", text: self.$query)
                        
                        Button(action: {
                            self.mapObserver.put(data: self.query)
                            
                            for i in self.mapObserver.models {
                                let newLocation = MKPointAnnotation()
                                newLocation.coordinate = CLLocationCoordinate2D(latitude: i.lat, longitude: i.lng)
                                self.locations.append(newLocation)
                            }
                            
                        }) {
                            Text("Send")
                        }
                        .padding()
                        .foregroundColor(.blue)
                    }
                    
                    
                    
                    Text("-- OR --")
                    
                    HStack {
                        Button(action: {
                            self.row = self.CSVobserver.getRandomRow()
                            self.mapObserver.put(data: self.row)
                            
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                                for i in self.mapObserver.models {
                                    let newLocation = MKPointAnnotation()
                                    newLocation.coordinate = CLLocationCoordinate2D(latitude: i.lat, longitude: i.lng)
                                    self.locations.append(newLocation)
                                }
                            })
                            
                        }) {
                            Text("Get RANDOM from bad.csv")
                        }
                        .padding()
                        .foregroundColor(.blue)
                        
                        if self.row != "" {
                            Button(action: {
                                self.row = ""
                            }) {
                                Image(systemName: "chevron.up")
                            }
                            .padding()
                            .foregroundColor(.blue)
                        }
                    }
                    
                    if row != "" {
                        Text(row)
                            .padding()
                    }
                }
                .padding()
                .foregroundColor(.gray)
                .background(Color.white)
                .cornerRadius(30)
                .padding()
                .shadow(radius: 30)
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
