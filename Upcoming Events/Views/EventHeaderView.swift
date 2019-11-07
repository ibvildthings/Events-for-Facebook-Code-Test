//
//  EventHeaderView.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/7/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import UIKit

class EventHeaderView: UICollectionReusableView {
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Date Header Outline")?.cgColor
    }
}
