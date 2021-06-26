//
//  Constants.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import Foundation

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
