//
//  itemsSubView.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 15/11/2025.
//

import SwiftUI

struct itemsSubView: View {
    @State var imageName: String
    @State var textShow: String
    var body: some View {
        VStack(spacing: 3) {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            Spacer()
            Text(textShow)
                .bold()
                .padding(.horizontal, 1)
                .padding(.bottom, 15)
        }
        .foregroundColor(Color.background)
        .frame(minWidth: 80, maxWidth: 100, minHeight: 100, maxHeight: 130)
        .background(Color.white)
        .cornerRadius(10)
        .multilineTextAlignment(.center)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 10)
    }
}
