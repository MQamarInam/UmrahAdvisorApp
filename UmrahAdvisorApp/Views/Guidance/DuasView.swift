//
//  DuasView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 21/09/2024.

import SwiftUI

struct DuasView: View {

    @StateObject var vm = DuasViewModel()
    
    var body: some View {
        NavigationStack {
            
            Group {
                if vm.isLoading {
                    ProgressView("Loading Duas...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(vm.duas) { dua in
                        duaCard(dua)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Duas for Umrah")
            .task { await vm.loadDuas() }
        }
    }
    
    private func duaCard(_ dua: Dua) -> some View {
        VStack(alignment: .trailing, spacing: 10) {
            Text(dua.name)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
            
            Divider()
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(dua.text1)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.trailing)
                
                Text(dua.text2)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


#Preview {
    DuasView()
}
