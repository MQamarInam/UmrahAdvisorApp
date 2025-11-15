//
//  ContentView.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 29/08/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var whtspVM: WhatsappViewModel = WhatsappViewModel()
    @StateObject var fm: PackageViewModel = PackageViewModel()
    @State private var selectedPackage: Packages? = nil
    @State private var showPackageDetailSheet = false
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @State private var currentIndex = 0
    
    @State private var isTimerStarted = false
    @State private var isGradientAnimated = false
    @State private var isAnimating = false
    
    var hotPackages: [Packages] {
        fm.packages.filter { $0.isHot }
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
//              Background Layer
                LinearGradient(colors: [Color.background, Color.background, Color.bgcu], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                Image("loginbg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.1)
                            
//              Foregroud layer
                VStack {
                    
                    profileHeaderSection
                    
                    Divider()
                        .background(Color.white)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        HotPackageSlider(hotPackages: fm.packages.filter { $0.isHot })
                        bigSubViewSection
                        otherElements
                        showPackagesSection
                                                
                        Spacer()
                    }
                    
                }
                .padding(.horizontal)
                .overlay(alignment: .bottomTrailing) {
                    whatsAppButton
                }
//              .onAppear {
//                  fm.fetchPackagesData()
//              }
                
            }
        }
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    ContentView()
}

extension ContentView {
    
    private var profileHeaderSection: some View {
        HStack {
            HStack(spacing: 8) {
                HStack {
                    NavigationLink  {
                        ProfileView()
                    } label: {
                        if let user = authViewModel.currentUser {
                            Circle()
                                .frame(width: 45)
                                .foregroundStyle(.white)
                                .overlay {
                                    Text(user.initials)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.gray)
                                }
                            VStack(alignment: .leading) {
                                Text(user.fullname)
                                    .foregroundStyle(.white)
                                    .bold()
                                Text(user.email)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(0.1)
        }
    }
    
    private var bigSubViewSection: some View {
        VStack {
            NavigationLink(destination: PreRequirementsView()) {
                BigItemSubView(imageName: "requirementsUI", text: "Requirements", description: "These are pre-requisites you should know for better Umrah Experience")
            }
            NavigationLink(destination: UmrahGuideView()) {
                BigItemSubView(imageName: "umrahguideUI", text: "Umrah Guide", description: "Here you will find the neccessary steps of umrah")
            }
        }
        .padding(.horizontal, 10)
    }
    private var otherElements: some View {
        VStack(spacing: 15) {
            HStack(spacing: 20) {
                NavigationLink(destination: ShowAllPackagesView()) {
                    itemsSubView(imageName: "package", textShow: "All Packages")
                }
                NavigationLink(destination: CustomPackageView()) {
                    itemsSubView(imageName: "custom", textShow: "Custom Pkg")
                }
                NavigationLink(destination: LocationView()) {
                    itemsSubView(imageName: "navigation", textShow: "Navigation")
                }
            }
            HStack(spacing: 20) {
                NavigationLink(destination: DuasView()) {
                    itemsSubView(imageName: "DuaUI", textShow: "Dua's")
                }
                NavigationLink(destination: HadithsView()) {
                    itemsSubView(imageName: "HadithUI", textShow: "Hadiths")
                }
                NavigationLink(destination: TasbihCounterView()) {
                    itemsSubView(imageName: "TasbihUI", textShow: "Tasbih")
                }
            }
            
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .font(.caption)
        .bold()
        .cornerRadius(10)
    }
    
    private var showPackagesSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Packages")
                    .padding(.top, 5)
                    .padding(.leading)
                    .font(.title)
                    .bold()
                
                Spacer()
                
                NavigationLink("View All", destination: ShowAllPackagesView())
                    .font(.headline)
                    .padding(.top, 5)
                    .padding(.trailing)
            }
            .padding(.bottom, -3)

            if fm.isLoading {
                HStack {
                    Spacer()
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.3)
                        .padding()
                    Spacer()
                }
                .frame(height: 200)
            } else {
                if fm.packages.isEmpty {
                    Text("No packages found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    packagesList
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var packagesList: some View {
        List(fm.packages.prefix(3)) { package in
            Button(action: {
                selectedPackage = package
                showPackageDetailSheet = true
            }) {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(package.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            VStack(alignment: .leading) {
                                Text("Duration: \(package.days) days")
                                Text("Price: \(package.price, specifier: "%.2f") PKR")
                            }
                            .font(.caption)
                            Text("Itinerary")
                                .fontWeight(.medium)
                            VStack(alignment: .leading) {
                                Text("• First \(package.firstDays) days in Makkah")
                                Text("• Next \(package.nextDays) days in Madina")
                                Text("• Last \(package.lastDays) days back in Makkah")
                            }
                            .font(.caption)
                        }
                        Spacer()
                        Image("logoPng")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .opacity(0.1)
                            .padding(.trailing, 10)
                            .cornerRadius(30)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.black)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
            }
        }
        .frame(height: 500)
        .listStyle(PlainListStyle())
        .sheet(item: $selectedPackage) { package in
            PackageDetailView(item: package)
        }
    }
    
    private var whatsAppButton: some View {
        Button(action: {
            whtspVM.openWhatsApp()
        }) {
            Image("whatsappUI")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(5)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)
                .padding()
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    withAnimation {
                        isAnimating = true
                    }
                }
        }
    }
    
}

