//
//  SelectCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/16/21.
//

import Foundation

class SelectCoffeeViewModel: ObservableObject {
    @Published var availableCoffees: [PBCoffee] = []
    @Published var searchCoffees: [PBCoffee]    = []
    @Published var searchText                   = "" {
        didSet {
            if searchText.isEmpty {
                searchCoffees = availableCoffees
            } else {
                searchCoffees = availableCoffees.filter({ $0.name!.contains(searchText)})
            }
        }
    }
    func fetchCoffees() {
        availableCoffees = CoreDataManager.shared.fetchCoffees()
        searchCoffees = availableCoffees
    }
    func checkSelected(selected: PBCoffee?, coffee: PBCoffee) -> Bool {
        if let selected = selected, selected == coffee {
            return true
        } else {
            return false
        }
    }
}
