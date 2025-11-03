import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    // MARK: - Setup
    
    private func setupTabs() {
        viewControllers = Tabs.allCases.map { tab in
            let controller = tab.viewController
            controller.tabBarItem = tab.tabBarItem
            
            return controller
        }
    }
}
