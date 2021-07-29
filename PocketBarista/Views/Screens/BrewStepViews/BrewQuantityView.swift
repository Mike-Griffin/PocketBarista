//
//  CoffeeQuantityView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/28/21.
//

import SwiftUI

struct BrewQuantityView: View {
    @StateObject var viewModel = BrewStepsViewModel()
    var body: some View {
        AmountBrewLine(quantity: $viewModel.brewQuantity, measurement: $viewModel.brewMeasurement)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .padding()
        NavigationLink(destination: BrewStrengthView(viewModel: viewModel)) {
            Text("Confirm")
        }
    }
}

private struct AmountBrewLine: View {
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    @State var showingNumberSheet = false
    var body: some View {
        VStack(spacing: 0) {
            Text("How much coffee are you brewing?")
                .foregroundColor(.secondary)
            HStack(spacing: 0) {
                QuantityTextField(quantity: $quantity)
                Text(" ")
                Text(measurement.checkPlural(Float(quantity) ?? 0))
                    .underline()
                    .onTapGesture {
                        dismissKeyboard()
                        showingMeasurementSheet = true
                    }
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

struct CoffeeQuantityView_Previews: PreviewProvider {
    static var previews: some View {
        BrewQuantityView()
    }
}
