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
        roaster.coffees = coffee
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
    func addCoffee(name: String, roaster: PBRoaster?, rating: Int, image: UIImage?) {
        let coffee = PBCoffee(context: container.viewContext)
        coffee.name = name
        if let roaster = roaster {
            print("roaster in the core data manager add coffee")
            print(roaster)
            coffee.roaster = roaster
        }
        if rating > 0 && rating <= 5 {
            coffee.rating = Int16(rating)
        }
        if let image = image {
            coffee.image = image.pngData()
        }
        save()
    }
    func addRoaster(name: String, location: String) {
        let roaster = PBRoaster(context: container.viewContext)
        roaster.name = name
        roaster.location = location
        save()
    }
    func fetchCoffees() -> [PBCoffee] {
        let request = NSFetchRequest<PBCoffee>(entityName: DataModel.coffee)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error loading coffee data")
            return []
        }
    }
    func fetchRoasters() -> [PBRoaster] {
        let request = NSFetchRequest<PBRoaster>(entityName: DataModel.roaster)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error loading roaster data")
            return []
        }
    }
}
