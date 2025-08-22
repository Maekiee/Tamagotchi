import UIKit
import SnapKit


class TamagotchiTabViewController: UIViewController {
    let bubbleTalk: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bubble")
        return view
    }()
    let bubbleTalkLable: UILabel = {
        let label = UILabel()
        label.text = "hahahahahahaha"
        return label
    }()
    let tamagotchiImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "1-6")
        
        return view
    }()
    let nameContainer: UIView = {
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
    let levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let riceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let waterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let feedTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    let divder1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    let waterTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    let divder2: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    let feedbutton: UIButton = {
        let button = UIButton()
        button.setTitle("밥먹기", for: .normal)
        button.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()
    }
    
}

extension TamagotchiTabViewController {
    private func configHeiracy() {
        [bubbleTalk, bubbleTalkLable, tamagotchiImage, nameContainer, levelLabel, riceLabel, waterLabel, feedTextField, divder1, divder2, waterTextField, feedbutton].forEach {  view.addSubview($0)
        }
    }
    
    private func configLayout() {
        
        
    }
    
    private func configView() {
        view.backgroundColor = .white
    }
    
}
