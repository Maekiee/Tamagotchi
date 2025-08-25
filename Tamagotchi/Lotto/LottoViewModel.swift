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
        
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        
        
        input.submitButtonTapped
            .withLatestFrom(input.textFieldText)
        
        
        return Output()
    }
    
}
