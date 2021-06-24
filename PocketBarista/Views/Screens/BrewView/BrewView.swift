//
//  BrewParagraphView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/22/21.
//

import SwiftUI

struct BrewView: View {
    @ObservedObject var viewModel = BrewViewModel()
    @State var showingSheet = false
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
            Button(action: {
                showingSheet = true
            }, label: {
                Text("Log Brew")
            })
        }
        .sheet(isPresented: $showingSheet, content: {
            LogBrewView()
        })
        .onAppear {
            viewModel.changedValue()
        }
    }
}

struct AmountBrewLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    @State var showingNumberSheet = false
    var body: some View {
        HStack(spacing: 0) {
            Text("I'm brewing ")
                .foregroundColor(.secondary)
            Text(quantity)
                .underline()
                .onTapGesture {
                    showingNumberSheet = true
                }
            Text(" ")
            Text(measurement.rawValue)
                .underline()
                .onTapGesture {
                    showingMeasurementSheet = true
                }
        }
        .sheet(isPresented: $showingMeasurementSheet, content: {
            MeasurementSelectionView(selection: $measurement)
        })
        .sheet(isPresented: $showingNumberSheet, content: {
            QuantitySelectionView(selection: $quantity)
        })
    }
}

struct CoffeeRatioLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    @State var showingNumberSheet = false
    var body: some View {
        HStack(spacing: 0) {
            Text(quantity)
                .underline()
                .onTapGesture {
                    showingNumberSheet = true
                }
            Text(" ")
            Text(measurement.rawValue)
                .underline()
                .onTapGesture {
                    showingMeasurementSheet = true
                }
            Text(" coffee")
                .foregroundColor(.secondary)
        }
        .sheet(isPresented: $showingMeasurementSheet, content: {
            MeasurementSelectionView(selection: $measurement)
        })
        .sheet(isPresented: $showingNumberSheet, content: {
            QuantitySelectionView(selection: $quantity)
        })
    }
}

struct RatioSelectionLine: View {
    var categoryText: String
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    @State var showingNumberSheet = false
    var body: some View {
        HStack(spacing: 1) {
            Text(quantity)
                .underline()
                .onTapGesture {
                    showingNumberSheet = true
                }
            Text(" ")
            Text(measurement.rawValue)
                .underline()
                .onTapGesture {
                    showingMeasurementSheet = true
                }
            Text(" \(categoryText)")
                .foregroundColor(.secondary)
        }
        .sheet(isPresented: $showingMeasurementSheet, content: {
            MeasurementSelectionView(selection: $measurement)
        })
        .sheet(isPresented: $showingNumberSheet, content: {
            QuantitySelectionView(selection: $quantity)
        })
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
            RatioSelectionLine(categoryText: "coffee",
                               quantity: $coffeeRatioQuantity,
                               measurement: $coffeeRatioMeasurement)
            Text("to")
                .foregroundColor(.secondary)
            RatioSelectionLine(categoryText: "water",
                               quantity: $waterRatioQuantity,
                               measurement: $waterRatioMeasurement)
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
    @State var showingWaterSheet = false
    @State var showingCoffeeSheet = false
    var body: some View {
        VStack {
            Text("This will be:")
            HStack {
                waterValue.textDisplay()
                Text(" \(waterMeasurement.rawValue)")
                    .underline()
                    .onTapGesture {
                        showingWaterSheet = true
                    }
                Text(" water")
            }
            HStack {
                coffeeValue.textDisplay()
                Text(" \(coffeeMeasurement.rawValue)")
                    .underline()
                    .onTapGesture {
                        showingCoffeeSheet = true
                    }
                Text(" coffee")
            }
        }
        .font(.title)
        .sheet(isPresented: $showingWaterSheet, content: {
            MeasurementSelectionView(selection: $waterMeasurement)
        })
        .sheet(isPresented: $showingCoffeeSheet, content: {
            MeasurementSelectionView(selection: $coffeeMeasurement)
        })
    }
}
