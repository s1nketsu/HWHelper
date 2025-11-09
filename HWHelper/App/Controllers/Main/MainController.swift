import UIKit

private extension Constants {
    
    static let rowHeight: CGFloat = 60
}

final class MainController: ViewController {
    
    // MARK: - VM
    
    private let viewModel = ViewModel()
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        
        view.delegate = self
        view.rowHeight = Constants.rowHeight
        
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
        
        viewModel.fetchData()
    }
    
    // MARK: - Setup
    
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
    
    // MARK: - Actions
    
    @objc
    private func addTemplate() {
        viewModel.createMock()
    }
    
    private func openEditStudent(model: StudentModel) {
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
        header.titleLabel.text = sectionKind.headerTitle
        
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
                    self?.viewModel.updatePin(false, model: model)
                    completion(true)
                },
            ])
        case .groups,
             .individuals:
            return .init(actions: [
                .init(image: .init(systemName: "pin"), backgroundColor: .systemBlue) { [weak self] _, _, completion in
                    self?.viewModel.updatePin(true, model: model)
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
        case .pinned,
             .groups,
             .individuals:
            return .init(actions: [
                .init(image: .init(systemName: "trash"), style: .destructive) { [weak self] _, _, completion in
                    self?.viewModel.deleteStudent(model: model)
                    completion(true)
                },
                .init(image: .init(systemName: "pencil.line"), backgroundColor: .systemOrange) { [weak self] _, _, completion in
                    self?.openEditStudent(model: model)
                    completion(true)
                },
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
