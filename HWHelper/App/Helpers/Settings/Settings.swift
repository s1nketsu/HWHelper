import Foundation

final class Settings {
    
    static let shared = Settings()
    static let container = UserDefaults.standard
   
    // MARK: - Keys
    
    static let themeKey = "themeKey"
    
    // MARK: - Values
    
    @Settings.Value(key: themeKey)
    var theme: String = "system"
    
    // MARK: - Init
    
    private init() { }
}
