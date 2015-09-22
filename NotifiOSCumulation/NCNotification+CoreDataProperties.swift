//
//  NCNotification+CoreDataProperties.swift
//  NotifiOSCumulation
//
//  Created by Bui Hai on 9/22/15.
//  Copyright © 2015 Bui Hai. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NCNotification {

    @NSManaged var notificationID: String?
    @NSManaged var title: String?
    @NSManaged var summary: String?
    @NSManaged var actionID: String?
    @NSManaged var read: NSNumber?
    @NSManaged var dateAdded: NSDate?
    @NSManaged var imageURL: String?

}
