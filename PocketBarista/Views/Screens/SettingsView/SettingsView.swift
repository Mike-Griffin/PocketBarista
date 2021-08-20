//
//  SettingsView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/13/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    var body: some View {
        NavigationView {
            List {
                Text("Settings")
                Section(header: Text("Brew Amount")) {
                    SectionContent(quantityString: "Quantity",
                                    measurementString: "Measurement",
                                    quantityVal: $viewModel.brewQuantity,
                                   measurement: $viewModel.brewMeasurement)
                }
                Section(header: Text("Coffee Strength")) {
                    VStack {
                        if !viewModel.customRatioShowing {
                            StrengthPicker(strength: $viewModel.strength)
//                            Picker("Strength Value", selection: $viewModel.strength) {
//                                ForEach(Strength.allCases, id: \.self) { strength in
//                                    Text(strength.rawValue.capitalized)
//                                }
//                            }
//                            .padding(8)
                        }
                        HStack {
                            Toggle("Custom Ratio", isOn: $viewModel.customRatioShowing)
                        }
                        .padding(8)
                        if viewModel.customRatioShowing {
                            SectionContent(quantityString: "Coffee Quantity",
                                           measurementString: "Coffee Measurement",
                                           quantityVal: $viewModel.coffeeRatioQuantity,
                                           measurement: $viewModel.coffeeRatioMeasurement)
                            SectionContent(quantityString: "Water Quantity",
                                           measurementString: "Water Measurement",
                                           quantityVal: $viewModel.waterRatioQuantity,
                                           measurement: $viewModel.waterRatioMeasurement)
                        }
                    }
                }
            }

        }
        .simultaneousGesture(TapGesture().onEnded({
            dismissKeyboard()
        }))
        .listStyle(GroupedListStyle())
        .onAppear {
            viewModel.getDefaults()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private struct SectionContent: View {
    var quantityString: String
    var measurementString: String
    @Binding var quantityVal: String
    @Binding var measurement: MeasurementType
    @State var showingMeasurementSheet = false
    var body: some View {
        VStack {
            HStack {
                Text(quantityString)
                Spacer()
                TextField("Value", text: $quantityVal)
                    .multilineTextAlignment(.trailing)
            }
            .padding(8)
            HStack {
                Text(measurementString)
                Spacer()
                HStack {
                    Text(measurement.checkPlural(Float(quantityVal) ?? 0))
                    Image(systemName: "chevron.right")
                }
            }
            .onTapGesture {
                dismissKeyboard()
                showingMeasurementSheet = true
            }
            .padding(8)
            // Split this out to be a picker
        }
        .sheet(isPresented: $showingMeasurementSheet, content: {
            MeasurementSelectionView(selection: $measurement)
        })
    }
}

private struct StrengthPicker: View {
    @Binding var strength: Strength
    @State var showingStrengthSheet = false
    var body: some View {
        HStack {
            Text("Strength Value")
            Spacer()
            HStack {
                Text(strength.rawValue)
                Image(systemName: "chevron.right")
            }
        }
        .onTapGesture {
            dismissKeyboard()
            showingStrengthSheet = true
        }
        .sheet(isPresented: $showingStrengthSheet, content: {
            StrengthSelectionView(selection: $strength)
        })
        .padding(8)
    }
}
