import Foundation

extension SettingsController {
    
    struct SettingsItemDM {
        
        let id = UUID().uuidString
        
        let title: String
        let subtitle: String?
    }
}

extension SettingsController.SettingsItemDM: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (rhs: Self, lhs: Self) -> Bool {
        rhs.id == lhs.id
    }
}
