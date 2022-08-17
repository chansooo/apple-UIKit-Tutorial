//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/17.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(with: id)
    }
}
