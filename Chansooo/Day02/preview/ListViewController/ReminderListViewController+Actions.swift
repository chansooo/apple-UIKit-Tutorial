//
//  ReminderListViewController+Actions.swift
//  preview
//
//  Created by kimchansoo on 2022/08/17.
//

import Foundation

extension ReminderListViewController {
    
    @objc func didPressDoneButton(_ sender: ReminderDoneButton){
        guard let id = sender.id else{ return }
        completeReminder(with: id)
    }
}
