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
    @Published var showingCreateCoffee = false
    @Published var showingCreateRoaster = false
    @Published var selectedCoffee: PBCoffee?
    let manager = CoreDataManager.shared
    func fetchCoffees() {
        manager.fetchCoffees { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coffees):
                    print("great success")
                    self.coffees = coffees
                case .failure(_):
                    // TODO reconsider if I need to set coffees to blank
                    break
                }
            }
        }
    }
    func fetchRoasters() {
        manager.fetchRoasters { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let roasters):
                    self.roasters = roasters
                case .failure(_):
                    // TODO reconsider if I want to just break
                    self.roasters = []
                }
            }
        }

    }
    func deleteCoffee(_ coffee: PBCoffee) {
        manager.delete(coffee)
    }
}
