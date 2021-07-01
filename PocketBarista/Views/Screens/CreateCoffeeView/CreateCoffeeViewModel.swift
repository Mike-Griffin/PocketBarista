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
    @Published var selectedRoasterValue: String = ""
    @Published var availableRoasters: [PBRoaster]
    @Published var roasterIndex: Int = 0
    let manager = CoreDataManager.shared
    init() {
        availableRoasters = manager.fetchRoasters()
        print(availableRoasters)
        if !availableRoasters.isEmpty {
            roaster = availableRoasters[0]
            print(roaster)
        }
    }
    func addCoffee() {
        guard !name.isEmpty else { return }
        manager.addCoffee(name: name, roaster: roaster)
    }
    func fetchRoasters() {
        availableRoasters = manager.fetchRoasters()
    }
}
