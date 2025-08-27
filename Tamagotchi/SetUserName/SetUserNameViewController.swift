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
            textFieldValue: userNameTextField.rx.text.orEmpty,
            navRightBarItemTap: navigationItem.rightBarButtonItem?.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.validationLabel
            .bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.userName
            .skip(1)
            .bind(with: self) { owner, text in
                if let nav = owner.navigationController,
                   let rootVC = nav.viewControllers.first as? TamagotchiTabViewController {
                    rootVC.viewModel.userName.accept(text)
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
