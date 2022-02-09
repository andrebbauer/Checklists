import UIKit

class ChecklistItem: NSObject, Codable {
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
}
