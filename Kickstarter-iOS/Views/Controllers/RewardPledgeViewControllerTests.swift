@testable import Kickstarter_Framework
import XCTest

final class RewardPledgeViewControllerTests: XCTestCase {
  func testViewDidLoadAddsChildTableViewController() {
    let vc = RewardPledgeViewController.instantiate()
    _ = vc.view

    XCTAssertTrue(vc.children.first is RewardPledgeTableViewController)
  }
}
