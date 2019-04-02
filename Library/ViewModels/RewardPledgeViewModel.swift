import KsApi
import Foundation
import Prelude
import ReactiveSwift
import Result

public protocol RewardPledgeViewModelInputs {
  func configure(with project: Project)
}

public protocol RewardPledgeViewModelOutputs {

}

public protocol RewardPledgeViewModelType {
  var inputs: RewardPledgeViewModelInputs { get }
  var outputs: RewardPledgeViewModelOutputs { get }
}

public class RewardPledgeViewModel:
  RewardPledgeViewModelType,
  RewardPledgeViewModelInputs,
  RewardPledgeViewModelOutputs {
  public init() {
    self.configureProjectProperty.signal
      .skipNil()
      .observeValues { project in
        print("*** :\(project.name)")
    }
  }

  private let configureProjectProperty = MutableProperty<Project?>(nil)
  public func configure(with project: Project) {
    self.configureProjectProperty.value = project
  }

  public var inputs: RewardPledgeViewModelInputs { return self }
  public var outputs: RewardPledgeViewModelOutputs { return self }
}
