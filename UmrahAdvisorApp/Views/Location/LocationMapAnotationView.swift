//
//  LocationMapAnotationView.swift
//  mapApp
//
//  Created by Macbook Pro on 18/04/2024.
//

import SwiftUI

struct LocationMapAnotationView: View {
    var body: some View {
        VStack {
            
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(8)
                .background(Color.red)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 15, height: 15)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -11)
                .padding(.bottom, 35)
        }
        
    }
}

#Preview {
    LocationMapAnotationView()
}
