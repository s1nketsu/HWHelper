import UIKit

enum Theme: Int {
    
    case light
    case dark
    case system
    
    static var current: Theme { .init(rawValue: Settings.shared.theme) ?? .light }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        case .system:
            AppDelegate.main.themedWindow?.traitCollection.userInterfaceStyle ?? .light
        }
    }
    
//    var stringValue: String {
//        switch self {
//        case .light:
//            "Light".localized
//        case .dark:
//            "Dark".localized
//        case .system:
//            "System".localized
//        }
//    }
    
    func apply() {
        Settings.shared.theme = rawValue
        
        AppDelegate.windowScene?.windows
            .filter { $0 != AppDelegate.main.themedWindow }
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}
