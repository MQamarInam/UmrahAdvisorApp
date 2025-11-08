//
//  ContentView.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 29/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            NavigationLink("Map", destination: LocationView())
        }
        
    }
}

#Preview {
    ContentView()
}
