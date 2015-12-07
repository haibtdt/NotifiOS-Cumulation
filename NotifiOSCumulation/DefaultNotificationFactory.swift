//
//  DefaultNotificationFactory.swift
//  NotifiOSCumulation
//
//  Created by Nibbana on 12/7/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit

public class DefaultNotificationControllerFactory: NSObject {

    public class func createBuiltinViewController () -> DefaultNotificationsTableViewController {
        
        let builtStoryBoard = UIStoryboard(name: "Storyboard", bundle: NSBundle(forClass: DefaultNotificationsTableViewController.classForCoder()))
        let vcToReturn = builtStoryBoard.instantiateInitialViewController() as! DefaultNotificationsTableViewController
        
        return vcToReturn
        
    }
    
}
