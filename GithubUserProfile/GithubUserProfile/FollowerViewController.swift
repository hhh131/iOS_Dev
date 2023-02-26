//
//  FollowerViewController.swift
//  GithubUserProfile
//
//  Created by 신희권 on 2023/02/26.
//

import UIKit

class FollowerViewController: UIViewController {
  
    @IBOutlet var userNameLabel: UILabel!
    var userName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = userName
        
        
    

        // Resource

        let resource =  Resource<UserProfile>(
         base: "https://api.github.com/",
         path: "users/\(userName)",
         params: [:],
         header:["Content-Type":"application/json"])




        // NetworkService

        network.load(resource)
            .receive(on: RunLoop.main)
            .sink{ completion in
                switch completion {
                case .failure(let error):
                    self.user = nil
                case .finished: break
                }
            } receiveValue: { user in
                self.user = user
            }.store(in: &subscription)


    }



}
