import UIKit

final class MainHeaderView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        
        view.font = .systemFont(ofSize: 14)
        view.textColor = .secondaryLabel
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Common Init
    
    private func commonInit() {        
        addSubview(titleLabel)
        titleLabel.layout(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor,
            bottomAnchor: bottomAnchor,
            offset: .init(vertical: 2, horizontal: 16)
        )
    }
}
