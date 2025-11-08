import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTabs()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        UITabBar.appearance().tintColor = .label
        UITabBar.appearance().unselectedItemTintColor = .tertiaryLabel
    }
    
    private func setupTabs() {
        viewControllers = Tabs.allCases.map { tab in
            let controller = tab.viewController
            controller.tabBarItem = tab.tabBarItem
            
            return controller
        }
    }
}
