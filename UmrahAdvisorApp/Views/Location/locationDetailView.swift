//
//  locationDetailView.swift
//  mapApp
//
//  Created by Macbook Pro on 18/04/2024.
//

import SwiftUI
import MapKit

struct locationDetailView: View {
    
    @ObservedObject var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                imageSection
                    .shadow(color: .black.opacity(0.6), radius: 20,x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16, content: {
                    titleSection
                    descriptionSection
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
        }
        .ignoresSafeArea()
        .background(.ultraThickMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

#Preview {
    locationDetailView(vm: LocationViewModel(), location: LocationsDataService.locations.first!)
}

extension locationDetailView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 320)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.gray)
        })
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            ForEach(location.LocationDetailData, id: \.title) { detail in
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                        .padding(.bottom, 10)
                    Text(detail.title)
                        .font(.headline)
                    ForEach(detail.description, id: \.self) { desc in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 10))
                                .foregroundColor(.black)
                                .padding(.top, 6)
                            Text(desc)
                                .font(.body)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        })
    }
    
    private var backButton: some View {
        Button(action: {
            vm.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.black)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 6)
                .padding()
        })
    }
    
}
