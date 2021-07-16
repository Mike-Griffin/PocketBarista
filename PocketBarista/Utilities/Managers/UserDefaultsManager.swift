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
    func getBrewQuantity() -> String {
        return defaults.object(forKey: DefaultsKeys.brewQuantity.rawValue) as? String ?? "1"
    }
    func setBrewQuantity(_ quantity: String) {
        defaults.set(quantity, forKey: DefaultsKeys.brewQuantity.rawValue)
    }
    func getBrewMeasurement() -> MeasurementType {
        if let brewMeasurementDefault = defaults.object(forKey:
                                                            DefaultsKeys.brewMeasurement.rawValue) as? String {
            return MeasurementType(rawValue: brewMeasurementDefault) ?? .cup
        } else {
            return .cup
        }
    }
    func setBrewMeasurement(_ measurement: MeasurementType) {
        defaults.set(measurement, forKey: DefaultsKeys.brewMeasurement.rawValue)
    }
}
