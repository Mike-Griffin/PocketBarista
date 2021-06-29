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
        coffees = manager.fetchCoffees()
    }
}
