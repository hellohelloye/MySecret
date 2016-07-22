//
//  MSBluetoothViewController.swift
//  MySecret
//
//  Created by Yukui Ye on 7/22/16.
//  Copyright © 2016 Yukui Ye. All rights reserved.
//

import UIKit
import CoreBluetooth

class MSBluetoothViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CBCentralManagerDelegate {
    
    @IBOutlet var bluetoothTableView: UITableView!
    
    var centralManager: CBCentralManager?
    var peripherals: Array<CBPeripheral> = Array<CBPeripheral>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if (central.state == CBCentralManagerState.PoweredOn) {
            
            self.centralManager?.scanForPeripheralsWithServices(nil, options: nil)
            
        } else {
            print("..................")
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print(peripheral)
        peripherals.append(peripheral)
        
        self.bluetoothTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bluetoothTVC", forIndexPath:  indexPath) as! BluetoothCustomTVC
        let peripheral: CBPeripheral = peripherals[indexPath.row]
        
        cell.textView.text = "\(peripheral)"
        return cell
    }
    
}