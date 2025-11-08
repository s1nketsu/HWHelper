import UIKit

final class ThemedWindow: UIWindow {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        AppTheme.apply()
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
}
