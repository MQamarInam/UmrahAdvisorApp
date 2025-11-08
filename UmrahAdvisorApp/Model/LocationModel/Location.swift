//
//  Location.swift
//  mapApp
//
//  Created by Macbook Pro on 16/04/2024.
//

import Foundation
import MapKit

struct LocationDetailData {
    let title: String
    let description: [String]
}

struct Location : Identifiable, Equatable{
    
    let locationNumber: String
    let name : String
    let cityName: String
    let coordinates : CLLocationCoordinate2D
    let LocationDetailData : [LocationDetailData]
    let imageNames : [String]
    var id: String {
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
