import UIKit

final class MainController: ViewController {
    
    // MARK: - VM
    
    private let viewModel = ViewModel()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        
        view.delegate = self
        view.rowHeight = Constants.defaultCellHeight
        
        view.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.reuseIdentifier)
        
        return view
    }()
    
    private lazy var bind: Void = { [weak self] in
        self?.viewModel.reloadData = { [weak self] in self?.setupContent() }
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
    
    private func setupNavigation() {
        largeNavigationTitle = true
        
        title = "Шаблоны"
        
        navigationItem.rightBarButtonItem = .init(
            image: .init(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addTemplate)
        )
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
        applySnapshot(
            dataSource: dataSource,
            pinnedRows: viewModel.pinnedRows,
            groupRows: viewModel.groupRows,
            individualRows: viewModel.individualRows
        )
    }
    
    @objc
    private func addTemplate() {
        print(#function)
    }
}

extension MainController: UITableViewDelegate {
    
    // MARK: - Header
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let sectionKind = dataSource.sectionIdentifier(for: section) else { return nil }
        
        let header = MainHeaderView()
        
        switch sectionKind {
        case .pinned:
            header.titleLabel.text = "Закрепленное"
        case .groups:
            header.titleLabel.text = "Группы"
        case .individuals:
            header.titleLabel.text = "Индивидуалы"
        }
        
        return header
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat { 28 }
    
    // MARK: - Swipe Actions
    
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard let sectionKind = dataSource.sectionIdentifier(for: indexPath.section),
              let cell = dataSource.itemIdentifier(for: indexPath),
              case .item(let model) = cell else { return nil }
        
        switch sectionKind {
        case .pinned:
            return .init(actions: [
                .init(image: .init(systemName: "pin.slash"), backgroundColor: .systemBlue) { [weak self] _, _, completion in
                    guard let self else { return }
                    
                    viewModel.pinnedRows.remove(at: indexPath.row)
                    setupContent()
                    
                    completion(true)
                },
            ])
        case .groups:
            return .init(actions: [
                .init(image: .init(systemName: "pin"), backgroundColor: .systemBlue) { [weak self] _, _, completion in
                    guard let self else { return }
                    
                    let data = viewModel.groupRows.remove(at: indexPath.row)
                    viewModel.pinnedRows.append(data)
                    setupContent()
                    
                    completion(true)
                },
            ])
        case .individuals:
            return .init(actions: [
                .init(image: .init(systemName: "pin"), backgroundColor: .systemBlue) { [weak self] _, _, completion in
                    guard let self else { return }
                    
                    let data = viewModel.individualRows.remove(at: indexPath.row)
                    viewModel.pinnedRows.append(data)
                    setupContent()
                    
                    completion(true)
                },
            ])
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard let sectionKind = dataSource.sectionIdentifier(for: indexPath.section),
              let cell = dataSource.itemIdentifier(for: indexPath),
              case .item(let model) = cell else { return nil }
        
        switch sectionKind {
        case .pinned:
            return .init(actions: [
                .init(image: .init(systemName: "trash"), style: .destructive) { [weak self] _, _, completion in
                    self?.viewModel.pinnedRows.remove(at: indexPath.row)
                    self?.setupContent()
                    
                    completion(true)
                },
                .init(image: .init(systemName: "pencil.line"), backgroundColor: .systemOrange) { [weak self] _, _, _ in },
            ])
        case .groups:
            return .init(actions: [
                .init(image: .init(systemName: "trash"), style: .destructive) { [weak self] _, _, completion in
                    self?.viewModel.groupRows.remove(at: indexPath.row)
                    self?.setupContent()
                    
                    completion(true)
                },
                .init(image: .init(systemName: "pencil.line"), backgroundColor: .systemOrange) { [weak self] _, _, _ in },
            ])
        case .individuals:
            return .init(actions: [
                .init(image: .init(systemName: "trash"), style: .destructive) { [weak self] _, _, completion in
                    self?.viewModel.individualRows.remove(at: indexPath.row)
                    self?.setupContent()
                    
                    completion(true)
                },
                .init(image: .init(systemName: "pencil.line"), backgroundColor: .systemOrange) { [weak self] _, _, _ in },
            ])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellKind = dataSource.itemIdentifier(for: indexPath),
              case .item(let model) = cellKind else { return }
        
        print("Жамнули ячейку - \(model.title)")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
