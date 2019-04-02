import KsApi
import Prelude
import UIKit

final class RewardPledgeViewController: UIViewController {
  // MARK: - Properties

  private lazy var rewardPledgeTableViewController: RewardPledgeTableViewController = {
    RewardPledgeTableViewController.instantiate()
  }()

  // MARK: - Lifecycle

  static func instantiate() -> RewardPledgeViewController {
    return RewardPledgeViewController()
  }

  func configure(with reward: Reward) {
    self.rewardPledgeTableViewController.configure(with: reward)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    _ = self
      |> \.title %~ { _ in "Back this project" }

    if let childView = self.rewardPledgeTableViewController.tableView {
      self.addChild(self.rewardPledgeTableViewController)
      self.view.addSubview(childView)
      self.rewardPledgeTableViewController.didMove(toParent: self)

      childView.constrainEdges(to: self.view)
    }
  }
}
