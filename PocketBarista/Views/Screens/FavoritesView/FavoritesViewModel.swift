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
    @Published var roasters: [PBRoaster] = []
    let manager = CoreDataManager.shared
    func fetchCoffees() {
        coffees = manager.fetchCoffees()
    }
    func fetchRoasters() {
        roasters = manager.fetchRoasters()
    }
    func deleteCoffee(_ coffee: PBCoffee) {
        print("Will delete \(coffee.name)")
        manager.delete(coffee)
    }
}
