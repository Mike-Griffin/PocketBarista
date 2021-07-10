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

enum DataModel {
    static let main = "Main"
    static let coffee = "PBCoffee"
    static let roaster = "PBRoaster"
    static let tag = "PBTag"
}

enum DefaultsKeys: String {
    case brewQuantity
    case brewMeasurement
    case coffeeRatioQuantity
    case coffeeRatioMeasurement
    case waterRatioQuantity
    case waterRatioMeasurement
    case coffeeRequiredMeasurement
    case waterRequiredMeasurement
}

enum PlaceholderImage {
    static let coffeeMug = UIImage(named: "mug")!
}
