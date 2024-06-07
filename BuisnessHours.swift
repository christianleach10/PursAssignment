//
//  BuisnessHours.swift
//  BeastroApp
//
//  Created by Christian Leach on 6/5/24.
//

import Foundation

struct BusinessHours: Codable {
    let dayOfWeek: String
    let startLocalTime: String
    let endLocalTime: String

    enum CodingKeys: String, CodingKey {
        case dayOfWeek = "day_of_week"
        case startLocalTime = "start_local_time"
        case endLocalTime = "end_local_time"
    }
}


