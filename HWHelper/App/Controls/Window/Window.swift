import UIKit

final class Window: UIWindow {
    
    init(
        windowScene: UIWindowScene,
        root: UIViewController
    ) {
        super.init(windowScene: windowScene)
        
        self.rootViewController = root
        makeKeyAndVisible()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
