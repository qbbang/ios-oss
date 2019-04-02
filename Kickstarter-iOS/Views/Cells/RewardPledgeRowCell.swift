import Library
import UIKit

final class RewardPledgeRowCell: UITableViewCell, ValueCell {
  func configureWith(value: String) {
    self.textLabel?.text = value
  }
}
