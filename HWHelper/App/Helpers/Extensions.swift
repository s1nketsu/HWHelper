import UIKit

extension UIContextualAction {
    
    convenience init(
        title: String? = nil,
        image: UIImage? = nil,
        backgroundColor: UIColor? = nil,
        style: UIContextualAction.Style = .normal,
        handler: @escaping UIContextualAction.Handler
    ) {
        self.init(style: style, title: title, handler: handler)
        
        self.image = image
        self.backgroundColor = backgroundColor
    }
}
