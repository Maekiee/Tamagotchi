import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TamagotchiTabViewController: UIViewController {
    private let bubbleTalk: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bubble")
//        view.backgroundColor = .green
        return view
    }()
    private let bubbleTalkLable: UILabel = {
        let label = UILabel()
        label.text = "다다음주가 시험이에요 "
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let tamagotchiImage: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(named: "1-1")
        return view
    }()
    private let nameContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "더미 다마고치"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Lv0 · "
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let riceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "밥알 0개 ·  "
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let waterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "물방울 0개"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        [levelLabel, riceLabel, waterLabel].forEach {
            view.addArrangedSubview($0)
        }
        return view
    }()
    private let feedTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "밥주세요"
//        tf.backgroundColor = .green
        return tf
    }()
    private let divder1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private let waterTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "물주세요"
        return tf
    }()
    private let divder2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private let feedbutton: UIButton = {
        let button = UIButton()
        button.setTitle("밥먹기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    private let waterbutton: UIButton = {
        let button = UIButton()
        button.setTitle("물먹기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    let viewModel = TamagotchiTabViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()

        bind()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        let talk = viewModel.randomTalk()
        self.bubbleTalkLable.text = talk
        print(#function)
    }
    
    private func bind() {
        let input = TamagotchiTabViewModel.Input(
            feedButtonTap: feedbutton.rx.tap,
            feedTextfieldText: feedTextField.rx.text.orEmpty,
            waterButtnTap: waterbutton.rx.tap,
            waterTextfieldText: waterTextField.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        
        
        
        output.talkLable
            .bind(to: bubbleTalkLable.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.userName
            .bind(with: self) { owner, nickname in
                owner.navigationItem.title = "\(nickname)님의 다마고치"
            }.disposed(by: disposeBag)
        
        viewModel.tamagotchiImage
            .bind(with: self) { owner, value in
                let level = output.levelCount.value > 9 ? 9 : output.levelCount.value
                let index = value - 1
                owner.nameLabel.text = Tamagotchi.dummyData[index].1
//                let aa = UserDefaults.standard.string(forKey: Tamagotchi.dummyData[index].1)
                owner.tamagotchiImage.image = UIImage(named: "\(value)-\(level)")
            }.disposed(by: disposeBag)
        
        output.levelCount
            .bind(with: self) { owner, count in
                owner.levelLabel.text = "Lv\(count) · "
                let tamagotchi: Int = count > 9 ? 9 : count
                owner.tamagotchiImage.image = UIImage(named: "\(owner.viewModel.tamagotchiImage.value)-\(tamagotchi)")
            }.disposed(by: disposeBag)
        
        output.feedCount
            .bind(with: self) { owner, count in
                owner.riceLabel.text = "밥알 \(count)개 · "
            }.disposed(by: disposeBag)
        
        output.waterCount
            .bind(with: self) { owner, count in
                owner.waterLabel.text = "물방울 \(count)개"
            }.disposed(by: disposeBag)
        
        
        navigationItem.rightBarButtonItem?.rx.tap
            .bind(with: self) { owner, value in
                let vc = SettingViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
    
    
    
}

extension TamagotchiTabViewController {
    private func configHeiracy() {
        [bubbleTalk, tamagotchiImage, nameContainer, stackView, feedTextField, divder1, divder2, waterTextField, feedbutton, waterbutton].forEach {  view.addSubview($0)
        }
    
        bubbleTalk.addSubview(bubbleTalkLable)
        nameContainer.addSubview(nameLabel)
        
        
        
    }
    
    private func configLayout() {
        bubbleTalk.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
        }
        
        bubbleTalkLable.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        tamagotchiImage.snp.makeConstraints { make in
            make.top.equalTo(bubbleTalk.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        nameContainer.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiImage.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(28)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameContainer.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        // 밥 텍스트필드
        feedTextField.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-28)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        divder1.snp.makeConstraints { make in
            make.top.equalTo(feedTextField.snp.bottom)
            make.height.equalTo(1)
            make.width.equalTo(feedTextField.snp.width)
            make.centerX.equalToSuperview().offset(-28)
        }
        
        feedbutton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.equalTo(feedTextField.snp.trailing).offset(4)
        }
        // 물 텍스트필드
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(divder1.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-28)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        waterbutton.snp.makeConstraints { make in
            make.top.equalTo(divder1.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.equalTo(waterTextField.snp.trailing).offset(4)
        }
        
        divder2.snp.makeConstraints { make in
            make.top.equalTo(waterTextField.snp.bottom)
            make.height.equalTo(1)
            make.width.equalTo(waterTextField.snp.width)
            make.centerX.equalToSuperview().offset(-28)
        }
        
        
        
        
    }
    
    
    private func configView() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: nil,
            action: nil)
    }
    
}
