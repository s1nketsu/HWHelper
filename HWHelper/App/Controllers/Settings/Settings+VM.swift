extension SettingsController {
    
    final class ViewModel {
        
        // MARK: - Closures
        
        var reloadData: (() -> ())?
        
        // MARK: - Properties
        
        var rows: [Row] {
            [
                .theme(.init(title: "Выбранная тема", subtitle: AppTheme.current.name)),
            ]
        }
        
        // MARK: - Actions
        
        func selectTheme(_ theme: Theme) {
            AppTheme.updateTheme(theme)
            reloadData?()
        }
    }
}
