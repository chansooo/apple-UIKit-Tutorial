//
//  ReminderListViewController.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/16.
//

import Foundation
import UIKit

class ReminderListViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguartion = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguartion.showsSeparators = false
        listConfiguartion.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguartion)
    }
}
