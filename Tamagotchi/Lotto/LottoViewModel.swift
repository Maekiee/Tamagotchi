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
                    .catch { _ in
                        return Observable.never()
                    }
            }
            .subscribe(with: self) { owner, res in
                switch res {
                case .success(let value):
                    drwNo1.accept(String(value.drwtNo1))
                    drwNo2.accept(String(value.drwtNo2))
                    drwNo3.accept(String(value.drwtNo3))
                    drwNo4.accept(String(value.drwtNo4))
                    drwNo5.accept(String(value.drwtNo5))
                    drwNo6.accept(String(value.drwtNo6))
                    bnusNum.accept(String(value.bnusNo))
                case .failure(let error):
                    print("에러러러러러러", error.errorUserResponse)
                }
//
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
