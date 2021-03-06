//
//  CoreDataManager.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/28/21.
//

import CoreData
import UIKit

struct CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    static var preview: CoreDataManager = {
        let manager = CoreDataManager(inMemory: true)
        let coffee = PBCoffee(context: manager.container.viewContext)
        coffee.name = "Golden Sunshine"
        let roaster = PBRoaster(context: manager.container.viewContext)
        roaster.name = "Chromatic"
        roaster.location = "San Jose"
        roaster.coffees = [coffee]
        return manager
    }()
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: DataModel.main)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Implement an actual error handling: \(error.localizedDescription)")
            }
        }
    }
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }
    // MARK: Coffee
    func fetchCoffees() -> [PBCoffee] {
        let request = NSFetchRequest<PBCoffee>(entityName: DataModel.coffee)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error loading coffee data")
            return []
        }
    }
    func addCoffee(name: String, roaster: PBRoaster?, rating: Int, image: UIImage?, tags: [PBTag]) {
        let coffee = PBCoffee(context: container.viewContext)
        coffee.name = name
        if let roaster = roaster {

            coffee.roaster = roaster
        }
        if rating > 0 && rating <= 5 {
            coffee.rating = Int16(rating)
        }
        if let image = image {
            coffee.image = image.pngData()
        }
        let tagsSet = Set(tags) as NSSet
        coffee.addToTags(tagsSet)
        save()
    }
    func editCoffee(coffee: PBCoffee) {
        save()
    }
    // MARK: Roaster
    func fetchRoasters() -> [PBRoaster] {
        let request = NSFetchRequest<PBRoaster>(entityName: DataModel.roaster)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error loading roaster data")
            return []
        }
    }
    func addRoaster(name: String, location: String) {
        let roaster = PBRoaster(context: container.viewContext)
        roaster.name = name
        roaster.location = location
        save()
    }
    func editRoaster(roaster: PBRoaster) {
        save()
    }
    // MARK: Tag
    func fetchTags() -> [PBTag] {
        let request = NSFetchRequest<PBTag>(entityName: DataModel.tag)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error loading tag data")
            return []
        }
    }
    func addTag(name: String) -> PBTag {
        let tag = PBTag(context: container.viewContext)
        tag.name = name
        save()
        return tag
    }
    // MARK: BrewLog
    func fetchBrewLogs() -> [PBBrewLog] {
        let request = NSFetchRequest<PBBrewLog>(entityName: DataModel.brewLog)
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dateSort]
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error loading brew log data")
            return []
        }
    }
    func addBrewLog(ratio: Float?, waterQuantity: String, notes: String,
                    grindSetting: String, rating: Int, coffee: PBCoffee?) {
        let brewLog = PBBrewLog(context: container.viewContext)
        let date = Date()
        brewLog.date = date
        if let ratio = ratio {
            brewLog.ratio = ratio
        }
        if let waterQuantity = Int16(waterQuantity) {
            brewLog.waterQuantity = waterQuantity
        }
        brewLog.coffee = coffee
        if !notes.isEmpty {
            brewLog.notes = notes
        }
        if rating > 0, rating <= 5 {
            brewLog.rating = Int16(rating)
        }
        if let grindSetting = Int16(grindSetting) {
            brewLog.grindSetting = grindSetting
        }
        save()
    }
}
