//
//  NotifiOSCumulationCenter.swift
//  NotifiOSCumulation
//
//  Created by Bui Hai on 9/21/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit

protocol NotifiOSCumulationCenterObserver {
    
    func notificationAdded ()
    
    
}

public class NotifiOSCumulationCenter: NSObject {
    
    public var allNotifications : [NCNotification] {
        
//        TODO:
        
        return []
    }

    public func addNotification(tilte: String, summary: String, notificationID : String) {
        
        
        
    }
    
    
    public func markAllAsRead () {
        
        
        
    }
    
    
    
    
}
