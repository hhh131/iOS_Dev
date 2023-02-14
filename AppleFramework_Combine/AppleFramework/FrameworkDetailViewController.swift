//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/05/01.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var subscriptions = Set<AnyCancellable>()
    
    let buttonTapped = PassthroughSubject<AppleFramework,Never>()
    var framework = CurrentValueSubject<AppleFramework,Never>(AppleFramework(name: "Unknown", imageName: "", urlString: "", description: ""))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        bind()
    }
    private func bind(){
        //input : Button Click
        //framework -> url -> safari
        buttonTapped
            .receive(on: RunLoop.main)
            .compactMap{ URL(string: $0.urlString) }
            .sink { [ unowned self] url in
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
            }.store(in: &subscriptions)
        //output : Data setting
        framework
            .receive(on: RunLoop.main)
            .sink{ [unowned self] framework in
                self.imageView.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
        }
        

    

    
    @IBAction func learnMoreTapped(_ sender: Any) {
        buttonTapped.send(framework.value)
//        guard let url = URL(string: framework.urlString) else {
//            return
//        }
//        let safari = SFSafariViewController(url: url)
//        present(safari, animated: true)
    }
}
