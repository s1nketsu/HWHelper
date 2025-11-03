import UIKit

enum Tabs: Int, CaseIterable {
    
    case main
}

extension Tabs {
    
    var viewController: UIViewController {
        switch self {
        case .main:
            MainController()
        }
    }
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .main:
            .init(
                title: "Главная",
                image: .init(systemName: "house"),
                tag: rawValue
            )
        }
    }
}
