import UIKit

extension SettingsController {
    
    // MARK: - Sections
    
    enum Section: nonisolated Hashable {
        
        case main
    }
    
    // MARK: - Rows
    
    enum Row: nonisolated Hashable {
        
        case theme(SettingsItemDM)
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Row>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    func dataSource(tableView: UITableView) -> DataSource {
        .init(tableView: tableView) { tableView, indexPath, row in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsCell.reuseIdentifier,
                for: indexPath
            ) as? SettingsCell else { preconditionFailure() }
            
            switch row {
            case .theme(let model):
                cell.titleLabel.text = model.title
                cell.subtitleLabel.text = model.subtitle
            }
            
            return cell
        }
    }
    
    func applySnapshot(dataSource: DataSource, rows: [Row]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(rows, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
