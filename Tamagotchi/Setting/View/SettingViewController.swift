import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SettingViewController: UIViewController {
    let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()
    }

}


extension SettingViewController {
    
    func configHeiracy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configView() {
        view.backgroundColor = .orange
        navigationItem.title = "설정"
    }
    
}
