//
//  ReminderCollectionViewController+Actions.swift
//  Today
//
//  Created by Gordon Choi on 2022/08/18.
//

import UIKit

extension ReminderCollectionViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else {
            return
        }
        
        completeReminder(with: id)
    }
}
