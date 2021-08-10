//
//  BrewStepsViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/28/21.
//

import Foundation
class BrewStepsViewModel: ObservableObject {
    @Published var brewQuantity: String {
        didSet {
            changedValue()
        }
    }
    @Published var brewMeasurement: MeasurementType {
        didSet {
            changedValue()
        }
    }
    @Published var coffeeRatioQuantity: String {
        didSet {
            changedValue()
        }
    }
    @Published var coffeeRatioMeasurement: MeasurementType {
        didSet {
            changedValue()
        }
    }
    @Published var waterRatioQuantity: String {
        didSet {
            changedValue()
        }
    }
    @Published var waterRatioMeasurement: MeasurementType {
        didSet {
            changedValue()
        }
    }
    @Published var waterRequiredValue: Float = 0
    @Published var waterRequiredMeasurement: MeasurementType {
        didSet {
            changedValue()
        }
    }
    @Published var coffeeRequiredValue: Float = 0
    @Published var coffeeRequiredMeasurement: MeasurementType {
        didSet {
            changedValue()
        }
    }
    @Published var strength: Strength {
        didSet {
            strengthSetRatio()
        }
    }
    @Published var keyboardShowing: Bool? = false
    @Published var showingStrengthSheet: Bool = false
    @Published var showingMeasurementSheet: Bool = false
    @Published var customRatio: Bool = false {
        didSet {
            if !customRatio {
                strengthSetRatio()
            }
        }
    }
    init() {
        brewQuantity = UserDefaultsManager.shared.getBrewQuantity()
        brewMeasurement = UserDefaultsManager.shared.getBrewMeasurement()
        coffeeRequiredMeasurement = UserDefaultsManager.shared.getCoffeeRequiredMeasurement()
        waterRequiredMeasurement = UserDefaultsManager.shared.getWaterRequiredMeasurement()
        coffeeRatioQuantity = "1"
        waterRatioQuantity = "17"
        coffeeRatioMeasurement = .gram
        waterRatioMeasurement = .gram
        strength = .regular
        if let coffeeRatioQuantity = UserDefaultsManager.shared.getCoffeeRatioQuantity(),
           let coffeeRatioMeasurement = UserDefaultsManager.shared.getCoffeeRatioMeasurement(),
           let waterRatioQuantity = UserDefaultsManager.shared.getWaterRatioQuantity(),
           let waterRatioMeasurement = UserDefaultsManager.shared.getWaterRatioMeasurement() {
            print("these defaults have a value")
            self.coffeeRatioQuantity = coffeeRatioQuantity
            self.coffeeRatioMeasurement = coffeeRatioMeasurement
            self.waterRatioQuantity = waterRatioQuantity
            self.waterRatioMeasurement = waterRatioMeasurement
            customRatio = true
        } else if let strength = UserDefaultsManager.shared.getStrength() {
            print("in the strength default")
            self.strength = strength
            strengthSetRatio()
        } else {
            print("no strength...setting it to regular")
            self.strength = .regular
            strengthSetRatio()
        }
    }
    func changedValue() {
        let requiredWater = brewQuantityToGrams
        let waterInDisplay = convertToSelectedMeasurement(requiredWater, waterRequiredMeasurement)
        let requiredCoffee = coffeeResultInGrams
        let coffeeInDisplay = convertToSelectedMeasurement(requiredCoffee, coffeeRequiredMeasurement)
        waterRequiredValue = waterInDisplay
        coffeeRequiredValue = coffeeInDisplay
        print("Water required: \(waterRequiredValue)")
        print("Coffee required: \(coffeeRequiredValue)")
    }
    var coffeeRatioQuantityToGrams: Float {
        guard let quantity = Float(coffeeRatioQuantity) else { return 0 }
        return convertValueToGrams(quantity, coffeeRatioMeasurement)
    }
    var waterRatioQuantityToGrams: Float {
        guard let quantity = Float(waterRatioQuantity) else { return 0 }
        return convertValueToGrams(quantity, waterRatioMeasurement)
    }
    var brewQuantityToGrams: Float {
        guard let quantity = Float(brewQuantity) else { return 0 }
        return convertValueToGrams(quantity, brewMeasurement)
    }
    var coffeeToWaterRatio: Float {
        guard coffeeRatioQuantityToGrams != 0
                && waterRatioQuantityToGrams != 0 else {
            return 0
        }
        return coffeeRatioQuantityToGrams / waterRatioQuantityToGrams
    }
    var coffeeResultInGrams: Float {
        guard coffeeRatioQuantityToGrams != 0 && brewQuantityToGrams != 0 else {
            return 0
        }
        return coffeeToWaterRatio * brewQuantityToGrams
    }
    func convertValueToGrams(_ value: Float, _ measurement: MeasurementType) -> Float {
        switch measurement {
        case .ounce:
            return value * 28.3495
        case .gram:
            return value
        case .liter:
            return value * 1000
        case .cup:
            return value * 28.3495 * 8
        }
    }
    func convertToSelectedMeasurement(_ value: Float, _ measurement: MeasurementType) -> Float {
        switch measurement {
        case .ounce:
            return value / 28.3495
        case .gram:
            return value
        case .liter:
            return value / 1000
        case .cup:
            return value / (28.3495 * 8)
        }
    }
    func strengthSetRatio() {
            switch strength {
            case .strong:
                waterRatioQuantity = "15"
            case .regular:
                waterRatioQuantity = "17"
            case .weak:
                waterRatioQuantity = "19"
            }
        coffeeRatioQuantity = "1"
        coffeeRatioMeasurement = .gram
        waterRatioMeasurement = .gram
    }
    func saveDefaults() {
        print("save defaults. Custom ratio \(customRatio)")
        UserDefaultsManager.shared.setBrewQuantity(brewQuantity)
        UserDefaultsManager.shared.setBrewMeasurement(brewMeasurement)
        UserDefaultsManager.shared.setCoffeeRequiredMeasurement(coffeeRequiredMeasurement)
        UserDefaultsManager.shared.setWaterRequiredMeasurement(waterRequiredMeasurement)
        if customRatio {
            print("coffee ratio quantity " + coffeeRatioQuantity)
            print("coffee measurement " + coffeeRatioMeasurement.rawValue)
            print("water quantity " + waterRatioQuantity)
            print("water measurement " + waterRatioMeasurement.rawValue)
            UserDefaultsManager.shared.setCoffeeRatioQuantity(coffeeRatioQuantity)
            UserDefaultsManager.shared.setCoffeeRatioMeasurement(coffeeRatioMeasurement)
            UserDefaultsManager.shared.setWaterRatioQuantity(waterRatioQuantity)
            UserDefaultsManager.shared.setWaterRatioMeasurement(waterRatioMeasurement)
            UserDefaultsManager.shared.setStrength(nil)
        } else {
            UserDefaultsManager.shared.setStrength(strength)
            UserDefaultsManager.shared.setCoffeeRatioQuantity(nil)
            UserDefaultsManager.shared.setCoffeeRatioMeasurement(nil)
            UserDefaultsManager.shared.setWaterRatioQuantity(nil)
            UserDefaultsManager.shared.setWaterRatioMeasurement(nil)
        }
    }
}
