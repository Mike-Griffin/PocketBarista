//
//  FavoritesViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/28/21.
//

import Foundation
import CoreData
class FavoritesViewModel: ObservableObject {
    @Published var coffees: [PBCoffee] = []
    let manager = CoreDataManager.shared
    func fetchCoffees() {
        let request = NSFetchRequest<PBCoffee>(entityName: DataModel.coffee)
        do {
            coffees = try manager.container.viewContext.fetch(request)
        } catch {
            print("Error loading coffee data")
        }
    }
}
