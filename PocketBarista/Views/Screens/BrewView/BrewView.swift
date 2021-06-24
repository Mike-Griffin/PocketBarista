//
//  BrewParagraphView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/22/21.
//

import SwiftUI

struct BrewView: View {
    @ObservedObject var viewModel = BrewViewModel()
    var body: some View {
        VStack(spacing: 32) {
            BrewPreferencesView(
                brewQuantity: $viewModel.brewQuantity,
                brewMeasurement: $viewModel.brewMeasurement,
                coffeeRatioQuantity: $viewModel.coffeeRatioQuantity,
                coffeeRatioMeasurement: $viewModel.coffeeRatioMeasurement,
                waterRatioQuantity: $viewModel.waterRatioQuantity,
                waterRatioMeasurement: $viewModel.waterRatioMeasurement)
            RequiredValuesView(
                waterValue: viewModel.waterRequiredValue,
                waterMeasurement: $viewModel.waterRequiredMeasurement,
                coffeeValue: viewModel.coffeeRequiredValue,
                coffeeMeasurement: $viewModel.coffeeRequiredMeasurement)
        }
    }
}

struct AmountBrewLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    var body: some View {
        Text("I'm brewing ")
            .foregroundColor(.secondary)
        + Text(quantity)
            .underline()
        + Text(" ")
            + Text(measurement.rawValue)
            .underline()
    }
}

struct CoffeeRatioLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    var body: some View {
        Text(quantity)
            .underline()
        + Text(" ")
            + Text(measurement.rawValue)
            .underline()
        + Text(" coffee")
            .foregroundColor(.secondary)
    }
}

struct WaterRatioLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    var body: some View {
        Text(quantity)
            .underline()
        + Text(" ")
            + Text(measurement.rawValue)
            .underline()
        + Text(" water")
            .foregroundColor(.secondary)
    }
}

struct BrewParagraphView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView()
    }
}

struct BrewPreferencesView: View {
    @Binding var brewQuantity: String
    @Binding var brewMeasurement: MeasurementType
    @Binding var coffeeRatioQuantity: String
    @Binding var coffeeRatioMeasurement: MeasurementType
    @Binding var waterRatioQuantity: String
    @Binding var waterRatioMeasurement: MeasurementType
    var body: some View {
        VStack(spacing: 4) {
            AmountBrewLine(quantity: $brewQuantity, measurement: $brewMeasurement)
            Text("with a ratio of")
                .foregroundColor(.secondary)
            CoffeeRatioLine(quantity: $coffeeRatioQuantity, measurement: $coffeeRatioMeasurement)
            Text("to")
                .foregroundColor(.secondary)
            WaterRatioLine(quantity: $waterRatioQuantity, measurement: $waterRatioMeasurement)
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
    }
}

struct RequiredValuesView: View {
    var waterValue: Float
    @Binding var waterMeasurement: MeasurementType
    var coffeeValue: Float
    @Binding var coffeeMeasurement: MeasurementType
    var body: some View {
        VStack {
            Text("This will be:")
            waterValue.textDisplay()
                + Text(" \(waterMeasurement.rawValue)")
                .underline()
                + Text(" water")
            coffeeValue.textDisplay()
                + Text(" \(coffeeMeasurement.rawValue)")
                .underline()
                + Text(" coffee")
        }
        .font(.title)
    }
}
