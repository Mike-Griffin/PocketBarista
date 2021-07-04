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
        NavigationView {
            VStack(spacing: 32) {
                BrewPreferencesView(
                    brewQuantity: $viewModel.brewQuantity,
                    brewMeasurement: $viewModel.brewMeasurement,
                    coffeeRatioQuantity: $viewModel.coffeeRatioQuantity,
                    coffeeRatioMeasurement: $viewModel.coffeeRatioMeasurement,
                    waterRatioQuantity: $viewModel.waterRatioQuantity,
                    waterRatioMeasurement: $viewModel.waterRatioMeasurement
                )
                RequiredValuesView(
                    waterValue: viewModel.waterRequiredValue,
                    waterMeasurement: $viewModel.waterRequiredMeasurement,
                    coffeeValue: viewModel.coffeeRequiredValue,
                    coffeeMeasurement: $viewModel.coffeeRequiredMeasurement
                )
                NavigationLink(
                    destination: LogBrewView(brewQuantity: viewModel.brewQuantity,
                                             brewMeasurement: viewModel.brewMeasurement,
                                             coffeeRatioQuantity: viewModel.coffeeRatioQuantity,
                                             coffeeRatioMeasurement: viewModel.coffeeRatioMeasurement,
                                             waterRatioQuantity: viewModel.waterRatioQuantity,
                                             waterRatioMeasurement: viewModel.waterRatioMeasurement),
                    label: {
                        Text("Log Brew")
                    })
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        viewModel.saveDefaults()
                    }))
                    .simultaneousGesture(LongPressGesture().onEnded({ _ in
                        viewModel.saveDefaults()
                    }))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                dismissKeyboard()
            }
            .onAppear {
                viewModel.changedValue()
        }
        }
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

struct AmountBrewLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    @State var showingNumberSheet = false
    var body: some View {
        HStack(spacing: 0) {
            Text("I'm brewing ")
                .foregroundColor(.secondary)
            QuantityTextField(quantity: $quantity)
            Text(" ")
            Text(measurement.checkPlural(Float(quantity) ?? 0))
                .underline()
                .onTapGesture {
                    dismissKeyboard()
                    showingMeasurementSheet = true
                }
        }
        .sheet(isPresented: $showingMeasurementSheet, content: {
            MeasurementSelectionView(selection: $measurement)
        })
        .sheet(isPresented: $showingNumberSheet, content: {
            QuantitySelectionView(selection: $quantity)
        })
        .onTapGesture {
            dismissKeyboard()
        }

    }
}

struct RatioSelectionLine: View {
    var categoryText: String
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    @State var showingNumberSheet = false
    var body: some View {
        HStack(spacing: 0) {
            QuantityTextField(quantity: $quantity)
            Text(" ")
            Text(measurement.checkPlural(Float(quantity) ?? 0))
                .underline()
                .onTapGesture {
                    dismissKeyboard()
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
        Group {
            BrewView()
        }
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
                Text(" \(waterMeasurement.checkPlural(waterValue))")
                    .underline()
                    .onTapGesture {
                        dismissKeyboard()
                        showingWaterSheet = true
                    }
                Text(" water")
            }
            HStack {
                coffeeValue.textDisplay()
                Text(" \(coffeeMeasurement.checkPlural(coffeeValue))")
                    .underline()
                    .onTapGesture {
                        dismissKeyboard()
                        showingCoffeeSheet = true
                    }
                Text(" coffee")
            }
        }
        .font(.title2)
        .sheet(isPresented: $showingWaterSheet, content: {
            MeasurementSelectionView(selection: $waterMeasurement)
        })
        .sheet(isPresented: $showingCoffeeSheet, content: {
            MeasurementSelectionView(selection: $coffeeMeasurement)
        })
    }
}

struct QuantityTextField: View {
    @Binding var quantity: String
    @State var previousQuantity: String = ""
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $quantity) { change in
                print(change)
                if previousQuantity.isEmpty {
                    previousQuantity = quantity
                }
                if change {
                    quantity = ""
                } else {
                    if quantity.isEmpty {
                        quantity = previousQuantity
                        previousQuantity = ""
                    }
                }
            }
            .keyboardType(.numbersAndPunctuation)
            .frame(height: 34)
            .frame(minWidth: 24)
            .onTapGesture {
                previousQuantity = quantity
                quantity = ""
            }
            Rectangle()
                .frame(height: 2)
        }
        .fixedSize()
    }
}
