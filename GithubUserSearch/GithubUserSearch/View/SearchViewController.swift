//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    let network = NetworkService(configuration: .default)
    @Published private(set) var users: [SearchResult] = []
    var subscription = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = SearchResult
    var datasource: UICollectionViewDiffableDataSource<Section,Item>!
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchController()
        configureCollectionView()
        bind()
    }
    
    private func embedSearchController() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "hhh131"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    private func  configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else { return nil }
            
            cell.user.text = item.login
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
    }

    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func bind() {
        $users
            .receive(on: RunLoop.main)
            .sink{ user in
              var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(user,toSection: .main)
                self.datasource.apply(snapshot)
            }.store(in: &subscription)
        
    }
    private func NetworkProcess(keyword: String){
        let resource = Resource<SearchUserResponse> (
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword] ,
            header: ["Content-Type": "application/json"]
        )
        network.load(resource)
            .map{ $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscription)
    }

    //collectionView 구성
    // bind()
    // 데이터 -> 뷰
    // 검색된 사용자를 collectionView 업데이트
    //   - 사용자 인터랙션 대응
    //   -서치컨트롤에서 텍스트 -> 네트워크 요청
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text!
        print("\(keyword)")
        //NetworkProcess(keyword: keyword)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("button clicked: \(searchBar.text)")
        
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
        NetworkProcess(keyword: keyword)
        
        
        //        let base = "https://api.github.com/"
        //        let path = "search/users"
        //        let params: [String: String] = ["q": keyword]
        //        let header: [String: String] = ["Content-Type": "application/json"]
        //
        //        var urlComponents = URLComponents(string: base + path)!
        //        let queryItems = params.map { (key: String, value: String) in
        //            return URLQueryItem(name: key, value: value)
        //        }
        //        urlComponents.queryItems = queryItems
        //
        //        var request = URLRequest(url: urlComponents.url!)
        //        header.forEach { (key: String, value: String) in
        //            request.addValue(value, forHTTPHeaderField: key)
        //
        //        }
        //
        
        
        
        //        URLSession.shared.dataTaskPublisher(for: request)
        //            .map { $0.data }
        //            .decode(type: SearchUserResponse.self, decoder: JSONDecoder() )
        //            .map { $0.items }
        //            .replaceError(with: [])
        //            .receive(on: RunLoop.main)
        //            .assign(to: \.users, on: self)
        //            .store(in: &subscription)
        //
        //    }
    }
    
    
}
