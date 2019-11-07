//
//  Constants.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/7/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import UIKit

enum Constant {
    static let filename = "datasource"
    static let appName  = "🎊 Events"
    
    static let eventCellHeight: CGFloat = 90
    static let eventHeaderHeight: CGFloat = 30
    
    static let onlyTime    = "h:mm a"
    static let headerMonth = "MMM d"
}

enum Color {
    static let eventBackgroundColor = UIColor(named: "Event Background")
    static let dateHeaderOutline    = UIColor(named: "Date Header Outline")
    static let headerColor          = UIColor(named: "Header")
    static let headerTextColor      = UIColor(named: "Header Text")
}
