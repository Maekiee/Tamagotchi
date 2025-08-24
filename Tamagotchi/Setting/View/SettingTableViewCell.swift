import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    
    private var disposeBag = DisposeBag()
    
    let menuText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(menuText)
        menuText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(_ text: String) {
        menuText.text = text
    }

}
