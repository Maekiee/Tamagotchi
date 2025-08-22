import UIKit
import RxSwift
import RxCocoa

class SetTamagotchViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()

        
    }
    
}

extension SetTamagotchViewController {
    
    private func configHeiracy() {
        
    }
    
    private func configLayout() {
        
    }
    
    private func configView() {
        view.backgroundColor = .white
        navigationItem.title = "다마고치 선택하기"
    }
    
    
}
