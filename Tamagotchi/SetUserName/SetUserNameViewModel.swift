import Foundation
import RxSwift
import RxCocoa

class SetUserNameViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let textFieldValue: ControlProperty<String>
    }
    
    struct Output {
        let validationLabel: BehaviorRelay<String>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        let validationLabel: BehaviorRelay<String> = BehaviorRelay(value: "대장")
        
        input.textFieldValue
            .bind(with: self) { owner, text in
                if text.count >= 2 && text.count <= 6 {
                    validationLabel.accept("가능한 닉네임 입니다.")
                } else {
                    validationLabel.accept("2글자 이상 6글자 이하로 입력해주세요")
                }
            }.disposed(by: disposeBag)
        
        return Output(validationLabel: validationLabel)
    }
    
    
}

