//
//  ReminderListViewController.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/16.
//

import Foundation
import UIKit

class ReminderListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguartion = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguartion.showsSeparators = false
        listConfiguartion.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguartion)
    }
}
