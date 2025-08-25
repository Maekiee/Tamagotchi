import UIKit
import RxSwift
import RxCocoa


class MovieViewController: UIViewController {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    
    let list: BehaviorRelay<[BoxOffice]> = BehaviorRelay(value: [])
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
                cell.usernameLabel.text = "\(element.rank). \(element.movieNm)"
            }.disposed(by: disposeBag)
        
        
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getMovie(query: text)
            }.subscribe(with: self) {owner, value in
                let data = value.boxOfficeResult.dailyBoxOfficeList
                owner.list.accept(data)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("complted")
            } onDisposed: { owner in
                print("disposed")
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
