//
//  SettingsViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/15/21.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var brewQuantity: String {
        didSet {
            if !brewQuantity.isEmpty {
                UserDefaultsManager.shared.setBrewQuantity(brewQuantity)
            }
        }
    }
    @Published var brewMeasurement: MeasurementType {
        didSet {
            UserDefaultsManager.shared.setBrewMeasurement(brewMeasurement)
        }
    }
    @Published var coffeeRatioQuantity: String {
        didSet {
            if !coffeeRatioQuantity.isEmpty {
                UserDefaultsManager.shared.setCoffeeRatioQuantity(coffeeRatioQuantity)
            }
        }
    }
    @Published var coffeeRatioMeasurement: MeasurementType {
        didSet {
            UserDefaultsManager.shared.setCoffeeRatioMeasurement(coffeeRatioMeasurement)
        }
    }
    @Published var waterRatioQuantity: String {
        didSet {
            if !waterRatioQuantity.isEmpty {
                UserDefaultsManager.shared.setWaterRatioQuantity(waterRatioQuantity)
            }
        }
    }
    @Published var waterRatioMeasurement: MeasurementType {
        didSet {
            UserDefaultsManager.shared.setWaterRatioMeasurement(waterRatioMeasurement)
        }
    }
    @Published var coffeeRequiredMeasurement: MeasurementType {
        didSet {
            UserDefaultsManager.shared.setCoffeeRequiredMeasurement(coffeeRequiredMeasurement)
        }
    }
    @Published var waterRequiredMeasurement: MeasurementType {
        didSet {
            UserDefaultsManager.shared.setWaterRequiredMeasurement(waterRequiredMeasurement)
        }
    }
    @Published var strength: Strength {
        didSet {
            UserDefaultsManager.shared.setStrength(strength)
        }
    }
    @Published var customRatioShowing = false
    init() {
        brewQuantity = UserDefaultsManager.shared.getBrewQuantity()
        brewMeasurement = UserDefaultsManager.shared.getBrewMeasurement()
        coffeeRatioQuantity = UserDefaultsManager.shared.getCoffeeRatioQuantity()
        coffeeRatioMeasurement = UserDefaultsManager.shared.getCoffeeRatioMeasurement()
        waterRatioQuantity = UserDefaultsManager.shared.getWaterRatioQuantity()
        waterRatioMeasurement = UserDefaultsManager.shared.getWaterRatioMeasurement()
        coffeeRequiredMeasurement = UserDefaultsManager.shared.getCoffeeRequiredMeasurement()
        waterRequiredMeasurement = UserDefaultsManager.shared.getWaterRequiredMeasurement()
        strength = UserDefaultsManager.shared.getStrength()
    }
    func getDefaults() {
        brewQuantity = UserDefaultsManager.shared.getBrewQuantity()
        brewMeasurement = UserDefaultsManager.shared.getBrewMeasurement()
        coffeeRatioQuantity = UserDefaultsManager.shared.getCoffeeRatioQuantity()
        coffeeRatioMeasurement = UserDefaultsManager.shared.getCoffeeRatioMeasurement()
        waterRatioQuantity = UserDefaultsManager.shared.getWaterRatioQuantity()
        waterRatioMeasurement = UserDefaultsManager.shared.getWaterRatioMeasurement()
        coffeeRequiredMeasurement = UserDefaultsManager.shared.getCoffeeRequiredMeasurement()
        waterRequiredMeasurement = UserDefaultsManager.shared.getWaterRequiredMeasurement()
        strength = UserDefaultsManager.shared.getStrength()
    }
}
