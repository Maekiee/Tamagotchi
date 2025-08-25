import Foundation
import RxSwift
import RxCocoa


class TamagotchiTabViewModel {
    private let disposeBag = DisposeBag()
    
    
    
    struct Input {
        let feedButtonTap: ControlEvent<Void>
        let feedTextfieldText: ControlProperty<String>
        let waterButtnTap: ControlEvent<Void>
        let waterTextfieldText: ControlProperty<String>
    }
    
    struct Output {
        let levelCount: BehaviorRelay<Int>
        let feedCount: BehaviorRelay<Int>
        let waterCount: BehaviorRelay<Int>
        let talkLable: BehaviorRelay<String>
//        let tamagotchiImage: BehaviorRelay<Int>
    }
    
    init() { }
    
    var tamagotchiImage: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
    var userName: BehaviorRelay<String> = BehaviorRelay<String>(value: "대장")
    
    let speak = [
        "복습 아직 안하셨다구요? 지금 잠이 오세여? %@님??",
        "%@님 테이블뷰컨톨러와 뷰컨트롤러는 어떤 차이가 있을까요?",
        "%@님 오늘 깃허브 푸시 하셨나요?",
        "%@님 Rx는 이해가 잘 되셨나요?",
        "%@님은 알다가도 모르겠어요",
        "다음주 시험인데 공부 많이합시다 %@님!"
    ]
    
    func randomTalk() -> String {
        let talking = speak.randomElement()!
        return String(format: talking, userName.value)
    }
    
    func transform(input: Input) -> Output {
        
        let levelCount = BehaviorRelay<Int>(value: 1)
        let feedCount = BehaviorRelay<Int>(value: 0)
        let waterCount = BehaviorRelay<Int>(value: 0)
        let talkLabel = BehaviorRelay<String>(value: "")

        input.feedButtonTap
            .withLatestFrom(input.feedTextfieldText)
            .map { self.validateCount(value: $0) }
            .scan(0) { oldValue, newValue in
                return newValue < 100 ? oldValue + newValue : oldValue
            }
            .bind(with: self) { owner, value in
                let randomSpeak = owner.randomTalk()
                feedCount.accept(value)
                talkLabel.accept(randomSpeak)
                print(randomSpeak)
            }
            .disposed(by: disposeBag)
        
        
        input.waterButtnTap
            .withLatestFrom(input.waterTextfieldText)
            .map { self.validateCount(value: $0) }
            .scan(0) { oldValue, newValue in
                return newValue < 50 ? oldValue + newValue : oldValue
            }
            .bind(with: self) { owner, value in
                let randomSpeak = owner.randomTalk()
                talkLabel.accept(randomSpeak)
                waterCount.accept(value)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(feedCount, waterCount)
            .map { food, water in
                return (food / 5) + (water / 2)
            }.bind(with: self) { owner, value in
                if value < 20 {
                    levelCount.accept(1)
                } else if value >= 20 && value < 30 {
                    levelCount.accept(2)
                } else if value >= 30 && value < 40 {
                    levelCount.accept(3)
                } else if value >= 40 && value < 50 {
                    levelCount.accept(4)
                } else if value >= 50 && value < 60 {
                    levelCount.accept(5)
                } else if value >= 60 && value < 70 {
                    levelCount.accept(6)
                } else if value >= 70 && value < 80 {
                    levelCount.accept(7)
                } else if value >= 80 && value < 90 {
                    levelCount.accept(8)
                } else if value >= 90 && value < 100 {
                    levelCount.accept(9)
                } else if value >= 100 {
                    levelCount.accept(10)
                } else {
                    print("마이너스가 들어오나?")
                }
            }.disposed(by: disposeBag)
        
        return Output(
            levelCount: levelCount,
            feedCount: feedCount,
            waterCount: waterCount,
            talkLable: talkLabel
//            tamagotchiImage: tamagotchiImage,
        )
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
    
    private func levelUP() {
        
    }
}
