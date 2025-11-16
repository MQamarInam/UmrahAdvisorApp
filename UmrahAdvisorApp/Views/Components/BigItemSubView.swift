//
//  BigItemSubView.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 15/11/2025.
//

import SwiftUI

struct BigItemSubView: View {
    @State var imageName: String
    @State var text: String = ""
    @State var description: String = ""
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                )
            VStack(alignment: .leading) {
                Text(text)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .font(.title2)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-2)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 15))
        }
        .padding(12)
        .background(Color.white.opacity(0.9))
        .foregroundStyle(Color.background)
        .cornerRadius(10)
    }
}
