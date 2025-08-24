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
    
    static let talk = [
        "복습 아직 안하셨다구요? 지금 잠이 오세여? 대장님??",
        "테이블뷰컨톨러와 뷰컨트롤러는 어떤 차이가 있을까요?",
        "고래밥님 오늘 깃허브 푸시 하셨나요?",
        "Rx는 뭔가 많이 복잡하네요",
        "알다가도 모르겠어요",
        "다음주 시험인데 공부 많이합시다 대장님!"
    ]
}


final class SetTamagotchViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SetTamagotchViewModel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
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
                let vc = TamagotchiPopupViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                vc.row = indexPath.row
                vc.popChanedImage = { [weak self] in
                    guard let _ = self else { return }
                    owner.navigationController?.popToRootViewController(animated: true)
                
                    // ??
                    if let nav = owner.navigationController,
                       let rootVC = nav.viewControllers.first as? TamagotchiTabViewController {
                        rootVC.viewModel.changeImage()
                    }

                    owner.navigationController?.popToRootViewController(animated: true)
                }
                owner.present(vc, animated: true)
            }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected((String, String).self)
            .bind(with: self) { owner, value in
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
