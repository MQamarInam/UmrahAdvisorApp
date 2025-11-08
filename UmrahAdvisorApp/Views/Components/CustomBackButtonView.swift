//
//  CustomBackButtonView.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 05/09/2025.
//

import SwiftUI

struct CustomBackButtonView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .font(.headline)
            .padding(.leading)
        }
    }
}
