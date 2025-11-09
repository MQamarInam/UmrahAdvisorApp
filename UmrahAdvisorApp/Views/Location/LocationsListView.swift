//
//  LocationsListView.swift
//  mapApp
//
//  Created by Macbook Pro on 17/04/2024.
//

import SwiftUI

struct LocationsListView: View {
    
    @ObservedObject var vm: LocationViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                
                
            }
        }
        .listStyle(.plain)
        
    }
    
    private func listRowView(location: Location) -> some View {
        HStack {
            Text(location.locationNumber)
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.green)
                .clipShape(.circle)
                .padding(.trailing, 6)
            
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
    
}

#Preview {
    LocationsListView(vm: LocationViewModel())
}
