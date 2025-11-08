import Foundation

extension MainController {
    
    struct MainItemDM {
        
        let id = UUID().uuidString
        let title: String
    }
}

extension MainController.MainItemDM: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (rhs: Self, lhs: Self) -> Bool {
        rhs.id == lhs.id
    }
}
