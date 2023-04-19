//
//  UserInfo+CoreDataProperties.swift
//  CoreData
//
//  Created by Victor Garitskyu on 19.04.2023.
//

import Foundation
import CoreData
import UIKit

extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var avatarImage: Data?
    @NSManaged public var birthday: Date?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
}

extension UserInfo : Identifiable {

}
