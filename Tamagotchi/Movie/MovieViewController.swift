import UIKit
import RxSwift
import RxCocoa


class MovieViewController: UIViewController {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    let list: BehaviorRelay<[BoxOffice]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    let viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAddView()
        configLayout()
        configView()
        
        bind()
    }
    
    private func bind() {
        
        let input = MovieViewModel.Input(
            searchTap: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier, cellType: MovieTableViewCell.self)) {
                (row, element, cell) in
                cell.usernameLabel.text = "\(element.rank). \(element.movieNm)"
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
