//
//  DefaultNotificationsTableViewController.swift
//  NotifiOSCumulation
//
//  Created by SB 8 on 9/29/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit

public class DefaultNotificationsTableViewController: UITableViewController {

    public class func createBuiltinViewController () -> DefaultNotificationsTableViewController {
        
        let builtStoryBoard = UIStoryboard(name: "Storyboard", bundle: NSBundle(forClass: DefaultNotificationsTableViewController.classForCoder()))
        let vcToReturn = builtStoryBoard.instantiateInitialViewController() as! DefaultNotificationsTableViewController
        
        return vcToReturn
        
    }

    
    
//    MARK: built-in controls
    @IBOutlet var clearAllButton: UIBarButtonItem!
    @IBOutlet var markAllAsReadButton: UIBarButtonItem!
    


    
//    MARK: public configuration & query
    var notificationCumulationCenter_ : NotifiOSCumulationCenter? = nil
    public var notificationCumulationCenter : NotifiOSCumulationCenter? {
        
        get {
            
            return notificationCumulationCenter_
            
        }
        
        set {
            
            notificationCumulationCenter_ = newValue
            refreshViewData()
            
        }
        
    }
    
    
    public func refreshViewData () {
        
        allNotifications_ = notificationCumulationCenter_?.allNotifications ?? []
        tableView?.reloadData()
        
        
    }
    
    

    
    var allNotifications_ : [NCNotification] = []
    public var allNotifcations : [NCNotification] {
        
        get {
            
            return allNotifications_
            
        }
        
    }
    
    
//    MARK: internal implementations - here are dragons
    @IBAction func markAllAsRead(sender: AnyObject) {
        
        notificationCumulationCenter!.markAsRead(allNotifcations) { (_) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.tableView.reloadData()
                
            })
            
        }
        
    }
    
    
    @IBAction func clearAllNotifications(sender: AnyObject) {
        
        
        notificationCumulationCenter!.removeAll { (_) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.refreshViewData()
                
            })
            
        }
        
        
    }
    

    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return allNotifcations.count

        
    }

    let cellID = "vn.haibui.NCNotificationCell"
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! NCNotificationTableViewCell
        

        // Configure the cell...
        cell.notif = allNotifcations[indexPath.row]
        
        

        return cell
    }


    // Override to support editing the table view.
    override public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            notificationCumulationCenter?.remove(allNotifcations[indexPath.row]) { (error : NSError?) -> () in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if error == nil {
                        
                        self.allNotifications_.removeAtIndex(indexPath.row)
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        
                        
                    } else {
                        
                        
                    }
                    
                })
                
            }
            
        }
        
    }
    
    

}
