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
    var eventsGroupedByDate  = [[Event]]()
    
    private init?() {
        guard let url = Bundle.main.url(forResource: Constant.filename,
                                        withExtension: Constant.fileExtension),
            let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormatter)
        guard let events = try? decoder.decode([Event].self, from: data) else { return nil }
        self.eventsGroupedByDate = groupEventsByDay(events)
    }
    
//    Takes in an unsorted events list and groups events taking place on the same day.
//    The sorting algorithm takes O(n log n)
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
    
//     Given a sorted list, check if events are conflicting with each other.
//    This runs in O(n).
    func markConflictingEvents(_ events: [Event]) -> [Event] {
        var events = events
        guard var latestEndingEventTime = events.first?.endDateTime else { return [] }
        
        for i in 1 ..< events.count {
            if latestEndingEventTime > events[i].startDateTime {
                events[i].conflicts = true
                events[i-1].conflicts = true
                latestEndingEventTime = max(latestEndingEventTime, events[i].endDateTime)
                continue
            }
            latestEndingEventTime = events[i].endDateTime
        }
        return events
    }
}
