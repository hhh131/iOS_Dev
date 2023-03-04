//
//  FrameDetaliViewModel.swift
//  AppleFramework
//
//  Created by 신희권 on 2023/03/04.
//

import Foundation
import Combine

final class FrameworkDetaliViewModel{
    
    
    init(framework: AppleFramework){
        self.framework = CurrentValueSubject(framework)
    }
    let framework: CurrentValueSubject<AppleFramework, Never>
    
    
    

    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    
    func learnMoreTapped(){
        buttonTapped.send(framework.value)
    }
   
    
}
