//
//  CoreDataManager.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/28/21.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    static var preview: CoreDataManager = {
        let manager = CoreDataManager(inMemory: true)
        let coffee = PBCoffee(context: manager.container.viewContext)
        coffee.name = "Golden Sunshine"
        coffee.originLocation = "Papua New Guinea"
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
}
