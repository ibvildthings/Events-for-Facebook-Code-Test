//
//  Event.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/6/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import Foundation

struct Event: Codable {
    var title: String
    var startDateTime: Date
    var endDateTime: Date
    
    enum CodingKeys: String, CodingKey {
        case title, startDateTime = "start", endDateTime = "end"
    }
}
