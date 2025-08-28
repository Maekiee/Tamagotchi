import Foundation
import RxSwift
import RxCocoa
import UIKit


enum ViewName {
    case setTamagotch
    case main
    case setting
    case lotto
    case movie
    
    
    var showView: UIViewController {
        switch self {
        case .setTamagotch:
            SetTamagotchViewController()
        case .main:
            TamagotchiTabViewController()
        case .setting:
            SettingViewController()
        case .lotto:
            LottoViewController()
        case .movie:
            MovieViewController()
        }
    }
}

class SettingViewModel {
    
    
    
    
    
    struct Input {
        let selectedMenu: ControlEvent<SettingMenu>
    }
    
    struct Output {
        let nextScreen: PublishRelay<(isAlert: Bool, vc:UIViewController)>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let nextScreen = PublishRelay<(isAlert: Bool, vc: UIViewController)>()
        
        input.selectedMenu.bind(with: self) { owner, menu in
            switch menu {
            case .setName:
                
                
                nextScreen.accept((isAlert: false, vc: SetUserNameViewController()))
            case .changeTamagotchi:
                nextScreen.accept((isAlert: false, vc: SetTamagotchViewController()))
            case .reset:
                guard let domain = Bundle.main.bundleIdentifier else { return }
                UserDefaults.standard.removePersistentDomain(forName: domain)
                
                
                
                nextScreen.accept((isAlert: true, vc: SetTamagotchViewController()))
            }
        }.disposed(by: disposeBag)
        
        
        
        
        return Output(nextScreen: nextScreen)
    }
    
    
}
