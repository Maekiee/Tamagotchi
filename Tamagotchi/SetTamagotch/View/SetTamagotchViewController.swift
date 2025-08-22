import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SetTamagotchViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = SetTamagotchViewModel()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    var array = [String](repeating: "-6", count: 20)
    let dummyData = [
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
    lazy var tamagotchiList = BehaviorSubject<[(String, String)]>(value: dummyData)

    override func viewDidLoad() {
        super.viewDidLoad()
        configHeiracy()
        configLayout()
        configView()
        
        bind()
        
    }
    
    func bind() {
        
        tamagotchiList.bind(to: collectionView.rx.items(cellIdentifier: SetTamagotchiCollectionViewCell.identifier, cellType: SetTamagotchiCollectionViewCell.self)) { item, value, cell in
            cell.configCell(item: value)
        }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected((String, String).self)
            .bind(with: self) { owner, value in
                let vc = TamagotchiPopupViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
                print(owner, value)
                
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
