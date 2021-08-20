//
//  Constants.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import UIKit

enum MeasurementType: String, Equatable, CaseIterable {
    case ounce
    case gram
    case liter
    case cup
    func checkPlural(_ val: Float) -> String {
        if val == 1.0 {
            return self.rawValue
        } else {
            return self.rawValue + "s"
        }
    }
}

enum Strength: String, Equatable, CaseIterable {
    case strong
    case regular
    case weak
}

enum DataModel {
    static let main = "Main"
    static let coffee = "PBCoffee"
    static let roaster = "PBRoaster"
    static let tag = "PBTag"
    static let brewLog = "PBBrewLog"
}

enum DefaultsKeys: String {
    case seenOnboard
    case brewQuantity
    case brewMeasurement
    case coffeeRatioQuantity
    case coffeeRatioMeasurement
    case waterRatioQuantity
    case waterRatioMeasurement
    case coffeeRequiredMeasurement
    case waterRequiredMeasurement
    case strength
}

enum PlaceholderImage {
    static let coffeeMug = UIImage(named: "mug")!
}
