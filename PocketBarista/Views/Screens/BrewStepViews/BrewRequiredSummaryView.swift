//
//  BrewRequiredSummaryView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/31/21.
//

import SwiftUI

struct BrewRequiredSummaryView: View {
    @ObservedObject var viewModel: BrewStepsViewModel
    var body: some View {
        VStack {
            Text("You'll need this amount:")
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
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.brandPrimary)
                    .cornerRadius(15)
                    .ignoresSafeArea(.keyboard)
                })
                .simultaneousGesture(TapGesture().onEnded({ _ in
                    viewModel.saveDefaults()
                }))
                .simultaneousGesture(LongPressGesture().onEnded({ _ in
                    viewModel.saveDefaults()
                }))

        }
    }
}

private struct RequiredValuesView: View {
    var waterValue: Float
    @Binding var waterMeasurement: MeasurementType
    var coffeeValue: Float
    @Binding var coffeeMeasurement: MeasurementType
    @State var showingWaterSheet = false
    @State var showingCoffeeSheet = false
    var body: some View {
        VStack {
            HStack(spacing: 1) {
                waterValue.textDisplay()
                Text(" \(waterMeasurement.checkPlural(waterValue))")
                    .underline()
                    .onTapGesture {
                        dismissKeyboard()
                        showingWaterSheet = true
                    }
                Text(" water")
            }
            HStack(spacing: 1) {
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
