//
//  SymbolRollerViewController.swift
//  SymbolRoller
//
//  Created by 신희권 on 2023/01/07.
//

import UIKit

class SymbolRollerViewController: UIViewController {

    let symbols : [String] = ["sun.min","moon","cloud","wind","snowflake"]
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        reload()
    }
    
    
    func reload(){
        let symbol =
            symbols.randomElement()!
        imageView.image = UIImage(systemName: symbol)
        label.text = symbol
    }
}
