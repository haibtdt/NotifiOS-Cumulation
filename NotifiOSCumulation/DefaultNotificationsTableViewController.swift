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
    
    var allNotifications_ : [NCNotification] = []
    var allNotifcations : [NCNotification] {
        
        get {
            
            return allNotifications_
            
        }
        
    }
    
    public func refreshViewData () {
        
        allNotifications_ = notificationCumulationCenter_?.allNotifications ?? []
        tableView?.reloadData()
        
        
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//         Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }


    // MARK: - Table view data source

 
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return allNotifcations.count

        
    }

    let cellID = "Cell Identifier"
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellID)
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID)

        }
        

        // Configure the cell...
        let notif = allNotifcations[indexPath.row]
        cell.detailTextLabel!.text = notif.summary
        cell.textLabel!.text = notif.title
        let isNotificationRead = notif.read!.boolValue
        cell.backgroundColor = isNotificationRead ? UIColor.whiteColor() : UIColor.lightGrayColor()
        
        
        

        return cell
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

        notificationCumulationCenter!.markAsRead(allNotifcations[indexPath.row]) { _ in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.tableView.reloadData()
                
            })
            
        }
        
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
