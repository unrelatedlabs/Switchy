//
//  InterfaceController.swift
//  LightSwitch WatchKit Extension
//
//  Created by Peter Kuhar Jagodnik on 5/2/15.
//  Copyright (c) 2015 Peter Kuhar. All rights reserved.
//

import WatchKit
import Foundation

class DeviceCell:NSObject{
    @IBOutlet var label:WKInterfaceLabel!
}

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var tableView: WKInterfaceTable!
    var devices:[ULDevice] = []
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
     
        ULDeviceController.sharedInstance().listDevices { (devices) -> Void in
            self.devices = devices
            self.reloadTable()
        }
        
    }
    func reloadTable(){
        tableView.setNumberOfRows(devices.count, withRowType: "DeviceCell")
        
        for var i = 0; i < tableView.numberOfRows; i++ {
            if let deviceCell = tableView.rowControllerAtIndex(i) as? DeviceCell{
                
                deviceCell.label.setText(devices[i].title)
            }
        }
        
        
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let device = devices[rowIndex]
        ULDeviceController.sharedInstance().toggle(device)
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
