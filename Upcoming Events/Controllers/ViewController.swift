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
    let headerIdentifier = "headerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = eventAPI.events.sorted { $0.startDateTime < $1.startDateTime }
        eventsByDate = eventAPI.bucketEventsByDay(events)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.headerTextColor!]
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventsByDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsByDate[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCell
        let event = eventsByDate[indexPath.section][indexPath.row]
        cell.title.text = event.title
        cell.time.text = getTime(event)
        return cell
    }
    
    func getTime(_ event: Event) -> String {
        let start = event.startDateTime.toString(dateFormat: "h:mm a")
        let end   = event.endDateTime.toString(dateFormat: "h:mm a")
        return "\(start) - \(end)"
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: headerIdentifier,
                                                                             for: indexPath) as! EventHeaderView
            let event = eventsByDate[indexPath.section][indexPath.row]
            let day = event.startDateTime.toString(dateFormat: "MMM d")
            headerView.title.text = day
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.85, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: CGFloat(30))
    }
}
