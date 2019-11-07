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
        self.layer.borderWidth = Constant.dateHeaderBorderWidth
        self.layer.borderColor = Color.dateHeaderOutline?.cgColor
    }
}
