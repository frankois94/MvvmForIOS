//
//  SecondViewModel.swift
//  Sample
//
//  Created by Dabonot Francois on 20/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import UIKit

class SecondViewModel: BaseViewModel<Service>  {
    
    func closeViewModel() -> Void {
        NSLog("closeViewModel start!")
        self.service?.closeCurrentViewModel(onCompletion: {
            NSLog("closeViewModel over!")
        });
    }

}
