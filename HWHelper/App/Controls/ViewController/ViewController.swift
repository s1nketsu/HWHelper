import UIKit

open class ViewController: BaseViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
            AppTheme.apply()
        }
    }
}
