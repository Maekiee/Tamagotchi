import UIKit
import SnapKit
import RxSwift
import RxCocoa


enum SettingMenu:String, CaseIterable {
    case setName = "내 이름 설정하기"
    case changeTamagotchi = "다마고치 변경하기"
    case reset = "데이터 초기화"
}

final class SettingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return view
    }()
    
    lazy var menus = BehaviorSubject<[SettingMenu]>(value: SettingMenu.allCases)
    
    private let viewModel = SettingViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()
        
        bind()
    }
    
    func bind() {
        navigationItem.leftBarButtonItem?.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        menus.bind(to: tableView.rx
            .items(cellIdentifier: SettingTableViewCell.identifier, cellType: SettingTableViewCell.self)) {
                (row, element, cell) in
            cell.configUI(element.rawValue)
        }.disposed(by: disposeBag)
        
        let input = SettingViewModel.Input(
            selectedMenu: tableView.rx.modelSelected(SettingMenu.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.nextScreen
            .bind(with: self) { owner, value in
                if value.isAlert {
                    owner.showAlertType2(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가요?") {
                        // 초기 화면으로 이동
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                            return
                        }
                        
                        sceneDelegate.changeRootView(value.vc)
                    }
                } else {
                    owner.navigationController?.pushViewController(value.vc, animated: true)
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
