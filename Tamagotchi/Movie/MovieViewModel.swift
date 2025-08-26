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
        let errorMessage: PublishRelay<CustomError>
    }
    
    func transform(input: Input) -> Output {
        
        let list = BehaviorRelay<[BoxOffice]>(value: [])
        let errorMessage =  PublishRelay<CustomError>()
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovie(query: text)
            }.subscribe(with: self) {owner, resultValue in
                switch resultValue {
                case .success(let value):
                    list.accept(value.boxOfficeResult.dailyBoxOfficeList)
                case .failure(let error):
                    errorMessage.accept(error)
                }
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("complted")
            } onDisposed: { owner in
                print("disposed")
            }.disposed(by: disposeBag)
        
        
        return Output(list: list, errorMessage: errorMessage)
    }
    
}
