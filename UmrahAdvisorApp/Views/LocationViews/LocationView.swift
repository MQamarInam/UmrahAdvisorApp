//
//  LocationView.swift
//  mapApp
//
//  Created by Macbook Pro on 16/04/2024.

import SwiftUI
import MapKit

struct LocationView: View {
    
    @StateObject var vm: LocationViewModel = LocationViewModel()
    
    var body: some View {
        
        ZStack {
            mapLayer
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                
                CustomBackButtonView()
                
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            locationDetailView(vm: vm, location: location)
        }
        .navigationBarHidden(true)
        
    }
    
    private var header: some View {
        VStack {
            Button(action: {
                vm.toggleLocationsList()
            }, label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.black)
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            })
            if vm.showLocationsList {
                LocationsListView(vm: vm)
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.6), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(position: $vm.cameraPosition) {
            ForEach(vm.locations) { location in
                Annotation("", coordinate: location.coordinates) {
                    LocationMapAnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if(vm.mapLocation == location) {
                    LocationPreviewView(vm: vm, location: location)
                        .padding()
                        .shadow(color: .black.opacity(0.5), radius: 20)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}

#Preview {
    LocationView()
}
