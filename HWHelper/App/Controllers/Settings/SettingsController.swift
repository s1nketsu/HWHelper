import UIKit

final class SettingsController: ViewController {
    
    // MARK: - VM
    
    private let viewModel = ViewModel()
    
    private lazy var bind: Void = { [weak self] in
        self?.viewModel.reloadData = { [weak self] in self?.setupContent() }
    }()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.delegate = self
        
        view.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.reuseIdentifier)
        
        return view
    }()
    
    private lazy var dataSource = dataSource(tableView: tableView)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bind
        
        setupNavigation()
        setupViews()
        setupContent()
    }
    
    // MARK: - Setup
    
    private func setupNavigation() {
        largeNavigationTitle = true
        
        title = "Настройки"
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.layout(
            topAnchor: view.topAnchor,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor,
            bottomAnchor: view.bottomAnchor
        )
    }
    
    private func setupContent() {
        applySnapshot(dataSource: dataSource, rows: viewModel.rows)
    }
    
    func showSelectTheme() {
        Alert.show(
            title: "Выберите тему приложения",
            prefferedStyle: .actionSheet,
            actions: [
                .init(title: "Светлая") { [weak self] _ in self?.viewModel.selectTheme(.light) },
                .init(title: "Темная") { [weak self] _ in self?.viewModel.selectTheme(.dark) },
                .init(title: "Системная") { [weak self] _ in self?.viewModel.selectTheme(.system) },
            ],
            on: self
        )
    }
}

extension SettingsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellKind = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch cellKind {
        case .theme:
            showSelectTheme()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
