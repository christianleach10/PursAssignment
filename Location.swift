//
//  Location.swift
//  BeastroApp
//
//  Created by Christian Leach on 6/5/24.
//

import Foundation

struct Location: Codable {
    let locationName: String
    let hours: [BusinessHours]

    enum CodingKeys: String, CodingKey {
        case locationName = "location_name"
        case hours
    }
}


