import UIKit

enum Theme: Int, CaseIterable {
    
    case light
    case dark
    case system
    
    // MARK: - Properties
    
    static var current: Theme { .init(rawValue: Settings.shared.theme) ?? .light }
    
    var stringValue: String {
        switch self {
        case .light:
            "Светлая"
        case .dark:
            "Темная"
        case .system:
            "Системная"
        }
    }
    
    private var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        case .system:
            AppDelegate.main.themedWindow?.traitCollection.userInterfaceStyle ?? .light
        }
    }
    
    // MARK: - Actions
    
    func apply() {
        Settings.shared.theme = rawValue
        
        AppDelegate.windowScene?.windows
            .filter { $0 != AppDelegate.main.themedWindow }
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}
