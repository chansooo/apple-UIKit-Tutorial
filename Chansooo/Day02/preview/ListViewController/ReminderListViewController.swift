//
//  ViewController.swift
//  preview
//
//  Created by kimchansoo on 2022/08/16.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource : DataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView){ (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapShot = Snapshot()
        snapShot.appendSections([0])
        snapShot.appendItems(Reminder.sampleData.map{ $0.title })
        dataSource.apply(snapShot)
        
        collectionView.dataSource = dataSource
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listconfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listconfiguration.showsSeparators = false
        listconfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listconfiguration)
    }
}

