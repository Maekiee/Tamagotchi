import UIKit
import RxSwift
import RxCocoa


class MovieViewController: UIViewController {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    
    let list: BehaviorRelay<[String]> = BehaviorRelay(value: ["a","b","c","d","e","f"])
    let items = BehaviorRelay(value: ["a","b","c","d","e","f"])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAddView()
        configLayout()
        configView()
        
        bind()
    }
    
    private func bind() {
        list
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) {
                (row, element, cell) in
//                let text = "\(element.drwNoDate)일, \(element.firstAccumamnt.formatted())원"
                cell.usernameLabel.text = "테스트"
//                text
            }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Int.self)
            .map { "셀 \($0)" }
            .bind(with: self) { owner, number in
                var original = owner.items.value
                original.insert(number, at: 0)
                
                owner.items.accept(original)
            }.disposed(by: disposeBag)
    }
    

}


extension MovieViewController: configurationUI {
    func configAddView() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        
        navigationItem.titleView = searchBar
    }
    
    func configLayout() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configView() {
        view.backgroundColor = .white
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
}
