//
//  BrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import Foundation

class BrewViewModel: ObservableObject {
    @Published var brewQuantity = "1" {
        didSet {
            changedValue()
        }
    }
    @Published var brewMeasurement: MeasurementType = .cup {
        didSet {
            changedValue()
        }
    }
    @Published var coffeeRatioQuantity: String = "2" {
        didSet {
            changedValue()
        }
    }
    @Published var coffeeRatioMeasurement: MeasurementType = .grams {
        didSet {
            changedValue()
        }
    }
    @Published var waterRatioQuantity: String = "17" {
        didSet {
            changedValue()
        }
    }
    @Published var waterRatioMeasurement: MeasurementType = .grams {
        didSet {
            changedValue()
        }
    }
    @Published var waterRequiredValue: Float = 0
    @Published var waterRequiredMeasurement: MeasurementType = .grams {
        didSet {
            changedValue()
        }
    }
    @Published var coffeeRequiredValue: Float = 0
    @Published var coffeeRequiredMeasurement: MeasurementType = .grams {
        didSet {
            changedValue()
        }
    }
    func changedValue() {
//        let coffeeRatio = coffeeRatioQuantityToGrams / waterRatioQuantityToGrams
        let requiredWater = brewQuantityToGrams
        let waterInDisplay = convertToSelectedMeasurement(requiredWater, waterRequiredMeasurement)
        let requiredCoffee = coffeeResultInGrams
        let coffeeInDisplay = convertToSelectedMeasurement(requiredCoffee, coffeeRequiredMeasurement)
//        print("Coffee ratio: ", coffeeRatio)
        print("Required water in grams: ", requiredWater)
        print("Required water in ounces: ", waterInDisplay)
        print("Required coffee in grams: ", requiredCoffee)
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
        case .ounces:
            return value * 28.3495
        case .grams:
            return value
        case .liters:
            return value * 1000
        case .cup:
            return value * 28.3495 * 8
        }
    }
    func convertToSelectedMeasurement(_ value: Float, _ measurement: MeasurementType) -> Float {
        switch measurement {
        case .ounces:
            return value / 28.3495
        case .grams:
            return value
        case .liters:
            return value / 1000
        case .cup:
            return value / (28.3495 * 8)
        }
    }
}
