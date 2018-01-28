//
//  MainViewModel.swift
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import Foundation

class MainViewModel: BaseViewModel {
    
    override func start(_ parameters: NSObject?) {
        _helloWorld = (Locator.get(IData.self) as! IData).getData();
    }
    
    private var _helloWorld:String?
    @objc dynamic var helloWorld:String?
    {
        get
        {
            return (_helloWorld);
        }
        set
        {
            if (_helloWorld != newValue)
            {
                _helloWorld = newValue;
                (Locator.get(IData.self) as! IData).setData(newValue: newValue);
            }
        }
    }
    
    
    public func pushSecondView() -> Void {
        NSLog("pushSecondView start!");
        (Locator.get(INavigationService.self) as! INavigationService).showViewModel(SecondViewModel.self, completion: {
            NSLog("pushSecondView over!");
        });
    }
    
    public func modalSecondView() -> Void {
        NSLog("modalSecondView start!");
        (Locator.get(INavigationService.self) as! INavigationService).showModalViewModel(SecondViewModel.self, completion: {
            NSLog("modalSecondView over!");
        });
    }
}
