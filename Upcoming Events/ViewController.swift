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
    var events: [Event] = []
    let cellIdentifier = "eventCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = eventAPI.events.sorted{ $0.startDateTime < $1.startDateTime }
//        print(events)
        
        for event in events {
            print(event.title)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCell
        cell.title.text = events[indexPath.row].title
        cell.time.text = getTime(events[indexPath.row])
        return cell
    }
    
    func getTime(_ event: Event) -> String {
        let start = DateFormatter.timeFormatter.string(from: event.startDateTime)
        let end = DateFormatter.timeFormatter.string(from: event.endDateTime)
        
        return "\(start) - \(end)"
    }
    
}

extension ViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let isThird = indexPath.row.isMultiple(of: 3)
        
        if isThird {
            return CGSize(width: collectionView.visibleSize.width, height: 100)
        }
        else {
            return CGSize(width: collectionView.visibleSize.width / 2.2, height: 100)
        }
    }
}

