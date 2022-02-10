import UIKit

class ChecklistItem: NSObject, Codable {
    var text: String
    var checked: Bool
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    init(text: String, checked: Bool = false, shouldRemind: Bool, dueDate: Date) {
        self.text = text
        self.checked = checked
        self.itemID = DataModel.nextChecklistItemID()
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        super.init()
    }
    
    deinit {
        removeNotification()
    }
    
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: dueDate)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false)
            let request = UNNotificationRequest(
                identifier: "\(itemID)",
                content: content,
                trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
}
