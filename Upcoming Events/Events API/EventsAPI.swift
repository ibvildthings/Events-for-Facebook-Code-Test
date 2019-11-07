//
//  EventsAPI.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/6/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import Foundation

class EventsAPI {
    public static var shared = EventsAPI()
    var fileName             = Constant.filename
    var events               = [Event]()
    var eventsByDate         = [[Event]]()
    
    private init() {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else { return }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatter)
        guard let jsonData = try? decoder.decode([Event].self, from: data) else { return }
        self.events = jsonData
        self.eventsByDate = bucketEventsByDay(events)
    }
    
    func bucketEventsByDay(_ events: [Event]) -> [[Event]] {
        let sortedEvents    = events.sorted { $0.startDateTime < $1.startDateTime }
        let calendar        = Calendar.current
        var currentDate     = calendar.dateComponents([.day], from: sortedEvents.first!.startDateTime).day
        var temp            = [Event]()
        var eventsForTheDay = [[Event]]()
        
        for event in sortedEvents {
            let eventDate = calendar.dateComponents([.day], from: event.startDateTime).day
            
            if eventDate == currentDate {
                temp.append(event)
            } else {
                eventsForTheDay.append(temp)
                currentDate = eventDate
                temp = [event]
            }
        }
        eventsForTheDay.append(temp)
        return eventsForTheDay
    }
}
