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
    
    let eventsAPI       = EventsAPI.shared
    var eventsByDate    = [[Event]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsByDate = eventsAPI.eventsByDate
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        guard let navBar    = self.navigationController?.navigationBar else { return }
        navBar.barTintColor = Color.headerColor
        navBar.titleTextAttributes      = [NSAttributedString.Key.foregroundColor: Color.headerTextColor!]
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.headerTextColor!]
    }
}

// MARK: Collection View Methods
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventsByDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsByDate[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier,
                                                      for: indexPath) as! EventCell
        let event = eventsByDate[indexPath.section][indexPath.row]
        cell.updateAppearence(for: event)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constant.headerIdentifier,
                                                                             for: indexPath) as! EventHeaderView
            let event = eventsByDate[indexPath.section][indexPath.row]
            headerView.title.text = event.startDateTime.toString(with: Constant.headerMonth)
            return headerView
        }
        return UICollectionReusableView()
    }
}

// MARK: Flow Layout Methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width * Constant.eventCellWidthFactor
        return CGSize(width: cellWidth,
                      height: Constant.eventCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width,
                      height: Constant.eventHeaderHeight)
    }
}
