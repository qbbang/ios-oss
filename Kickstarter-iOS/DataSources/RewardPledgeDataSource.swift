import Foundation
import KsApi
import Library

final class RewardPledgeDataSource: ValueCellDataSource {
  enum Section: Int {
    case project
    case inputs
    case summary
  }

  func load(reward: Reward) {
    self.appendRow(
      value: "Description",
      cellClass: RewardPledgeRowCell.self,
      toSection: Section.project.rawValue
    )

    self.appendRow(
      value: "Your pledge amount",
      cellClass: RewardPledgeRowCell.self,
      toSection: Section.inputs.rawValue
    )

    self.appendRow(
      value: "Your shipping location",
      cellClass: RewardPledgeRowCell.self,
      toSection: Section.inputs.rawValue
    )

    self.appendRow(
      value: "Total",
      cellClass: RewardPledgeRowCell.self,
      toSection: Section.summary.rawValue
    )
  }

  override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
    switch (cell, value) {
    case let (cell as RewardPledgeRowCell, value as String):
      cell.configureWith(value: value)
    default:
      assertionFailure("Unrecognized (cell, viewModel) combo.")
    }
  }
}
