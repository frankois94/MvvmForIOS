//
//  IData.swift
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import Foundation

protocol IData {
    
    func getData() -> String?;
    func setData(newValue:String?) -> Void;
}
