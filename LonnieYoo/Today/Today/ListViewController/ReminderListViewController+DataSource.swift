//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by ByeongJu Yu on 2022/08/16.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    private var reminderStore: ReminderStore { ReminderStore.shared }
    
    /// 데이터가 변경되었을때 snapshot을 업데이트 시켜주고 dataSource에 적용하는 함수
    func updateSnapshot(reloading idsThatChanged: [Reminder.ID] = []) {
        let ids = idsThatChanged.filter { id in filteredReminders.contains(where: { $0.id == id }) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredReminders.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        headerView?.progress = progress
    }
    
    /// Cell을 CollectionView에 추가하기 위한 작업을 관리하는 함수
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        let reminder = reminder(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        // 완료버튼 설정 및 버튼 액션 추가
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [ doneButtonAccessibilityAction(for: reminder) ]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration),
            .disclosureIndicator(displayed: .always)
        ]
        
        // cell 배경색 지정
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    /// 미리알림의 상태를 변경하는 함수
    func completeReminder(with id: Reminder.ID) {
        var reminder = reminder(for: id)
        reminder.isComplete.toggle()
        update(reminder, with: id)
        updateSnapshot(reloading: [id])
    }
    
    /// VoiceOver를 추가하는 함수
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(with: reminder.id)
            return true
        }
        return action
    }
    
    /// 완료 버튼을 설정하는 함수
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "checkmark.circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        // 버튼의 이벤트와 액션 메서드를 연결
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
                NotificationCenter.default.addObserver(self, selector: #selector(eventStoreChanged(_:)), name: .EKEventStoreChanged, object: nil)
            } catch TodayError.accessDenied, TodayError.accessRestricted {
                #if DEBUG
                reminders = Reminder.sampleData
                #endif
            } catch {
                showError(error)
            }
            updateSnapshot()
        }
    }
    
    func reminderStoreChanged() {
        Task {
            reminders = try await reminderStore.readAll()
            updateSnapshot()
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
    
    /// reminders에서 해당 id의 미리 알림을 반환하는 메서드
    func reminder(for id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(with: id)
        return reminders[index]
    }
    
    /// reminders에서 매개변수로 전달 받은 reminder로  업데이트하는 메서드
    func update(_ reminder: Reminder, with id: Reminder.ID) {
        do {
            try reminderStore.save(reminder)
            let index = reminders.indexOfReminder(with: id)
            reminders[index] = reminder
        } catch TodayError.accessDenied {
        } catch {
            showError(error)
        }
    }
}
