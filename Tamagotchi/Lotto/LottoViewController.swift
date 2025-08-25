import UIKit
import SnapKit
import RxSwift
import RxCocoa


final class LottoViewController: UIViewController {
    private let viewModel = LottoViewModel()
    private let disposeBag = DisposeBag()
    
    let textfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "회차를 입력해주세요"
        tf.textAlignment = .center
        tf.backgroundColor = .systemGray5
        return tf
    }()
    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("불러오기", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        return view
    }()
    
    
    let resultLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let resultLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let resultLabel3: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let resultLabel4: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let resultLabel5: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let resultLabel6: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let resultLabel7: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let lottoItems: BehaviorRelay<[Int]> = BehaviorRelay(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        configAddView()
        configLayout()
        configView()

        bind()
    }
    
    func bind() {
        
        submitButton.rx.tap
            .withLatestFrom(textfield.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap{ text in
                CustomObservable.getLotto(query: text)
            }
            .subscribe(with: self) { owner, text in
                owner.resultLabel1.text = String(text.drwtNo1)
                owner.resultLabel2.text = String(text.drwtNo2)
                owner.resultLabel3.text = String(text.drwtNo3)
                owner.resultLabel4.text = String(text.drwtNo4)
                owner.resultLabel5.text = String(text.drwtNo5)
                owner.resultLabel6.text = String(text.drwtNo6)
                owner.resultLabel7.text = String(text.bnusNo)
//                var items = owner.lottoItems.value
//                items.append(text.drwtNo1)
//                items.append(text.drwtNo2)
//                items.append(text.drwtNo3)
//                items.append(text.drwtNo4)
//                items.append(text.drwtNo5)
//                items.append(text.drwtNo6)
//                items.append(text.bnusNo)
//                owner.lottoItems.accept(items)
                
                owner.resultLabel1.text = String(text.drwtNo1)
            } onError: { owner, error in
                
            } onCompleted: { owner in
                
            } onDisposed: {  owner in
                
            }.disposed(by: disposeBag)
        
        
//        let input = LottoViewModel.Input(
//            textFieldText: textfield.rx.text.orEmpty,
//            submitButtonTapped: submitButton.rx.tap,
//        )
//        
//        let output = viewModel.transform(input: input)
//        
//        let a = textfield.rx.text.orEmpty
    }
    
}


extension LottoViewController: configurationUI {
    func configAddView() {
        view.addSubview(textfield)
        view.addSubview(submitButton)
        [resultLabel1, resultLabel2, resultLabel3, resultLabel4, resultLabel5,resultLabel6,resultLabel7]
            .forEach { view.addSubview($0) }
        
    }
    
    func configLayout() {
        textfield.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        resultLabel1.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.centerX.equalToSuperview().offset(-72)
        }
        
        resultLabel2.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.leading.equalTo(resultLabel1.snp.trailing).offset(4)
        }
        
        resultLabel3.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.leading.equalTo(resultLabel2.snp.trailing).offset(4)
        }
        
        resultLabel4.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.leading.equalTo(resultLabel3.snp.trailing).offset(4)
        }
        
        resultLabel5.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.leading.equalTo(resultLabel4.snp.trailing).offset(4)
        }
        
        resultLabel6.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.leading.equalTo(resultLabel5.snp.trailing).offset(4)
        }
        
        resultLabel7.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(28)
            make.leading.equalTo(resultLabel6.snp.trailing).offset(4)
        }
    }
    
    func configView() {
        view.backgroundColor = .white
    }
    
    
}
