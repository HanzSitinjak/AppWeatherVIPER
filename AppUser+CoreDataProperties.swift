//
//  AppUser+CoreDataProperties.swift
//  
//
//  Created by Aleph-AHV2D on 17/10/24.
//
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var username: String?

}
