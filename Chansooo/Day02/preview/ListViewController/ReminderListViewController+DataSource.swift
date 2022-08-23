//
//  ReminderListViewController+DataSource.swift
//  preview
//
//  Created by kimchansoo on 2022/08/17.
//

import Foundation
import UIKit

//ListViewController의 DataSource 관련된 부분 모아서 정리

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder Completed value")
    }
    
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not Completed", comment: "Reminder not completed value")
    }
    
    private var reminderStore: ReminderStore { ReminderStore.shared }
    
    func updateSnapShot(reloading idsThatChanged: [Reminder.ID] = []) {
        let ids = idsThatChanged.filter{ id in filteredReminders.contains(where: { $0.id == id})}
        var snapShot = Snapshot()
        snapShot.appendSections([0])
        snapShot.appendItems(filteredReminders.map{ $0.id})
        if !ids.isEmpty {
            snapShot.reloadItems(ids)
        }
        dataSource.apply(snapShot)
        headerView?.progress = progress
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID){
        let reminder = reminder(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
        
    }
    
    func completeReminder(with id: Reminder.ID){
        var reminder = reminder(for: id)
        reminder.isComplete.toggle()
        update(reminder, with: id)
        updateSnapShot(reloading: [id])
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Togle Completion", comment: "Reminder done button acccessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(with: reminder.id)
            return true
        }
        return action
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    func prepareReminderStore() {
        Task {
            do {
                try await reminderStore.requestAccess()
                reminders = try await reminderStore.readAll()
                NotificationCenter.default.addObserver(self, selector: #selector(eventStorechanged(_:)), name: .EKEventStoreChanged, object: nil)
            } catch TodayError.accessDenied, TodayError.accessRestricted {
                #if DEBUG
                reminders = Reminder.sampleData
                #endif
            } catch {
                showError(error)
            }
            updateSnapShot()
        }
    }
    
    func reminderStoreChanged() {
        Task {
            reminders = try await reminderStore.readAll()
            updateSnapShot()
        }
    }
    
    func add(_ reminder: Reminder) {
        var reminder = reminder
        do {
            let idFromStore = try reminderStore.save(reminder)
            reminder.id = idFromStore
            reminders.append(reminder)
        } catch TodayError.accessDenied {
        } catch {
            showError(error)
        }
    }
    
    func deleteReminder(with id: Reminder.ID) {
        do {
            try reminderStore.remove(with: id)
            let index = reminders.indexOfReminder(with: id)
            reminders.remove(at: index)
        } catch TodayError.accessDenied {
        } catch {
            showError(error)
        }
    }
    
    func reminder(for id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(with: id)
        return reminders[index]
    }
    
    func update(_ reminder: Reminder, with id: Reminder.ID) {
        let index = reminders.indexOfReminder(with: id)
        reminders[index] = reminder
    }
}
