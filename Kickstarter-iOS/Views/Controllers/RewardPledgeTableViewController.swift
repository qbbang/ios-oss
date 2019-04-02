import KsApi
import Library
import Prelude
import UIKit

class RewardPledgeTableViewController: UITableViewController {
  // MARK: - Properties

  private let dataSource: RewardPledgeDataSource = RewardPledgeDataSource()
  private let viewModel: RewardPledgeViewModelType = RewardPledgeViewModel()

  // MARK: - Lifecycle

  static func instantiate() -> RewardPledgeTableViewController {
    return RewardPledgeTableViewController(style: .grouped)
  }

  func configure(with reward: Reward) {
    self.viewModel.inputs.configure(with: reward)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    _ = self.tableView
      |> tableViewStyle
      |> \.dataSource .~ self.dataSource

    self.tableView.register(RewardPledgeRowCell.self, forCellReuseIdentifier: "RewardPledgeRowCell")
    self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Footer")

    self.viewModel.inputs.viewDidLoad()
  }

  // MARK: - Bindings

  override func bindViewModel() {
    super.bindViewModel()

    self.viewModel.outputs.reward
      .observeForUI()
      .observeValues { [weak self] reward in
        self?.dataSource.load(reward: reward)
        self?.tableView.reloadData()
    }
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard section < self.dataSource.numberOfSections(in: self.tableView) - 1 else { return nil }

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
