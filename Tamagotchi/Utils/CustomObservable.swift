import Foundation
import RxSwift
import RxCocoa
import Alamofire


//struct Lotto: Decodable {
//    let drwNoDate: String
//    let firstAccumamnt: Int
//}

struct Lotto: Decodable {
    let drwNoDate: String
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

final class CustomObservable {
    
    static func getLotto(query: String) -> Observable<Lotto> {
        return  Observable<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"

            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
    
    
    static func getMovie(query: String) -> Observable<Lotto> {
        return  Observable<Lotto>.create { observer in
            let url = ""

            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
