import UIKit

final class DefaultTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        view.spacing = 4
        view.axis = .vertical
        
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(subtitleLabel)
        
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 0)
        
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .label
        view.font = .systemFont(ofSize: 18)
        
        return view
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 16)
        
        return view
    }()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CommonInit
    
    private func commonInit() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(stackView)
        stackView.layout(
            topAnchor: contentView.topAnchor,
            leadingAnchor: contentView.leadingAnchor,
            trailingAnchor: contentView.trailingAnchor,
            bottomAnchor: contentView.bottomAnchor
        )
    }
}
