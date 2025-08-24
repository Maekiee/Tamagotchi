import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SetUserNameViewController: UIViewController {
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름을 입력해주세요"
        return tf
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configAddView()
        configLayout()
        configView()
    }
}

extension SetUserNameViewController: configurationUI {
    func configAddView() {
        view.addSubview(userNameTextField)
        view.addSubview(divider)
    }
    
    func configLayout() {
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }
    
    func configView() {
        view.backgroundColor = .white
        navigationItem.title = "다마고치"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: nil,
            action: nil)
        
        
    }
    
    
}
