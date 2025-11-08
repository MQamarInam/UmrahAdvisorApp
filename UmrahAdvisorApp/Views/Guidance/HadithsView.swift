//
//  HadithsView.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 31/08/2025.
//

import SwiftUI

struct HadithsView: View {
    
    @StateObject var hadithViewModel = HadithsViewModel()
    
    var body: some View {
        VStack {
            if hadithViewModel.isLoading {
                // Display loading indicator
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Text("Loading Hadiths...")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Display Hadiths list
                List(hadithViewModel.HadithArray) { hadith in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(hadith.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Divider()
                            .background(Color.gray.opacity(0.5))
                        
                        Text(hadith.text)
                            .font(.body)
                            .foregroundColor(.black)
                        
                        textSection(text2: hadith.text2, text3: hadith.text3)
                        
                        Text(hadith.source ?? "")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 4)
                }
                .listStyle(PlainListStyle())
            }
        }
        .task {
            await hadithViewModel.fetchData()
        }
        .navigationTitle("Hadiths for Umrah")
    }
    
    private func textSection(text2: String, text3: String) -> some View {
        VStack(alignment: .trailing) {
            Text(text2)
                .font(.body)
                .foregroundColor(.blue)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(text3)
                .font(.body)
                .foregroundColor(.green)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
}

#Preview {
    HadithsView()
}
