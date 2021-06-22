//
//  BrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import Foundation

class BrewViewModel: ObservableObject {
    @Published var ratioExpanded = false
    @Published var coffeeRatioValue: String = ""
    @Published var coffeeRatioMeasurement: MeasurementType = .grams
    @Published var waterRatioValue: String = ""
    @Published var waterRatioMeasurement: MeasurementType = .grams
}
