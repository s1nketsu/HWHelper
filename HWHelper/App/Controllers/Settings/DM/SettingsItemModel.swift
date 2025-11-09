import Foundation

extension SettingsController {
    
    struct SettingsItemModel {
        
        let id = UUID().uuidString
        
        let title: String
        let subtitle: String?
    }
}

extension SettingsController.SettingsItemModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (rhs: Self, lhs: Self) -> Bool {
        rhs.id == lhs.id
    }
}
