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

struct BoxOfficeResult: Decodable {
    let boxOfficeResult: DailyBoxOfficeList
}

struct DailyBoxOfficeList: Decodable {
    let dailyBoxOfficeList: [BoxOffice]
}

struct BoxOffice: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
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
    
    
    static func getMovie(query: String) -> Observable<BoxOfficeResult> {
        return  Observable<BoxOfficeResult>.create { observer in
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=87326d7892a79b81ae16230feed7ac72&targetDt=\(query)"

            AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
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
