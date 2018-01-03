//
//  Data.swift
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import Foundation

class Data: IData {
    func getData() -> String? {
        return (MainData.getData());
    }
    
    func setData(newValue:String?) {
        MainData.setData(newValue: newValue);
    }
    

}
