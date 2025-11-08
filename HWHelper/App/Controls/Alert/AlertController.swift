import UIKit

final class AlertController: UIAlertController {
    
    static func show(
        title: String? = nil,
        message: String? = nil,
        prefferedStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = [],
        sourceItem: UIBarButtonItem? = nil,
        on controller: UIViewController?
    ) {
        let alert = Self(title: title, message: message, preferredStyle: prefferedStyle)
        
        actions.forEach { action in
            alert.addAction(action)
        }
        
        let defaultTitle = actions.isEmpty ? "ОK" : "Отмена"
        let defaultStyle: UIAlertAction.Style = actions.isEmpty ? .default : .cancel
        
        alert.addAction(
            .init(title: defaultTitle, style: defaultStyle)
        )
        
        controller?.popoverPresentationController?.sourceItem = sourceItem
        controller?.present(alert, animated: true)
    }
    
    static func showSuccess(
        title: String? = nil,
        message: String? = nil,
        on controller: UIViewController?
    ) {
        show(
            title: title ?? "Готово",
            message: message,
            on: controller
        )
    }
}
