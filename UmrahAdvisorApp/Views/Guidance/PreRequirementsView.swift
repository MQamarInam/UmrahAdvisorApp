//
//  PreRequirementsView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 20/09/2024.
//

import SwiftUI

struct PreRequirementsView: View {
    
    @State private var readyToBook = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Umrah Prerequisites")
                        .font(.title)
                        .frame(alignment: .center)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    
                    // Passport Information
                    requirementSection(imageName: "person.crop.rectangle", text: "Valid Passport", description: "Ensure your passport is valid for at least 6 months from your intended travel date. It must also have at least two blank pages.", imageColor: .blue)
                    
                    // Photograph Information
                    requirementSection(imageName: "camera", text: "Recent Photograph", description: "Provide a recent passport-size photograph with a white background, meeting Saudi Arabian visa specifications.", imageColor: .purple)
                    
                    // Vaccination Certificates
                    requirementSection(imageName: "bandage", text: "Vaccination Certificates", description: "Carry vaccination certificates for meningitis (mandatory), COVID-19, and other required vaccines. These should be issued by an authorized health facility.", imageColor: .orange)
                    
                    // Mahram Requirement
                    requirementSection(imageName: "person.2", text: "Mahram Requirement", description: "Female travelers under 45 must be accompanied by a Mahram (male guardian). Over 45, they may travel in a group with authorization.", imageColor: .pink)
                    
                    // Medical Insurance
                    requirementSection(imageName: "cross.case", text: "Travel and Health Insurance", description: "Health insurance covering COVID-19 and emergency medical treatment is mandatory. Ensure your insurance is valid for the entire travel duration.", imageColor: .teal)
                    
                    // Ihram and Essential Items
                    requirementSection(imageName: "bag", text: "Ihram and Essentials", description: "Pack Ihram clothing and other essentials such as prayer mats, slippers, and travel-friendly toiletries.", imageColor: .gray)
                    
                }
                .padding()
            }
        }
        
    }
    
    private func requirementSection(imageName: String, text: String, description: String, imageColor: Color)  -> some View {
        HStack {
            Image(systemName: imageName)
                .font(.title)
                .frame(width: 40, height: 40)
                .foregroundColor(imageColor)
            VStack(alignment: .leading) {
                Text(text)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
}

#Preview {
    PreRequirementsView()
}
