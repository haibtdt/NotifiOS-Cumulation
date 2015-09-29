//
//  ViewController.swift
//  ExampleApp
//
//  Created by Bui Hai on 9/21/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit
import NotifiOSCumulation

class ViewController: UIViewController {

    
    var notificationCenter_ : NotifiOSCumulationCenter? = nil
    var notificationCenter : NotifiOSCumulationCenter {
        
        if notificationCenter_ == nil {
            
            var storeURL : NSURL {
                
                let defaultFileManager = NSFileManager.defaultManager()
                let appDirURL = try! defaultFileManager.URLForDirectory(NSSearchPathDirectory.ApplicationSupportDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
                return appDirURL.URLByAppendingPathComponent("notifs.store")
                
                
            }

            notificationCenter_ = NotifiOSCumulationCenter(storeURL: storeURL)
            
        }
        
        return notificationCenter_!
        
    }
    
    
    @IBAction func showNotifications(sender: AnyObject) {
        
        notificationCenter.add("notif 1", summary: "summary of notif 1", notificationID: "001") { err in
            
            
        }
        notificationCenter.add("notif 2", summary: "summary of notif 2", notificationID: "002") { (err) -> () in
            
            
        }
        
        let notificationTableVC = DefaultNotificationsTableViewController.createBuiltinViewController()
        notificationTableVC.notificationCumulationCenter = notificationCenter
        self.navigationController?.pushViewController(notificationTableVC, animated: true)
        
        
    }

}

