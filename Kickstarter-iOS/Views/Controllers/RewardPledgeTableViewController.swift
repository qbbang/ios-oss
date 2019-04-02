import KsApi
import Library
import Prelude
import UIKit

enum RewardPledgeSection: CaseIterable {
  case project
  case inputs
  case summary
}

extension RewardPledgeSection {
  var rows: [RewardPledgeRow] {
    switch self {
    case .project:
      return [.description]
    case .inputs:
      return [.pledgeAmount, .shippingLocation]
    case .summary:
      return [.total]
    }
  }

  var numberOfRows: Int {
    return self.rows.count
  }
}

enum RewardPledgeRow: CaseIterable {
  case description
  case pledgeAmount
  case shippingLocation
  case total
}

extension RewardPledgeRow {
  var title: String {
    switch self {
    case .description:
      return "Description"
    case .pledgeAmount:
      return "Your pledge amount"
    case .shippingLocation:
      return "Your shipping location"
    case .total:
      return "Total"
    }
  }
}

class RewardPledgeTableViewController: UITableViewController {
  // MARK: - Properties

  private let viewModel: RewardPledgeViewModelType = RewardPledgeViewModel()

  // MARK: - Lifecycle

  static func instantiate() -> RewardPledgeTableViewController {
    return RewardPledgeTableViewController(style: .grouped)
  }

  func configure(with project: Project) {
    self.viewModel.inputs.configure(with: project)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    _ = self.tableView
      |> tableViewStyle

    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Footer")
  }

  // MARK: - UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return RewardPledgeSection.allCases.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RewardPledgeSection.allCases[section].numberOfRows
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = RewardPledgeSection.allCases[indexPath.section].rows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = row.title
    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard section < RewardPledgeSection.allCases.count - 1 else { return nil }

    let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Footer")
    return footerView
  }
}

// MARK: - Styles

private let tableViewStyle: TableViewStyle = { (tableView: UITableView) in
  tableView
    |> \.contentInset .~ UIEdgeInsets(top: -35)
    |> \.sectionFooterHeight .~ 10
    |> \.sectionHeaderHeight .~ 0
    |> \.separatorStyle .~ .none
}
