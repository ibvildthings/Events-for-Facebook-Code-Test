//
//  ViewController.swift
//  Upcoming Events
//
//  Created by Pritesh Desai on 11/6/19.
//  Copyright © 2019 Pritesh Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let eventAPI = EventsAPI.shared
    var events = [Event]()
    var eventsByDate: [[Event]] = [[]]
    let cellIdentifier = "eventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = eventAPI.events.sorted{ $0.startDateTime < $1.startDateTime }
        eventsByDate = bucketEventsByDay(events)
    }
    
    
    fileprivate func bucketEventsByDay(_ events: [Event]) ->[[Event]]{
        let calendar = Calendar.current
        var currentDate = calendar.dateComponents([.day], from:events.first!.startDateTime).day
        
        var eventForDay = [Event]()
        var eventsByDate = [[Event]]()
        for event in events {
            let eventDate = calendar.dateComponents([.day], from:event.startDateTime).day
            
            if eventDate == currentDate {
                eventForDay.append(event)
            }
            else {
                eventsByDate.append(eventForDay)
                currentDate = eventDate
                eventForDay = []
            }
        }
        eventsByDate.append(eventForDay)
        return eventsByDate
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventsByDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsByDate[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCell
        let event = eventsByDate[indexPath.section][indexPath.row]
        cell.title.text = event.title
        cell.time.text = getTime(event)
        return cell
    }
    
    func getTime(_ event: Event) -> String {
        let start = DateFormatter.timeFormatter.string(from: event.startDateTime)
        let end   = DateFormatter.timeFormatter.string(from: event.endDateTime)
        
        return "\(start) - \(end)"
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! EventHeaderView
            let event = eventsByDate[indexPath.section][indexPath.row]
            let day = event.startDateTime.toString(dateFormat: "MMM d")
            headerView.title.text = day
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension ViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
        if indexPath.row.isMultiple(of: 3) {
            return CGSize(width: collectionView.visibleSize.width, height: 100)
        }
        else {
            return CGSize(width: collectionView.visibleSize.width / 2.2, height: 100)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                     layout collectionViewLayout: UICollectionViewLayout,
//                     referenceSizeForHeaderInSection section: Int) -> CGSize{
//        return CGSize(width: collectionView.frame.size.width, height: CGFloat(80)) // you can change here
//    }
    
}

