import KsApi
import Foundation
import Prelude
import ReactiveSwift
import Result

public protocol RewardPledgeViewModelInputs {
  func configure(with reward: Reward)
  func viewDidLoad()
}

public protocol RewardPledgeViewModelOutputs {
  var reward: Signal<Reward, NoError> { get }
}

public protocol RewardPledgeViewModelType {
  var inputs: RewardPledgeViewModelInputs { get }
  var outputs: RewardPledgeViewModelOutputs { get }
}

private typealias Type = RewardPledgeViewModelType
private typealias Inputs = RewardPledgeViewModelInputs
private typealias Outputs = RewardPledgeViewModelOutputs

public class RewardPledgeViewModel: Type, Inputs, Outputs {
  public init() {
    let reward = self.configureRewardProperty.signal
      .skipNil()

    self.reward = Signal.combineLatest(reward.signal, self.viewDidLoadProperty.signal)
      .map(first)
  }

  private let configureRewardProperty = MutableProperty<Reward?>(nil)
  public func configure(with reward: Reward) {
    self.configureRewardProperty.value = reward
  }

  private let viewDidLoadProperty = MutableProperty(())
  public func viewDidLoad() {
    self.viewDidLoadProperty.value = ()
  }

  public let reward: Signal<Reward, NoError>

  public var inputs: RewardPledgeViewModelInputs { return self }
  public var outputs: RewardPledgeViewModelOutputs { return self }
}
