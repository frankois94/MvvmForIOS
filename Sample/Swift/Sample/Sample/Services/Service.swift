//
//  Service.swift
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import Foundation

class Service: BaseServices {
    var data:IData!;
    
    override init(window:UIWindow) {
        super.init(window: window)
        data = Data();
    }
    
}
