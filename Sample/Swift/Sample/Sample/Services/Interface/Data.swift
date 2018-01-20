//
//  Data.swift
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import Foundation

class Data: IData {
    required init() {
        NSLog("INIT DATA");
    }
    
    func getData() -> String? {
        return (MainData.getData());
    }
    
    func setData(newValue:String?) {
        MainData.setData(newValue: newValue);
    }
    
    func helloWorld() -> String {
        return ("Helloworld");
    }
}
