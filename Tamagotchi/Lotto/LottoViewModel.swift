import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let textFieldText: ControlProperty<String>
        let submitButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let drwNo1: BehaviorRelay<String>
        let drwNo2: BehaviorRelay<String>
        let drwNo3: BehaviorRelay<String>
        let drwNo4: BehaviorRelay<String>
        let drwNo5: BehaviorRelay<String>
        let drwNo6: BehaviorRelay<String>
        let bnusNum: BehaviorRelay<String>
    }
    
//    init() { }
    
    func transform(input: Input) -> Output {
        
        let drwNo1 = BehaviorRelay(value: "")
        let drwNo2 = BehaviorRelay(value: "")
        let drwNo3 = BehaviorRelay(value: "")
        let drwNo4 = BehaviorRelay(value: "")
        let drwNo5 = BehaviorRelay(value: "")
        let drwNo6 = BehaviorRelay(value: "")
        let bnusNum = BehaviorRelay(value: "")
        
        input.submitButtonTapped
            .withLatestFrom(input.textFieldText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getLotto(query: text)
            }
            .subscribe(with: self) { owner, text in
                print(text)
                drwNo1.accept(String(text.drwtNo1))
                drwNo2.accept(String(text.drwtNo2))
                drwNo3.accept(String(text.drwtNo3))
                drwNo4.accept(String(text.drwtNo4))
                drwNo5.accept(String(text.drwtNo5))
                drwNo6.accept(String(text.drwtNo6))
                bnusNum.accept(String(text.bnusNo))
            } onError: { owner, error in
                print("에러:", error)
            } onCompleted: { owner in
                print("")
            } onDisposed: {  owner in
                print("")
            }.disposed(by: disposeBag)
        
        
        return Output(drwNo1:drwNo1, drwNo2: drwNo2, drwNo3: drwNo3, drwNo4: drwNo4, drwNo5: drwNo5, drwNo6: drwNo6, bnusNum: bnusNum)
    }
    
}
