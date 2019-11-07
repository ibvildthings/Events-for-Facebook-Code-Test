//
//  EventCell.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/6/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = Constant.eventCornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = Color.eventBackgroundColor
    }
    
    func updateAppearence(for event: Event) {
        self.title.text = event.title
        if event.conflicts {
            self.time.text  = Constant.conflictSymbol + getTime(event)
            self.time.textColor = .systemRed
        } else {
            self.time.text  = getTime(event)
            self.time.textColor = Color.eventTextSecondaryColor
        }
    }
    
    func getTime(_ event: Event) -> String {
        let start = event.startDateTime.toString(with: Constant.onlyTime)
        let end   = event.endDateTime.toString(with: Constant.onlyTime)
        return "\(start) to \(end)"
    }
}
