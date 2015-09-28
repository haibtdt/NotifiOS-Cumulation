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
    
    public let persistenceSetup : NCPersistenceStackSetup
    init(setup : NCPersistenceStackSetup) {
        
        persistenceSetup = setup
        
        
    }
    
    public var allNotifications : [NCNotification]? {
        
        let fetchRequest = NSFetchRequest(entityName: NCNotification.entityName)
        fetchRequest.predicate = NSPredicate(value: true)
        let results = try? persistenceSetup.context.executeFetchRequest(fetchRequest)
        return (results as? [NCNotification])

        
    }

    
    public func add( notifcationTilte: String, summary: String, notificationID : String, callback: (NSError?)->()) {
        
        let notif = NSEntityDescription.insertNewObjectForEntityForName(NCNotification.entityName,
            inManagedObjectContext: persistenceSetup.context) as! NCNotification
        notif.title = notifcationTilte
        notif.summary = summary
        notif.notificationID = notificationID
        do {
            
            try persistenceSetup.context.save()
            callback(nil)
        
        }
        catch {
            
            callback(error as NSError)
            
        }

        
        
    }
    
    
    public func remove (notif : NCNotification, callback : (NSError?)-> ()) {
        
        
        
    }
    
    public func update (notif : NCNotification, callback : (NSError?) -> ()) {
        
        
        
    }

    
    public func markAllAsRead (callback: (NSError?)->()) {
        
        
        
    }

    
}

public class NCPersistenceStackSetup : NSObject{
    
    var storePath_ : NSURL
    public var storePath : NSURL {
        
        return storePath_
        
    }
    

    
    public init (storePath : NSURL) {
        
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
            let _ = NSPersistentStore(persistentStoreCoordinator: persistenceCoordinator_,
                configurationName: nil,
                URL: storePath,
                options: nil)
            context_ = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            context_?.persistentStoreCoordinator = persistenceCoordinator_
            
        }
        
    }
    
}







