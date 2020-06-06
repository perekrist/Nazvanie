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
                        TextField("Search...", text: self.$mapObserver.query)
                        
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
                            withAnimation {
                                self.row = self.CSVobserver.getRandomRow()
                                self.mapObserver.put(data: self.row)
                                self.addAnnatations()
                            }
                        }) {
                            Text("Get RANDOM from bad.csv")
                        }
                        .padding()
                        .foregroundColor(.blue)
                        
                        if self.row != "" {
                            Button(action: {
                                withAnimation {
                                    self.row = ""
                                }
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
                .background(Color.white.opacity(0.76))
                .cornerRadius(30)
                .padding()
                .shadow(radius: 30)
                
                Spacer()
            }
        }
    }
    
    func addAnnatations() {
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            self.locations.removeAll()
            
            for i in self.mapObserver.models {
                let newLocation = MKPointAnnotation()
                let lat = Double(i.lat)
                let lng = Double(i.lng)
                newLocation.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lng ?? 0)
                newLocation.title = i.adress
                self.locations.append(newLocation)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
