//
//  SecondViewModel.swift
//  Sample
//
//  Created by Dabonot Francois on 20/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import UIKit

class SecondViewModel: BaseViewModel  {
    
    func closeViewModel() -> Void {
        NSLog("closeViewModel start!")
        (Locator.get(INavigationService.self) as! INavigationService).closeCurrentViewModel(onCompletion: {
            NSLog("closeViewModel over!")
        });
    }

}
