//
//  NotifiOSCumulationCenter.swift
//  NotifiOSCumulation
//
//  Created by Bui Hai on 9/21/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//

import UIKit
import CoreData

public class NotifiOSCumulationCenter {
    
    let persistenceSetup : NCPersistenceStackSetup
    public init(storeURL : NSURL) {
        
        persistenceSetup = NCPersistenceStackSetup(storePath: storeURL)
        persistenceSetup.setUpContext()
        
        
    }
    
    public var allNotifications : [NCNotification]? {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        let results = try? persistenceSetup.context.executeFetchRequest(fetchRequest)
        return (results as? [NCNotification])

        
    }
    
    public var unreadCount : Int {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(format: "read == NO", argumentArray: nil)
        fetchRequest.resultType = .CountResultType
        let results = persistenceSetup.context.countForFetchRequest(fetchRequest, error: nil)
        return results

        
    }

    
    public func add( notifcationTilte: String, summary: String, notificationID : String, notificationCreatedDate dateAdded : NSDate = NSDate(), actionID : String = "", targetObjectID : String = "", callback: (NSError?)->()) {
        
        let notif = NSEntityDescription.insertNewObjectForEntityForName(NCNotification.entityName,
            inManagedObjectContext: persistenceSetup.context) as! NCNotification
        notif.title = notifcationTilte
        notif.summary = summary
        notif.notificationID = notificationID
        notif.dateAdded = dateAdded
        notif.actionID = actionID
        notif.targetObjectID = targetObjectID
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
        
        }
        catch {
            
            callback(error as NSError)
            
        }

        
        
    }
    
    
    public func remove (notif : NCNotification, callback : (NSError?)-> ()) {
        
        persistenceSetup.context.deleteObject(notif)
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

    public func markAsRead (notifications : [NCNotification], callback: (NSError?)->Void) {
        
        for notif in notifications {
            
            notif.read = true
            
        }
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
            
        } catch {
            
            callback(error as NSError)
            
        }

        
    }
    
    public func markAllAsRead (callback: (NSError?)->()) {
        
        
        
        
    }

    
}

class NCPersistenceStackSetup : NSObject{
    
    var storePath_ : NSURL
    var storePath : NSURL {
        
        return storePath_
        
    }
    

    
    init (storePath : NSURL) {
        
        storePath_ = storePath
        
    }
    
    
    var context_ : NSManagedObjectContext! = nil
    var context : NSManagedObjectContext! {
     
            return context_
        
    }
    
    
    func setUpContext () {
        
        if context_ == nil {
            
            let thisBundle = NSBundle(forClass: NCPersistenceStackSetup.classForCoder())
            var managedModel_ : NSManagedObjectModel! = nil
            var persistenceCoordinator_ : NSPersistentStoreCoordinator! = nil
            managedModel_ = NSManagedObjectModel(contentsOfURL: thisBundle.URLForResource("Model", withExtension: "momd")!)
            persistenceCoordinator_ = NSPersistentStoreCoordinator(managedObjectModel: managedModel_)
            try! persistenceCoordinator_.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storePath, options: [NSInferMappingModelAutomaticallyOption:true])
            context_ = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            context_?.persistentStoreCoordinator = persistenceCoordinator_
            
        }
        
    }
    
}







