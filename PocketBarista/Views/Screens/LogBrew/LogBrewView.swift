//
//  LogBrew.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/23/21.
//

import SwiftUI

struct LogBrewView: View {
    var brewQuantity: String
    var brewMeasurement: MeasurementType
    var coffeeRatioQuantity: String
    var coffeeRatioMeasurement: MeasurementType
    var waterRatioQuantity: String
    var waterRatioMeasurement: MeasurementType
    @ObservedObject var viewModel = LogBrewViewModel()
    var body: some View {
        VStack {
            Section {
                Text("You're brewing \(brewQuantity) \(brewMeasurement.checkPlural(Float(brewQuantity) ?? 0))")
                Text("with a ratio of")
                Text("\(coffeeRatioQuantity) "
                    + "\(coffeeRatioMeasurement.checkPlural(Float(coffeeRatioQuantity) ?? 0))"
                    + " coffee to \(waterRatioQuantity)"
                    + " \(waterRatioMeasurement.checkPlural(Float(waterRatioQuantity) ?? 0)) water")
            }
            Form {
                TextField("Grind Setting", text: $viewModel.grindSetting)
                RatingView(rating: $viewModel.rating)
            }

        }
    }
}

struct LogBrew_Previews: PreviewProvider {
    static var previews: some View {
        LogBrewView(brewQuantity: "1",
                    brewMeasurement: .cup,
                    coffeeRatioQuantity: "1",
                    coffeeRatioMeasurement: .gram,
                    waterRatioQuantity: "17",
                    waterRatioMeasurement: .gram)
    }
}
