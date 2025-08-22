import UIKit
import SnapKit


class TamagotchiPopupViewController: UIViewController {
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let tamagotchiImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "1-6")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    let tamagotchiLabelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "hello world"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "이것은 커스텀 팝업 메시지입니다. 원하는 UI를 자유롭게 구성할 수 있습니다."
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        [closeButton, startButton].forEach {  view.addArrangedSubview($0)
        }
        return view
    }()
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        return button
    }()
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configLayout()
        
    }
    
    private func configUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(popupView)
        popupView.addSubview(tamagotchiImage)
        popupView.addSubview(tamagotchiLabelContainer)
        tamagotchiLabelContainer.addSubview(nameLabel)
        popupView.addSubview(divider)
        popupView.addSubview(messageLabel)
        popupView.addSubview(stackView)
    }
    
    private func configLayout() {
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(400)
        }
        
        tamagotchiImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.size.equalTo(120)
        }
        
        tamagotchiLabelContainer.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiImage.snp.bottom).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiLabelContainer.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(0.5)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(0)
            make.height.equalTo(44)
        }
    }
    
}
