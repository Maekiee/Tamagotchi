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
    
    let validationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SetUserNameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configAddView()
        configLayout()
        configView()
        bind()
    }
    
    func bind() {
        
        let input = SetUserNameViewModel.Input(
            textFieldValue: userNameTextField.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.validationLabel
            .bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        
//        navigationItem.rightBarButtonItem?.rx.tap
//            .bind(with: self) { owner, value in
//                let vc = SettingViewController()
//                owner.navigationController?.pushViewController(vc, animated: true)
//            }.disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .withLatestFrom(userNameTextField.rx.text)
            .bind(with: self) { owner, text in
                guard let userName = text else { return }
                print("이름 변경 화면:", userName)
                UserDefaults.standard.set(userName, forKey: "UserName")
                
                if let nav = owner.navigationController,
                   let rootVC = nav.viewControllers.first as? TamagotchiTabViewController {
                    rootVC.viewModel.userName.accept(userName)
                }
                
                owner.navigationController?.popToRootViewController(animated: true)

            }.disposed(by: disposeBag)
        
    }
}

extension SetUserNameViewController: configurationUI {
    func configAddView() {
        view.addSubview(userNameTextField)
        view.addSubview(divider)
        view.addSubview(validationLabel)
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
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(20)
            
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
