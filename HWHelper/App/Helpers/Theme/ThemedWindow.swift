import UIKit

final class ThemedWindow: UIWindow {
    
//    convenience init() {
//        self.init()
//        
//        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { _, _ in
//            Theme.current.apply()
//        }
//    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        Theme.current.apply()
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
}
