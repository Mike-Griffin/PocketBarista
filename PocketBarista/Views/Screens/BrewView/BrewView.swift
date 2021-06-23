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
        VStack(spacing: 4) {
            AmountBrewLine(quantity: $viewModel.brewQuantity, measurement: $viewModel.brewMeasurement)
            Text("with a ratio of")
                .foregroundColor(.secondary)
            CoffeeRatioLine()
            Text("to")
                .foregroundColor(.secondary)
            WaterRatioLine()
        }
        .font(.largeTitle)
        .multilineTextAlignment(.center)
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
    var body: some View {
        Text("15")
            .underline()
        + Text(" ")
        + Text("grams")
            .underline()
        + Text(" coffee")
            .foregroundColor(.secondary)
    }
}

struct WaterRatioLine: View {
    var body: some View {
        Text("15")
            .underline()
        + Text(" ")
        + Text("grams")
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
