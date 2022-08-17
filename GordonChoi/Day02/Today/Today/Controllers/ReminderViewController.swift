//
//  ReminderViewController.swift
//  Today
//
//  Created by Gordon Choi on 2022/08/18.
//

import UIKit

final class ReminderViewController: UICollectionViewController {
    var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false

        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
