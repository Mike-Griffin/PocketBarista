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
                    SectionContent(quantityVal: $viewModel.brewQuantity,
                                   measurement: $viewModel.brewMeasurement)
                }
                Section(header: Text("Coffee Strength")) {
                    VStack {
                        if !viewModel.customRatioShowing {
//                            HStack {
//                                Text("Strength Value")
//                                Spacer()
//                                Text(viewModel.strength.rawValue.capitalized)
//                            }
                            Picker("Strength Value", selection: $viewModel.strength) {
                                ForEach(Strength.allCases, id: \.self) { strength in
                                    Text(strength.rawValue.capitalized)
                                }
                            }
                        }
                        HStack {
                            Toggle("Custom Ratio", isOn: $viewModel.customRatioShowing)
                        }
                        if viewModel.customRatioShowing {
                            HStack {
                                Text("Coffee Quantity")
                                Spacer()
                                TextField("Quantity", text: $viewModel.coffeeRatioQuantity)
                                    .multilineTextAlignment(.trailing)
                            }
                            Picker("Coffee Measurement", selection: $viewModel.coffeeRatioMeasurement) {
                                ForEach(MeasurementType.allCases, id: \.self) { type in
                                    Text(type.checkPlural(Float(viewModel.coffeeRatioQuantity) ?? 0))
                                }
                            }
                            HStack {
                                Text("Water Quantity")
                                Spacer()
                                TextField("Quantity", text: $viewModel.waterRatioQuantity)
                                    .multilineTextAlignment(.trailing)
                            }
                            Picker("Coffee Ratio Quantity", selection: $viewModel.waterRatioMeasurement) {
                                ForEach(MeasurementType.allCases, id: \.self) { type in
                                    Text(type.checkPlural(Float(viewModel.waterRatioQuantity) ?? 0))
                                }
                            }
                        }
                    }
                }
            }
        }
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

struct SectionContent: View {
    @Binding var quantityVal: String
    @Binding var measurement: MeasurementType
    var body: some View {
        VStack {
            HStack {
                Text("Quantity")
                Spacer()
                TextField("Value", text: $quantityVal)
                    .multilineTextAlignment(.trailing)
            }
            // Split this out to be a picker
            HStack {
                Text("Measurement")
                Spacer()
                Text(measurement.rawValue)
            }
        }
    }
}
