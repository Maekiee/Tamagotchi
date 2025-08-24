import Foundation
import RxSwift
import RxCocoa

final class TamagotchiPopupViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let confirmButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
