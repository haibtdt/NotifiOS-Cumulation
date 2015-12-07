//
//  NotifiOSCumulationCenter.swift
//  NotifiOSCumulation
//
//  Created by Bui Hai on 9/21/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit
import CoreData

public protocol NotifiOSCumulationCenterObserver : class {
    
    func notificationAdded (addedNotif : NCNotification)
    func notificationsUpdated (updatedNotifs : [NCNotification])
    func notificationsWillBeRemoved (notifs : [NCNotification])
    
}

public class NotifiOSCumulationCenter {
    
    let persistenceSetup : NCPersistenceStackSetup
    public init(var storeURL : NSURL! = nil) {
        
        if storeURL == nil {
            
            let defaultFileManager = NSFileManager.defaultManager()
            let appDirURL = try! defaultFileManager.URLForDirectory(NSSearchPathDirectory.ApplicationSupportDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
            storeURL = appDirURL.URLByAppendingPathComponent("notifs.store")
            
            
        }

        
        persistenceSetup = NCPersistenceStackSetup(storePath: storeURL)
        persistenceSetup.setUpContext()
        
        
    }
    public var observer : NotifiOSCumulationCenterObserver? = nil
    
//    MARK: queries
    public var allNotifications : [NCNotification]? {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        let results = try? persistenceSetup.context.executeFetchRequest(fetchRequest)
        return (results as? [NCNotification])

        
    }
    
    
    public func getNotification(notificationID : String) -> NCNotification? {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(format: "notificationID == %@", argumentArray: [notificationID])
        fetchRequest.fetchLimit = 1
        let results = (try? persistenceSetup.context.executeFetchRequest(fetchRequest)) as? [NCNotification]
        return results?.first
        
        
    }
    
    
    public var unreadCount : Int {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(format: "read == NO", argumentArray: nil)
        fetchRequest.resultType = .CountResultType
        let results = persistenceSetup.context.countForFetchRequest(fetchRequest, error: nil)
        return results

        
    }

    
//    MARK: managements
    public func add(
        notifcationTilte: String,
        summary: String,
        notificationID : String,
        notificationCreatedDate dateAdded : NSDate = NSDate(),
        actionID : String = "",
        targetObjectID : String = "",
        imageURL : String? = nil ,
        callback: (NSError?)->()) {
        
        let notif = NSEntityDescription.insertNewObjectForEntityForName(NCNotification.entityName,
            inManagedObjectContext: persistenceSetup.context) as! NCNotification
        notif.title = notifcationTilte
        notif.summary = summary
        notif.notificationID = notificationID
        notif.dateAdded = dateAdded
        notif.actionID = actionID
        notif.targetObjectID = targetObjectID
        notif.imageURL = imageURL
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
            observer?.notificationAdded(notif)
        
        }
        catch {
            
            callback(error as NSError)
            
        }
        
    }
    
    
    public func remove (notif : NCNotification, callback : (NSError?)-> ()) {
        
        observer?.notificationsWillBeRemoved([notif])
        persistenceSetup.context.deleteObject(notif)
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
            
        }
        catch {
            
            callback(error as NSError)
            
        }

    }
    
    
    public func removeAll (callback : (NSError?)->()) {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.includesPropertyValues = false
        let results = try! persistenceSetup.context.executeFetchRequest(fetchRequest) as! [NCNotification]
        observer?.notificationsWillBeRemoved(results)
        for notif in (results){
            
            persistenceSetup.context.deleteObject(notif)

        }
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
            
        }
        catch {
            
            callback(error as NSError)
            
        }
        
        
    }
    
    
    public func update (notif : NCNotification, callback : (NSError?) -> ()) {
        
        if let _ = persistenceSetup.context.objectRegisteredForID(notif.objectID) {
            
            do {
                
                try persistenceSetup.context.save()
                callback(nil)
                observer?.notificationsUpdated([notif])
                
            } catch {
                
                callback(error as NSError)
                
            }
            
            
        } else {
            
            let error = NSError(domain: "NotifiOSCumulation", code: 0, userInfo: [NSLocalizedDescriptionKey:"RESOURCE_NOT_EXISTING"])
            callback(error)
            
        }
        
    }
    
    
    public func markAsRead (notif : NCNotification, callback : (NSError?) -> Void) {
        
        notif.read = true
        update(notif, callback: callback)
        
    }

    public func onceMarkAsRead (notifications : [NCNotification], callback: (NSError?)->Void) {
        
        for notif in notifications {
            
            notif.read = true
            
        }
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
            observer?.notificationsUpdated(notifications)
            
        } catch {
            
            callback(error as NSError)
            
        }
        
    }
    
    public func markAllAsRead (callback: (NSError?)->()) {
        
        onceMarkAsRead(allNotifications!, callback: callback)
        
    }

    
}






