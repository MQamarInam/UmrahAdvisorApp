//
//  PackageDetailView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 13/07/2024.
//

import SwiftUI

struct PackageDetailView: View {
    
    var item: Packages
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    imageSection
                    headingSection
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        DurationSection
                        ItinerarySection
                        AccommodationSection
                        roomTypeSection
                        transportationSection
                        airlineSection
                        
                    }
                    .padding(.horizontal)
                    
                    bookBTNSection
                        
                }
                .padding()
            }
        }
    }
}

#Preview {
    PackageDetailView(item: Packages(
        id: UUID().uuidString,
        name: "No Name",
        price: 0.0,
        days: 0,
        isHot: false,
        
        firstDays: 0,
        nextDays: 0,
        lastDays: 0,
        
        makkahHotel: "No Hotel",
        madinahHotel: "No Hotel",
        
        roomTypes: "No Room",
        
        transportType: "No Transport",
        
        flightName: "No Flight",
        departure: FlightDetail(sector: "No Sector", date: Date(), time: Date(), baggage: "No Baggage"),
        arrival: FlightDetail(sector: "No Sector", date: Date(), time: Date(), baggage: "No Baggage")
    ))
}

extension PackageDetailView  {
    
    private var imageSection: some View {
        Image("loginbg")
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .cornerRadius(15)
            .padding(.bottom, 5)
    }
    
    private var headingSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Price: \(item.price, specifier: "%.1f") Pkr")
                .font(.title2)
                .foregroundColor(.green)
        }
        .padding(.horizontal)
    }
    
    private var DurationSection: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text("Duration")
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("• \(item.days) Days")
            }
            .padding(.leading, 20)
        }
    }
    
    private var ItinerarySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "map")
                    .foregroundColor(.blue)
                Text("Itinerary")
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("• First \(item.firstDays) days in Makkah")
                Text("• Next \(item.nextDays) days in Madina")
                Text("• Last \(item.lastDays) days back in Makkah")
            }
            .padding(.leading, 20)
        }
    }
    
    private var AccommodationSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "house.fill")
                    .foregroundColor(.blue)
                Text("Accommodation")
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
                    Text("• Makkah Hotel")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(item.makkahHotel)")
                }
                HStack(alignment: .top) {
                    Text("• Madina Hotel")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(item.madinahHotel)")
                }
            }
            .padding(.leading, 20)
        }
    }
    
    private var roomTypeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "bed.double.fill")
                    .foregroundColor(.blue)
                Text("Room Type")
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("• \(item.roomTypes)")
            }
            .padding(.leading, 30)
        }
    }
    
    private var transportationSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "car.fill")
                    .foregroundColor(.blue)
                Text("Transportation")
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("• \(item.transportType)")
            }
            .padding(.leading, 30)
        }
    }
    
    private var airlineSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "airplane.departure")
                    .foregroundColor(.blue)
                Text("Airline")
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            VStack(alignment: .leading, spacing: 12) {
                Text("\(item.flightName)")
                HStack(alignment: .top) {
                    Text("• Departure")
                        .bold()
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(item.departure.sector)
                        Text("\(item.departure.date.formatted(date: .numeric, time: .omitted)) \(item.departure.time.formatted(date: .omitted, time: .shortened))")
                        Text("Baggage \(item.departure.baggage)")
                    }
                }
                HStack(alignment: .top) {
                    Text("• Arrival")
                        .bold()
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(item.arrival.sector)
                        Text("\(item.arrival.date.formatted(date: .numeric, time: .omitted)) \(item.arrival.time.formatted(date: .omitted, time: .shortened))")
                        Text("Baggage \(item.arrival.baggage)")
                    }
                }
            }
            .padding(.leading, 30)
        }
    }
    
    private var bookBTNSection: some View {
        NavigationLink(destination: ContentView()) {
            Text("BOOK NOW")
                .padding(10)
                .foregroundColor(.white)
                .bold()
                .font(.headline)
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .cornerRadius(10)
        }
    }
    
}
