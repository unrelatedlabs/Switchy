//
//  ViewController.swift
//  LightSwitch
//
//  Created by Peter Kuhar Jagodnik on 5/2/15.
//  Copyright (c) 2015 Peter Kuhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var devices:[ULDevice] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ULDeviceController.sharedInstance().listDevices { (devices) -> Void in
                self.devices = devices
                self.tableView.reloadData()
            }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let device = devices[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! UITableViewCell
        
        cell.textLabel?.text = device.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ULDeviceController.sharedInstance().toggle( devices[indexPath.row] )
    }

}

