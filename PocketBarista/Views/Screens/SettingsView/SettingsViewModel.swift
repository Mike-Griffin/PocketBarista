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
            UserDefaultsManager.shared.setBrewQuantity(brewQuantity)
        }
    }
    @Published var brewMeasurement: MeasurementType {
        didSet {
            UserDefaultsManager.shared.setBrewMeasurement(brewMeasurement)
        }
    }
    init() {
        brewQuantity = UserDefaultsManager.shared.getBrewQuantity()
        brewMeasurement = UserDefaultsManager.shared.getBrewMeasurement()
    }
}
