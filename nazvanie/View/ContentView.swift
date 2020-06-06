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
                            self.addAnnatations()
                            
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
                            self.addAnnatations()
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
    
    func addAnnatations() {
        self.mapObserver.put(data: self.row)
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            print(self.mapObserver.models)

            for i in self.mapObserver.models {
                let newLocation = MKPointAnnotation()
                let lat = Double(i.lat)
                let lng = Double(i.lng)
                newLocation.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lng ?? 0)
                newLocation.title = i.adress
                self.locations.append(newLocation)
            }
        })
        self.query = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
