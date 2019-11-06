//
//  ViewController.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/6/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let eventAPI = EventsAPI.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let events: [Event] = eventAPI.events.sorted{ $0.startDateTime < $1.startDateTime }
//        print(events)
        
        for event in events {
            print(event.title)
        }
    }


}

