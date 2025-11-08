import UIKit

extension MainController {
    
    // MARK: - Sections
    
    enum Section: nonisolated Hashable {
        
        case pinned
        case groups
        case individuals
    }
    
    // MARK: - Rows
    
    enum Row: nonisolated Hashable {
        
        case item(MainItemDM)
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Row>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    func dataSource(tableView: UITableView) -> DataSource {
        .init(tableView: tableView) { tableView, indexPath, row in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DefaultTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? DefaultTableViewCell,
                  case .item(let model) = row else { preconditionFailure() }
            
            cell.titleLabel.text = model.title
            cell.subtitleLabel.isHidden = true
            
            return cell
        }
    }
    
    func applySnapshot(
        dataSource: DataSource,
        pinnedRows: [Row],
        groupRows: [Row],
        individualRows: [Row]
    ) {
        var snapshot = Snapshot()
        
        if !pinnedRows.isEmpty {
            snapshot.appendSections([.pinned])
            snapshot.appendItems(pinnedRows, toSection: .pinned)
        }
        
        if !groupRows.isEmpty {
            snapshot.appendSections([.groups])
            snapshot.appendItems(groupRows, toSection: .groups)
        }
        
        if !individualRows.isEmpty {
            snapshot.appendSections([.individuals])
            snapshot.appendItems(individualRows, toSection: .individuals)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
