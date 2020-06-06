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
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search...", text: self.$query)
                    
                }
                .padding()
                .foregroundColor(.gray)
                .background(Color.white)
                .cornerRadius(30)
                .padding()
                
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
