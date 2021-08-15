//
//  LogBrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import Foundation
import Combine

class LogBrewViewModel: ObservableObject {
    @Published var grindSetting: String = ""
    @Published var rating: Int = 0
    @Published var selectedCoffee: PBCoffee?
    @Published var isShowingCoffeePicker        = false
    @Published var notes = ""
    func saveBrewLog(brewQuantity: String, waterQuantity: String, coffeeQuantity: String) {
        var ratioFloat: Float?
        if let waterQuantity = Float(waterQuantity), let coffeeQuantity = Float(coffeeQuantity) {
            ratioFloat = coffeeQuantity / waterQuantity
        }
        guard selectedCoffee != nil else {
            print("throw up an error about no coffee")
            return
        }
        print(rating)
        CoreDataManager.shared.addBrewLog(ratio: ratioFloat,
                                          waterQuantity: brewQuantity,
                                          notes: notes,
                                          grindSetting: grindSetting,
                                          rating: rating,
                                          coffee: selectedCoffee)
    }
}
