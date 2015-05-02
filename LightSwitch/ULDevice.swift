//
//  ULDevice.swift
//  LightSwitch
//
//  Created by Peter Kuhar Jagodnik on 5/2/15.
//  Copyright (c) 2015 Peter Kuhar. All rights reserved.
//

import UIKit

class ULDevice: NSObject {
    var title:String  {
        get{
            if let name  = dictionary["name"] as? String{
                return name
            }
            return "Unknown"
        }
    }
    
    var dictionary:[String:AnyObject] = [:]
    init(dict:[String:AnyObject]){
        self.dictionary = dict
    }
}
