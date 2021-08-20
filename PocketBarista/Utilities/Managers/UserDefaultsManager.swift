//
//  UserDefaultsManager.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/15/21.
//

import Foundation

struct UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private var defaults = UserDefaults.standard
    init() {
        defaults = UserDefaults.standard
    }
    // MARK: Onboard View
    func hasSeenOnboardView() -> Bool {
        return defaults.bool(forKey: DefaultsKeys.seenOnboard.rawValue)
    }
    
    func setSeenOnboardView() {
        defaults.set(true, forKey: DefaultsKeys.seenOnboard.rawValue)
    }
    
    // MARK: Brew Quantity
    func getBrewQuantity() -> String {
        return defaults.object(forKey: DefaultsKeys.brewQuantity.rawValue) as? String ?? "1"
    }
    func setBrewQuantity(_ quantity: String) {
        defaults.set(quantity, forKey: DefaultsKeys.brewQuantity.rawValue)
    }
    // MARK: Brew Measurement
    func getBrewMeasurement() -> MeasurementType {
        if let brewMeasurementDefault = defaults.object(forKey:
                                                            DefaultsKeys.brewMeasurement.rawValue) as? String {
            return MeasurementType(rawValue: brewMeasurementDefault) ?? .cup
        } else {
            return .cup
        }
    }
    func setBrewMeasurement(_ measurement: MeasurementType) {
        defaults.set(measurement.rawValue, forKey: DefaultsKeys.brewMeasurement.rawValue)
    }
    // MARK: Coffee Ratio Quantity
    func getCoffeeRatioQuantity() -> String? {
        return defaults.object(forKey: DefaultsKeys.coffeeRatioQuantity.rawValue) as? String
    }
    func setCoffeeRatioQuantity(_ quantity: String?) {
        if let quantity = quantity {
            defaults.set(quantity, forKey: DefaultsKeys.coffeeRatioQuantity.rawValue)
        } else {
            print("helllloooooo???????")
            defaults.removeObject(forKey: DefaultsKeys.coffeeRatioQuantity.rawValue)
            defaults.synchronize()
        }
    }
    // MARK: Coffee Ratio Measurement
    func getCoffeeRatioMeasurement() -> MeasurementType? {
        if let measurementDefault = defaults.object(forKey:
                                                            DefaultsKeys.coffeeRatioMeasurement.rawValue) as? String {
            return MeasurementType(rawValue: measurementDefault)
        } else {
            return nil
        }
    }
    func setCoffeeRatioMeasurement(_ measurement: MeasurementType?) {
        if let measurement = measurement {
        defaults.set(measurement.rawValue, forKey: DefaultsKeys.coffeeRatioMeasurement.rawValue)
        } else {
            defaults.set(nil, forKey: DefaultsKeys.coffeeRatioMeasurement.rawValue)
        }
    }
    // MARK: Water Ratio Quantity
    func getWaterRatioQuantity() -> String? {
        return defaults.object(forKey: DefaultsKeys.waterRatioQuantity.rawValue) as? String
    }
    func setWaterRatioQuantity(_ quantity: String?) {
        defaults.set(quantity, forKey: DefaultsKeys.waterRatioQuantity.rawValue)
    }
    // MARK: Water Ratio Measurement
    func getWaterRatioMeasurement() -> MeasurementType? {
        if let measurementDefault = defaults.object(forKey:
                                                            DefaultsKeys.waterRatioMeasurement.rawValue) as? String {
            return MeasurementType(rawValue: measurementDefault)
        } else {
            return nil
        }
    }
    func setWaterRatioMeasurement(_ measurement: MeasurementType?) {
        if let measurement = measurement {
        defaults.set(measurement.rawValue, forKey: DefaultsKeys.waterRatioMeasurement.rawValue)
        } else {
            defaults.removeObject(forKey: DefaultsKeys.waterRatioMeasurement.rawValue)
        }
    }
    // MARK: Coffee Required Measurement
    func getCoffeeRequiredMeasurement() -> MeasurementType {
        if let measurementDefault = defaults.object(forKey:
                                                        DefaultsKeys.coffeeRequiredMeasurement.rawValue) as? String {
            return MeasurementType(rawValue: measurementDefault) ?? .gram
        } else {
            return .gram
        }
    }
    func setCoffeeRequiredMeasurement(_ measurement: MeasurementType) {
        defaults.set(measurement.rawValue, forKey: DefaultsKeys.coffeeRequiredMeasurement.rawValue)
    }
    // MARK: Water Required Measurement
    func getWaterRequiredMeasurement() -> MeasurementType {
        if let measurementDefault = defaults.object(forKey:
                                                        DefaultsKeys.waterRequiredMeasurement.rawValue) as? String {
            return MeasurementType(rawValue: measurementDefault) ?? .gram
        } else {
            return .gram
        }
    }
    func setWaterRequiredMeasurement(_ measurement: MeasurementType) {
        defaults.set(measurement.rawValue, forKey: DefaultsKeys.waterRequiredMeasurement.rawValue)
    }
    // MARK: Strengh
    func getStrength() -> Strength? {
        if let strengthDefault = defaults.object(forKey: DefaultsKeys.strength.rawValue) as? String {
            return Strength(rawValue: strengthDefault) ?? nil
        } else {
            return nil
        }
    }
    func setStrength(_ strength: Strength?) {
        if let strength = strength {
            print("setting strength \(strength.rawValue)")
            defaults.set(strength.rawValue, forKey: DefaultsKeys.strength.rawValue)
        } else {
            defaults.removeObject(forKey: DefaultsKeys.strength.rawValue)
        }
    }
}
