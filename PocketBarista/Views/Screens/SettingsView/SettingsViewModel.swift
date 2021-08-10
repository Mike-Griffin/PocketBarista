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
            if !coffeeRatioQuantity.isEmpty, customRatioShowing {
                UserDefaultsManager.shared.setCoffeeRatioQuantity(coffeeRatioQuantity)
            }
        }
    }
    @Published var coffeeRatioMeasurement: MeasurementType {
        didSet {
            if customRatioShowing {
            UserDefaultsManager.shared.setCoffeeRatioMeasurement(coffeeRatioMeasurement)
            }
        }
    }
    @Published var waterRatioQuantity: String {
        didSet {
            if !waterRatioQuantity.isEmpty, customRatioShowing {
                UserDefaultsManager.shared.setWaterRatioQuantity(waterRatioQuantity)
            }
        }
    }
    @Published var waterRatioMeasurement: MeasurementType {
        didSet {
            if customRatioShowing {
                UserDefaultsManager.shared.setWaterRatioMeasurement(waterRatioMeasurement)
            }
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
            if !customRatioShowing {
                UserDefaultsManager.shared.setStrength(strength)
            }
        }
    }
    @Published var customRatioShowing = false {
        didSet {
            customRatioChanged()
        }
    }
    init() {
        brewQuantity = UserDefaultsManager.shared.getBrewQuantity()
        brewMeasurement = UserDefaultsManager.shared.getBrewMeasurement()
        coffeeRequiredMeasurement = UserDefaultsManager.shared.getCoffeeRequiredMeasurement()
        waterRequiredMeasurement = UserDefaultsManager.shared.getWaterRequiredMeasurement()
        coffeeRatioQuantity = "1"
        waterRatioQuantity = "15"
        coffeeRatioMeasurement = .gram
        waterRatioMeasurement = .gram
        self.strength = .regular
        getDefaults()
    }
    func getDefaults() {
        brewQuantity = UserDefaultsManager.shared.getBrewQuantity()
        brewMeasurement = UserDefaultsManager.shared.getBrewMeasurement()
        if let coffeeRatioQuantity = UserDefaultsManager.shared.getCoffeeRatioQuantity(),
        let coffeeRatioMeasurement = UserDefaultsManager.shared.getCoffeeRatioMeasurement(),
        let waterRatioQuantity = UserDefaultsManager.shared.getWaterRatioQuantity(),
        let waterRatioMeasurement = UserDefaultsManager.shared.getWaterRatioMeasurement() {
            print("values have defaults")
            self.coffeeRatioQuantity = coffeeRatioQuantity
            self.coffeeRatioMeasurement = coffeeRatioMeasurement
            self.waterRatioQuantity = waterRatioQuantity
            self.waterRatioMeasurement = waterRatioMeasurement
            customRatioShowing = true
        } else if let strength = UserDefaultsManager.shared.getStrength() {
            print("strength")
            self.strength = strength
        } else {
            print("nope")
            self.strength = .regular
        }
        coffeeRequiredMeasurement = UserDefaultsManager.shared.getCoffeeRequiredMeasurement()
        waterRequiredMeasurement = UserDefaultsManager.shared.getWaterRequiredMeasurement()
    }
    func customRatioChanged() {
        switch customRatioShowing {
        case true:
            UserDefaultsManager.shared.setCoffeeRatioQuantity(coffeeRatioQuantity)
            UserDefaultsManager.shared.setCoffeeRatioMeasurement(coffeeRatioMeasurement)
            UserDefaultsManager.shared.setWaterRatioQuantity(waterRatioQuantity)
            UserDefaultsManager.shared.setWaterRatioMeasurement(waterRatioMeasurement)
            UserDefaultsManager.shared.setStrength(nil)
        case false:
            UserDefaultsManager.shared.setStrength(strength)
            UserDefaultsManager.shared.setCoffeeRatioQuantity(nil)
            UserDefaultsManager.shared.setCoffeeRatioMeasurement(nil)
            UserDefaultsManager.shared.setWaterRatioQuantity(nil)
            UserDefaultsManager.shared.setWaterRatioMeasurement(nil)
        }
    }
}
