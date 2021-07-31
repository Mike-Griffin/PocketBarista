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
            strengthSetRatio(strength)
        }
    }
    @Published var keyboardShowing: Bool? = false
    @Published var showingStrengthSheet: Bool = false

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
    func changedValue() {
        let requiredWater = brewQuantityToGrams
        let waterInDisplay = convertToSelectedMeasurement(requiredWater, waterRequiredMeasurement)
        let requiredCoffee = coffeeResultInGrams
        let coffeeInDisplay = convertToSelectedMeasurement(requiredCoffee, coffeeRequiredMeasurement)
        waterRequiredValue = waterInDisplay
        coffeeRequiredValue = coffeeInDisplay
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
    func strengthSetRatio(_ strength: Strength) {
        switch strength {
        case .strong:
            coffeeRatioQuantity = "1"
            waterRatioQuantity = "15"
            coffeeRatioMeasurement = .gram
            waterRatioMeasurement = .gram
        case .regular:
            coffeeRatioQuantity = "1"
            waterRatioQuantity = "17"
            coffeeRatioMeasurement = .gram
            waterRatioMeasurement = .gram
        }
    }
    func saveDefaults() {
        UserDefaultsManager.shared.setBrewQuantity(brewQuantity)
        UserDefaultsManager.shared.setBrewMeasurement(brewMeasurement)
        UserDefaultsManager.shared.setCoffeeRatioQuantity(coffeeRatioQuantity)
        UserDefaultsManager.shared.setCoffeeRatioMeasurement(coffeeRatioMeasurement)
        UserDefaultsManager.shared.setWaterRatioQuantity(waterRatioQuantity)
        UserDefaultsManager.shared.setWaterRatioMeasurement(waterRatioMeasurement)
        UserDefaultsManager.shared.setCoffeeRequiredMeasurement(coffeeRequiredMeasurement)
        UserDefaultsManager.shared.setWaterRequiredMeasurement(waterRequiredMeasurement)
    }
}