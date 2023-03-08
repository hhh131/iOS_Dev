//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by 신희권 on 2023/03/05.
//

import Foundation
import Combine
final class SearchViewModel {
    
  
    var 변수명:  = 값
    let network: NetworkService
    var subscriptions = Set<AnyCancellable>()
    
    //@Published private(set) var users = [SearchResult]()
    let users: CurrentValueSubject<[SearchResult],Never>
    
    init(network: NetworkService, users:[SearchResult]?){
        self.network = network
        self.users = CurrentValueSubject(users!)
    }
    
    func search(keyword: String) {
        let resource: Resource<SearchUserResponse> = Resource(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"]
        )
//
//        network.load(resource)
//            .map { $0.items }
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .assign(to: \.users, on: self)
//            .store(in: &subscriptions)
        
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    //self.users.send(nil)
                    print("error: \(error)")
                case .finished: break
                }
            } receiveValue: { user in
                self.users.send(user)
            }.store(in: &subscriptions)
    }
}
    
