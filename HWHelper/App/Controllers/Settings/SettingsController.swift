import UIKit

final class SettingsController: ViewController {
    
    // MARK: - VM
    
    private let viewModel = ViewModel()
    
    private lazy var bind: Void = {
        viewModel.reloadData = { [weak self] in
            guard let self else { return }
            
            applySnapshot(dataSource: dataSource, rows: viewModel.rows)
        }
    }()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.delegate = self
        
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var dataSource = dataSource(tableView: tableView)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = bind
        
        setupNavigation()
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "Настройки"
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        applySnapshot(dataSource: dataSource, rows: viewModel.rows)
    }
    
    func showSelectTheme(sourceView: UIView) {
        AlertController
            .show(
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
        guard let cellKind = dataSource.itemIdentifier(for: indexPath),
              let sourceView = tableView.cellForRow(at: indexPath)?.contentView else { return }
        
        switch cellKind {
        case .theme:
            showSelectTheme(sourceView: sourceView)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
