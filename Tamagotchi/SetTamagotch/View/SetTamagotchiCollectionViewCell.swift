import UIKit
import SnapKit

class SetTamagotchiCollectionViewCell: UICollectionViewCell {
    static let identifier = "SetTamagotchiCollectionViewCell"
    
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
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        [tamagotchiImage, tamagotchiLabelContainer].forEach {
            view.addArrangedSubview($0)
        }
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configHeiracy()
        configLayout()
//        configView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(item: (String, String)) {
        tamagotchiImage.image = UIImage(named: item.0)
        nameLabel.text = item.1
    }
    
}

extension SetTamagotchiCollectionViewCell {
    private func configHeiracy() {
        contentView.addSubview(stackView)
        tamagotchiLabelContainer.addSubview(nameLabel)
        
    }
    
    private func configLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        tamagotchiImage.snp.makeConstraints { make in
            make.size.equalTo(100)
        }
        
        tamagotchiLabelContainer.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
    }
    
    private func configView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.red.cgColor
    }
}
