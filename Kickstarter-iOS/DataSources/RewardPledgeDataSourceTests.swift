import XCTest
@testable import Kickstarter_Framework
@testable import Library
@testable import KsApi

final class RewardPledgeDataSourceTests: XCTestCase {
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
  let dataSource = RewardPledgeDataSource()

  func testLoadReward() {
    dataSource.load(reward: Reward.template)

    XCTAssertEqual(3, self.dataSource.numberOfSections(in: collectionView))
    XCTAssertEqual(1, self.dataSource.collectionView(collectionView, numberOfItemsInSection: 0))
    XCTAssertEqual(2, self.dataSource.collectionView(collectionView, numberOfItemsInSection: 1))
    XCTAssertEqual(1, self.dataSource.collectionView(collectionView, numberOfItemsInSection: 2))
  }
}
