import Foundation
import RxSwift
import RxCocoa

class MovieViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let list: BehaviorRelay<[BoxOffice]>
        
    }
    
    func transform(input: Input) -> Output {
        
        let list = BehaviorRelay<[BoxOffice]>(value: [])
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovie(query: text)
            }.subscribe(with: self) {owner, resultValue in
                switch resultValue {
                case .success(let value):
                    list.accept(value.boxOfficeResult.dailyBoxOfficeList)
                case .failure(.invalid):
                    print("에러러러러럴")
                }
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("complted")
            } onDisposed: { owner in
                print("disposed")
            }.disposed(by: disposeBag)
        
        
        return Output(list: list)
    }
    
}
