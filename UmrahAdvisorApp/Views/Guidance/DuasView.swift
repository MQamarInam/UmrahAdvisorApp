//
//  DuasView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 21/09/2024.

import SwiftUI

struct DuasView: View {
    
    @StateObject var duasViewModel = DuasViewModel()
    
    var body: some View {
        VStack {
            if duasViewModel.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Text("Loading Duas...")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {

                List(duasViewModel.duaArray) { dua in
                    VStack(alignment: .trailing, spacing: 8) {
                        Text(dua.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.trailing)
                        
                        Divider()
                            .background(Color.gray.opacity(0.5))
                        
                        textSection(text1: dua.text1, text2: dua.text2)
                        
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
            await duasViewModel.fetchData()
        }
        .navigationTitle("Duas for Umrah")
    }
    
    private func textSection(text1: String, text2: String) -> some View {
        VStack(alignment: .trailing) {
            Text(text1)
                .font(.body)
                .foregroundColor(.green)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineSpacing(6)
            
            Text(text2)
                .font(.body)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
}

#Preview {
    DuasView()
}
