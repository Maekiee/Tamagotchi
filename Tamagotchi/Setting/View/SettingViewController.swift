import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SettingViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView: UITableView = {
        let view = UITableView()
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        return view
    }()
    
    enum SettingMenu:String, CaseIterable {
        case setName = "내 이름 설정하기"
        case changeTamagotchi = "다마고치 변경하기"
        case reset = "데이터 초기화"
    }
    
    
    lazy var menus = BehaviorSubject<[SettingMenu]>(value: SettingMenu.allCases)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()
        
        bind()
    }
    
    func bind() {
        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind(with: self) { owner, value in
                print("dd")
                owner.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        menus.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as! SettingTableViewCell
            cell.configUI(element.rawValue)
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SettingMenu.self)
            .bind(with: self) { owner, menu in
                
                switch menu {
                case .setName:
                    let vc = SetUserNameViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                case .changeTamagotchi:
                    let vc = SetTamagotchViewController()
                    owner.navigationController?.pushViewController(vc, animated: true)
                case .reset:
                    owner.showAlertType2(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가요?")
                }
                
            }.disposed(by: disposeBag)
        
    }

}


extension SettingViewController {
    
    func configHeiracy() {
        view.addSubview(tableView)
    }
    
    func configLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configView() {
        view.backgroundColor = .white
        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: nil,
            action: nil)
    }
    
}
