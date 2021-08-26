//
//  LogBrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI
import Combine

class LogBrewViewModel: ObservableObject {
    @Published var grindSetting: String = ""
    @Published var rating: Int = 0
    @Published var selectedCoffee: PBCoffee?
    @Published var isShowingCoffeePicker        = false
    @Published var notes = ""
    @Published var alertItem: AlertItem?
    @Published var navigateHome = false
    func saveBrewLog(brewQuantity: String, waterQuantity: String, coffeeQuantity: String) {
        var ratioFloat: Float?
        if let waterQuantity = Float(waterQuantity), let coffeeQuantity = Float(coffeeQuantity) {
            ratioFloat = coffeeQuantity / waterQuantity
        }
        guard selectedCoffee != nil else {
            alertItem = AlertContext.noCoffeeSelected
            return
        }
        CoreDataManager.shared.addBrewLog(ratio: ratioFloat,
                                          waterQuantity: brewQuantity,
                                          notes: notes,
                                          grindSetting: grindSetting,
                                          rating: rating,
                                          coffee: selectedCoffee)
        alertItem = AlertItem(title: Text("Log Saved"),
                              message: Text("Successfully Saved Coffee log"),
                              primaryButton: nil, secondaryButton: nil)
    }
    func saveWithoutCoffee(brewQuantity: String, waterQuantity: String, coffeeQuantity: String) {
        var ratioFloat: Float?
        if let waterQuantity = Float(waterQuantity), let coffeeQuantity = Float(coffeeQuantity) {
            ratioFloat = coffeeQuantity / waterQuantity
        }
        CoreDataManager.shared.addBrewLog(ratio: ratioFloat,
                                          waterQuantity: brewQuantity,
                                          notes: notes,
                                          grindSetting: grindSetting,
                                          rating: rating,
                                          coffee: nil)
        navigateHome = true
    }
}
