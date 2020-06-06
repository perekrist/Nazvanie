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
    
    var body: some View {
        ZStack {
            MapView()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search...", text: self.$query)
                    }
                    
                    
                    Text("-- OR --")
                    
                    Button(action: {
                        
                    }) {
                        Text("Get RANDOM from bad.csv")
                    }.padding()
                        .foregroundColor(.blue)
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
