//
//  ContentView.swift
//  nazvanie
//
//  Created by Кристина Перегудова on 06.06.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var query = ""
    
    @ObservedObject private var CSVobserver = CSVObserver()
    @ObservedObject private var mapObserver = MapObserver()
    
    @State private var row = ""
    
    var body: some View {
        ZStack {
            MapView()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding()
                        TextField("Search...", text: self.$query)
                        
                        Button(action: {
                            self.mapObserver.put(data: self.query)
                        }) {
                            Text("Send")
                        }
                        .padding()
                        .foregroundColor(.blue)
                    }
                    
                    
                    
                    Text("-- OR --")
                    
                    Button(action: {
                        self.row = self.CSVobserver.getRandomRow()
                    }) {
                        Text("Get RANDOM from bad.csv")
                    }
                    .padding()
                    .foregroundColor(.blue)
                    
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
