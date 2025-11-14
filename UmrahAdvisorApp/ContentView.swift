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
            
            NavigationLink("Packages", destination: ShowAllPackagesView())
            
            NavigationLink("Custom Package", destination: CustomPackageView())
            
            NavigationLink("Add madinah", destination: ModifyMadinahHotel())
            NavigationLink("Add makkah", destination: ModifyMakkahHotel())
            NavigationLink("Add transportation", destination: ModifyTransportationData())
            NavigationLink("Add Ziyarats", destination: ModifyZiyaratData())
            NavigationLink("Add Flight", destination: ModifyFlightData())
        }
        
    }
}

#Preview {
    ContentView()
}
