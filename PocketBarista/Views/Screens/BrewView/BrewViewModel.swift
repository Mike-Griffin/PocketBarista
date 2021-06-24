//
//  BrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import Foundation

class BrewViewModel: ObservableObject {
    @Published var ratioExpanded = false
    @Published var brewQuantity = "1"
    @Published var brewMeasurement: MeasurementType = .cup
    @Published var coffeeRatioQuantity: String = "2"
    @Published var coffeeRatioMeasurement: MeasurementType = .grams
    @Published var waterRatioQuantity: String = "17"
    @Published var waterRatioMeasurement: MeasurementType = .ounces
    @Published var waterRequiredValue: Float = 223.69
    @Published var waterRequiredMeasurement: MeasurementType = .ounces
    @Published var coffeeRequiredValue: Float = 30.1
    @Published var coffeeRequiredMeasurement: MeasurementType = .grams
}
