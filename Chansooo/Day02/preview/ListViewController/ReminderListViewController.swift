//
//  ViewController.swift
//  preview
//
//  Created by kimchansoo on 2022/08/16.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    var dataSource : DataSource!
    var reminders: [Reminder] = Reminder.sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView){ (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        updateSnapShot()
        
        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listconfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listconfiguration.showsSeparators = false
        listconfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listconfiguration)
    }
}

