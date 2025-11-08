import UIKit

enum Tabs: Int, CaseIterable {
    
    case main
    case settings
}

extension Tabs {
    
    var viewController: UIViewController {
        switch self {
        case .main:
            UINavigationController(rootViewController: MainController())
        case .settings:
            UINavigationController(rootViewController: SettingsController())
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
        case .settings:
            .init(
                title: "Настройки",
                image: .init(systemName: "gear"),
                tag: rawValue
            )
        }
    }
}
