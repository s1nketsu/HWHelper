import UIKit

enum AppTheme {
    
    // MARK: - Properties
    
    static var current: Theme { themesContainer.first { $0.rawValue == Settings.shared.theme } ?? .system }
    
    private static var themesContainer: [Theme] {
        [
            .light,
            .dark,
            .system,
        ]
    }
    
    // MARK: - Actions
    
    static func updateTheme(_ theme: Theme) {
        Settings.shared.theme = theme.rawValue
        
        apply()
    }
    
    static func apply() {
        AppDelegate.windowScene?.windows
            .filter { $0 != AppDelegate.main.themedWindow }
            .forEach { $0.overrideUserInterfaceStyle = current.userInterfaceStyle }
    }
}

// MARK: - System Theme

extension Theme {
    
    static let system = Self(
        rawValue: "system",
        name: "Системная",
        userInterfaceStyle: AppDelegate.main.themedWindow?.traitCollection.userInterfaceStyle ?? .light
    )
}
