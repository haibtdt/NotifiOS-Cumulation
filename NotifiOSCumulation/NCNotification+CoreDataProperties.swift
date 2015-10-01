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

    @NSManaged public var notificationID: String?
    @NSManaged public var title: String?
    @NSManaged public var summary: String?
    @NSManaged public var actionID: String?
    @NSManaged public var read: NSNumber?
    @NSManaged public var dateAdded: NSDate?
    @NSManaged public var imageURL: String?
    @NSManaged public var targetObjectID: String?

}
