import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
 
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default), selectedUser: nil)
        setupUI()
        embedSearchControl()
        bind()
    }
    
    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "cafielo"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {

        viewModel.selectedUser
            .receive(on: RunLoop.main)
            .sink{ [unowned self] _ in
                self.nameLabel.text = viewModel.name
                self.loginLabel.text = viewModel.login
                self.followerLabel.text = viewModel.followers
                self.followingLabel.text = viewModel.following
                self.thumbnail.kf.setImage(with: viewModel.imageURL)
            }.store(in: &viewModel.subscriptions)
    }
    

}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.search(keyword: keyword)
      
    }
}









