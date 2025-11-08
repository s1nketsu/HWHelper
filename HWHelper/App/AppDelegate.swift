@_exported import CoreLibrary
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: Window?
    var themedWindow: ThemedWindow?
}

extension AppDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let windowScene = application.connectedScenes.first as? UIWindowScene else { return false }
        
        themedWindow = .init(windowScene: windowScene)
        themedWindow?.makeKey()
        
        window = .init(
            windowScene: windowScene,
            root: TabBarController()
        )
        
        return true
    }
}

extension AppDelegate {
    
    static var main: AppDelegate { UIApplication.shared.delegate as? AppDelegate ?? AppDelegate() }
    static var windowScene: UIWindowScene? { main.window?.windowScene }
}
