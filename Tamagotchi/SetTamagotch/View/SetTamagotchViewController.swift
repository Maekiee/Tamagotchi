import UIKit
import RxSwift
import RxCocoa
import SnapKit

struct Tamagotchi {
    static let dummyData = [
        ("1-6", "따끔다끔 다마고치"),
        ("2-6", "방실방실 다마고치"),
        ("3-6", "반짝반짝 다마고치"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
        ("noImage", "준비중이에요"),
    ]
}


final class SetTamagotchViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SetTamagotchViewModel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
//    private let dummyData = [
//        ("1-6", "따끔다끔 다마고치"),
//        ("2-6", "방실방실 다마고치"),
//        ("3-6", "반짝반짝 다마고치"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//        ("noImage", "준비중이에요"),
//    ]
    private lazy var tamagotchiList = BehaviorSubject<[(String, String)]>(value: Tamagotchi.dummyData)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()
        
        bind()
        
    }
    
    private func bind() {
        
        tamagotchiList.bind(to: collectionView.rx.items(cellIdentifier: SetTamagotchiCollectionViewCell.identifier, cellType: SetTamagotchiCollectionViewCell.self)) { item, value, cell in
            cell.configCell(item: value)
        }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                let item = Tamagotchi.dummyData[indexPath.row]
                let selectedItemNum = indexPath.row + 1
                let vc = TamagotchiPopupViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.selectedItemIamge = item.0
                vc.nameLabel.text = item.1
                owner.present(vc, animated: true)
//                guard let domain = Bundle.main.bundleIdentifier else { return }
//                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.set(selectedItemNum, forKey: item.1)
                
            }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected((String, String).self)
            .bind(with: self) { owner, value in
                //                let vc = TamagotchiPopupViewController()
                //                vc.modalPresentationStyle = .overCurrentContext
                //                vc.modalTransitionStyle = .crossDissolve
                //                vc.nameLabel.text = value.1
                //                vc.selectedItemIamge = value.0
                //                owner.present(vc, animated: true)
                ////                UserDefaults.standard.set(, forKey: <#T##String#>)
                //                print(owner, value)
                
            }.disposed(by: disposeBag)
        
    }
    
}

extension SetTamagotchViewController {
    
    private func configHeiracy() {
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        
        collectionView.register(SetTamagotchiCollectionViewCell.self, forCellWithReuseIdentifier: SetTamagotchiCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configView() {
        view.backgroundColor = .white
        navigationItem.title = "다마고치 선택하기"
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = (view.frame.width - 72) / 3
        let cellHeight = deviceWidth
        layout.itemSize = CGSize(width: deviceWidth, height: cellHeight)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        return layout
    }
    
    
}
