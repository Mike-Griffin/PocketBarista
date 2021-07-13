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
    func save(_ context: NSManagedObjectContext) {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    fatalError("Implement an actual error handling: \(error.localizedDescription)")
                }
            }
    }
    func delete(_ object: NSManagedObject) {
        container.performBackgroundTask { context in
            container.viewContext.delete(object)
            save(context)
        }
    }
    func addCoffee(name: String, roaster: PBRoaster?, rating: Int, image: UIImage?, tags: [PBTag]) {
        container.performBackgroundTask { context in
            let coffee = PBCoffee(context: context)
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
            save(context)
        }

    }
    func addRoaster(name: String, location: String) {
        container.performBackgroundTask { context in
            let roaster = PBRoaster(context: container.viewContext)
            roaster.name = name
            roaster.location = location
            save(context)
        }
    }
    func addTag(name: String) {
        container.performBackgroundTask { context in
            let tag = PBTag(context: container.viewContext)
            tag.name = name
            save(context)
        }
    }
    func fetchCoffees(completed: @escaping (Result<[PBCoffee], Error>) -> Void) {
        let context = container.viewContext
        context.perform {
            let request = NSFetchRequest<PBCoffee>(entityName: DataModel.coffee)
            do {
                let result = try context.fetch(request)
                completed(.success(result))
            } catch {
                print("Error loading coffee data")
                completed(.failure(error))
            }
        }

    }
    func fetchRoasters(completed: @escaping (Result<[PBRoaster], Error>) -> Void) {
        let context = container.viewContext
        context.perform {
            let request = NSFetchRequest<PBRoaster>(entityName: DataModel.roaster)
            do {
                let result = try context.fetch(request)
                completed(.success(result))
            } catch {
                print("Error loading roaster data")
                completed(.failure(error))
            }
        }
    }
    func fetchTags(completed: @escaping (Result<[PBTag], Error>) -> Void) {
        let context = container.viewContext
        context.perform {
            let request = NSFetchRequest<PBTag>(entityName: DataModel.tag)
            do {
                let result = try context.fetch(request)
                completed(.success(result))
            } catch {
                print("Error loading tag data")
                completed(.failure(error))
            }
        }
    }
}
