//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by 신희권 on 2023/03/04.
//

import Foundation
import Combine

final class FrameworkListViewModel{
    // Data => output
    init(itmes: [AppleFramework],selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(itmes)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>
    //User Action => Input

    
    func didSelect(at indexPath: IndexPath) {
        let item = items.value[indexPath.item]
        selectedItem.send(items.value[indexPath.item])
    }
}
