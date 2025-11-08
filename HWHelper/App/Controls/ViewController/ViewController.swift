import UIKit

open class ViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
            Theme.current.apply()
        }
    }
}
