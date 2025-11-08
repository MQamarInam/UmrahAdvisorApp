//
//  LocationPreviewView.swift
//  mapApp
//
//  Created by Macbook Pro on 17/04/2024.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @ObservedObject var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                HStack {
                    backButton
                    nextButton
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThickMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
        .padding(.bottom, 10)
        
    }
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(location.name)
                .font(.title2)
                .bold()
            
            Text(location.cityName)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button(action: {
            vm.sheetLocation = location
        }, label: {
            Text("Show Details")
                .font(.headline)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        })
    }
    
    private var nextButton: some View {
        Button(action: {
            vm.nextButtonPressed()
        }, label: {
            Text("Next")
                .font(.headline)
                .padding(13)
                .foregroundStyle(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
        })
    }
    
    private var backButton: some View {
        Button(action: {
            vm.backButtonPressed()
        }, label: {
            Text("Back")
                .font(.headline)
                .padding(13)
                .foregroundStyle(Color.white)
                .background(Color.gray)
                .cornerRadius(10)
        })
    }
    
}

#Preview {
    ZStack {
        LocationPreviewView(vm: LocationViewModel(), location: LocationsDataService.locations.first!)
            .padding()
    }
}
