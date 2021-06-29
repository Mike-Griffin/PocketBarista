//
//  CreateCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import Foundation
import CoreData

class CreateCoffeeViewModel: ObservableObject {
    @Published var name: String = ""
    let manager = CoreDataManager.shared
    func addCoffee() {
        // To do convert this to an error handle
        guard !name.isEmpty else { return }
        let coffee = PBCoffee(context: manager.container.viewContext)
        coffee.name = name
        manager.save()
    }
}
