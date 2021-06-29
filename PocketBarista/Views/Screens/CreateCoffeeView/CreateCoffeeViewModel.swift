//
//  CreateCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import Foundation

class CreateCoffeeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var roaster: PBRoaster?
    let manager = CoreDataManager.shared
    func addCoffee() {
        guard !name.isEmpty else { return }
        manager.addCoffee(name: name, roaster: roaster)
    }
}
