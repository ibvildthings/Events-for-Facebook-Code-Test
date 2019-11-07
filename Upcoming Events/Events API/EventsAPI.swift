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
    var fileName = Constant.datasource
    var events: [Event] = []
    
    private init() {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatter)
        guard let jsonData = try? decoder.decode([Event].self, from: data) else { return }
        self.events = jsonData
    }
    
    func bucketEventsByDay(_ events: [Event]) -> [[Event]] {
        let calendar = Calendar.current
        var currentDate = calendar.dateComponents([.day], from: events.first!.startDateTime).day
        
        var eventForDay = [Event]()
        var eventsByDate = [[Event]]()
        for event in events {
            let eventDate = calendar.dateComponents([.day], from: event.startDateTime).day
            
            if eventDate == currentDate {
                eventForDay.append(event)
            } else {
                eventsByDate.append(eventForDay)
                currentDate = eventDate
                eventForDay = [event]
            }
        }
        eventsByDate.append(eventForDay)
        return eventsByDate
    }
}
