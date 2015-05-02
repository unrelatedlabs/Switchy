//
//  ULDeviceController.swift
//  LightSwitch
//
//  Created by Peter Kuhar Jagodnik on 5/2/15.
//  Copyright (c) 2015 Peter Kuhar. All rights reserved.
//

import UIKit

class ULDeviceController: NSObject {
    static var _sharedInstance = ULDeviceController()
    
    class func sharedInstance()->ULDeviceController{
        return _sharedInstance
    }
    
    var server = "http://192.168.1.140:9700"
    
    func listDevices( completetionBlock:([ULDevice])->Void ) {
        
       jsonCall("devices") { (response, error) -> Void in
            if let deviceDics = response["devices"] as? [[String:AnyObject]]{
                
                var devices:[ULDevice] = deviceDics.map({ULDevice(dict:$0)})
                
                devices = devices.filter({ (d:ULDevice) -> Bool in
                    !d.title.hasSuffix("motion")
                })
                
                completetionBlock( devices )
            }
       }

    }
    
    func jsonCall(path:String,completionHandler:([String:AnyObject]!,NSError!)->Void ) {
        
        let url = "\(server)/\(path)"
        
        NSLog("Calling \(url)")
        
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: url)!), queue: NSOperationQueue.mainQueue()) { (response, _data, error) -> Void in
            if let data = _data {
                
                if let object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String:AnyObject]{
                    
                    completionHandler(object,nil);
                    return
                    
                }
            }
            if error != nil{
                completionHandler(nil,error)
            }else{
                completionHandler(nil,NSError(domain: "UL", code: 0, userInfo: [NSLocalizedDescriptionKey:"Error \(response)"]))
            }
        }
    }
    
    func toggle(device:ULDevice){
        jsonCall( "devices/\(device.title)/toggle" , completionHandler: { (response, error) -> Void in
            
        })
    }
    
    
    
}
