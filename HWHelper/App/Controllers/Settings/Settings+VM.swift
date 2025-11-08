extension SettingsController {
    
    final class ViewModel {
        
        // MARK: - Closures
        
        var reloadData: (() -> ())?
        
        // MARK: - Properties
        
        var rows: [Row] {
            [
                .theme(.init(title: "Выбранная тема", subtitle: Theme.current.stringValue)),
            ]
        }
        
        // MARK: - Actions
        
        func selectTheme(_ theme: Theme) {
            theme.apply()
            reloadData?()
        }
    }
}
