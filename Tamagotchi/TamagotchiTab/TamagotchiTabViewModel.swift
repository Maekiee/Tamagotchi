import Foundation
import RxSwift
import RxCocoa


class TamagotchiTabViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let feedButtonTap: ControlEvent<Void>
        let feedTextfieldText: ControlProperty<String>
    }
    
    struct Output {
        let levelCount: BehaviorRelay<Int>
        let feedCount: BehaviorRelay<Int>
        let waterCount: BehaviorRelay<Int>
        
    }
    
    init() { }

    
    func transform(input: Input) -> Output {
        
        let levelCount = BehaviorRelay<Int>(value: 1)
        let feedCount = BehaviorRelay<Int>(value: 0)
        let waterCount = BehaviorRelay<Int>(value: 0)
        

        input.feedButtonTap
            .withLatestFrom(input.feedTextfieldText)
            .map { self.validateCount(value: $0) }
            .scan(0) { oldValue, newValue in
                if newValue < 100 {
                    return oldValue + newValue
                } else {
                    return oldValue
                }
            }
            .bind(with: self) { owner, value in
                feedCount.accept(value)
            }
            .disposed(by: disposeBag)
        
         
        
        return Output(
            levelCount: levelCount,
            feedCount: feedCount,
            waterCount: waterCount)
    }
    
    private func validateCount(value: String) -> Int {
        if value.isEmpty {
            return 1
        } else if Int(value) != nil {
            return Int(value)!
        } else {
            return 0
        }
    }
    
    private func counting() {
        
    }
}
