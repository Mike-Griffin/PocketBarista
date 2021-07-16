//
//  BrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import Foundation

class BrewViewModel: ObservableObject {
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
    private var defaults: UserDefaults
    init() {
        defaults = UserDefaults.standard
        brewQuantity = defaults.object(forKey: DefaultsKeys.brewQuantity.rawValue) as? String ?? "1"
        if let brewMeasurementDefault = defaults.object(forKey:
                                                            DefaultsKeys.brewMeasurement.rawValue) as? String {
            brewMeasurement = MeasurementType(rawValue: brewMeasurementDefault) ?? .cup
        } else {
            brewMeasurement = .cup
        }
        coffeeRatioQuantity = defaults.object(forKey:
                                                DefaultsKeys.coffeeRatioQuantity.rawValue) as? String ?? "1"
        if let coffeeRatioMeasurementDefault = defaults.object(forKey:
                                                                DefaultsKeys.coffeeRatioMeasurement.rawValue)
            as? String {
            coffeeRatioMeasurement = MeasurementType(rawValue: coffeeRatioMeasurementDefault) ?? .gram
        } else {
            coffeeRatioMeasurement = .gram
        }
        waterRatioQuantity = defaults.object(forKey:
                                                DefaultsKeys.waterRatioQuantity.rawValue) as? String ?? "17"
        if let waterRatioMeasurementDefault = defaults.object(forKey:
                                                                DefaultsKeys.waterRatioMeasurement.rawValue)
            as? String {
            waterRatioMeasurement = MeasurementType(rawValue: waterRatioMeasurementDefault) ?? .gram
        } else {
            waterRatioMeasurement = .gram
        }
        if let coffeeRequiredDefault = defaults.object(forKey:
                                                        DefaultsKeys.coffeeRequiredMeasurement.rawValue) as? String {
            coffeeRequiredMeasurement = MeasurementType(rawValue: coffeeRequiredDefault) ?? .gram
        } else {
            coffeeRequiredMeasurement = .gram
        }
        if let waterRequiredDefault = defaults.object(forKey:
                                                        DefaultsKeys.waterRequiredMeasurement.rawValue) as? String {
            waterRequiredMeasurement = MeasurementType(rawValue: waterRequiredDefault) ?? .gram
        } else {
            waterRequiredMeasurement = .gram
        }
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
    func saveDefaults() {
        defaults.set(brewQuantity, forKey: DefaultsKeys.brewQuantity.rawValue)
        defaults.set(brewMeasurement.rawValue, forKey: DefaultsKeys.brewMeasurement.rawValue)
        defaults.set(coffeeRatioQuantity, forKey: DefaultsKeys.coffeeRatioQuantity.rawValue)
        defaults.set(coffeeRatioMeasurement.rawValue, forKey: DefaultsKeys.coffeeRatioMeasurement.rawValue)
        defaults.set(waterRatioQuantity, forKey: DefaultsKeys.waterRatioQuantity.rawValue)
        defaults.set(waterRatioMeasurement.rawValue, forKey: DefaultsKeys.waterRatioMeasurement.rawValue)
        defaults.set(coffeeRequiredMeasurement.rawValue, forKey: DefaultsKeys.coffeeRequiredMeasurement.rawValue)
        defaults.set(waterRequiredMeasurement.rawValue, forKey: DefaultsKeys.waterRequiredMeasurement.rawValue)
    }
}
