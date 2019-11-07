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
    var eventsByDate         = [[Event]]()
    
    private init()? {
        guard let url = Bundle.main.url(forResource: Constant.filename,
                                        withExtension: Constant.fileExtension),
            let data = try? Data(contentsOf: url) else { return }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatter)
        guard let events = try? decoder.decode([Event].self, from: data) else { return }
        self.eventsByDate = groupEventsByDay(events)
    }
    
    func groupEventsByDay(_ events: [Event]) -> [[Event]] {
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
                eventsForTheDay.append(markConflictingEvents(temp))
                currentDate = eventDate
                temp = [event]
            }
        }
        eventsForTheDay.append(markConflictingEvents(temp))
        return eventsForTheDay
    }
    
    // Check if events are conflicting with each other
    func markConflictingEvents(_ events: [Event]) -> [Event] {
        var events = events
        for i in 0 ..< events.count - 1 {
            for j in i + 1 ..< events.count {
                if events[i].endDateTime > events[j].startDateTime {
                    events[i].conflicts = true
                    events[j].conflicts = true
                } else {
                    continue
                }
            }
        }
        return events
    }
}
