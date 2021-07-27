//
//  PBCoffee+CoreDataProperties.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/25/21.
//
//

import Foundation
import CoreData

extension PBCoffee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PBCoffee> {
        return NSFetchRequest<PBCoffee>(entityName: "PBCoffee")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var rating: Int16
    @NSManaged public var review: String?
    @NSManaged public var brewLogs: PBBrewLog?
    @NSManaged public var roaster: PBRoaster?
    @NSManaged public var tags: NSSet?
    var displayText: String {
        guard let name = name else { return "No Name?" }
        if let roaster = roaster {
            if let roasterName = roaster.name {
                return roasterName + " " + name
            } else {
                return name
            }
        } else {
            return name
        }
    }

}

// MARK: Generated accessors for tags
extension PBCoffee {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: PBTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: PBTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension PBCoffee: Identifiable {

}
