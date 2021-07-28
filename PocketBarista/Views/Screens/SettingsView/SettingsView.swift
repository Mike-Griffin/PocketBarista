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
            List {
                Text("Settings")
                Section(header: Text("Brew Amount")) {
                    SectionContent(quantityVal: $viewModel.brewQuantity,
                                   measurement: $viewModel.brewMeasurement)
                }
                Section(header: Text("Coffee Ratio Amount")) {
                    SectionContent(quantityVal: $viewModel.coffeeRatioQuantity,
                                   measurement: $viewModel.coffeeRatioMeasurement)
                }
                Section(header: Text("Water Ratio Amount")) {
                    SectionContent(quantityVal: $viewModel.waterRatioQuantity,
                                   measurement: $viewModel.waterRatioMeasurement)
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
            }
            .padding(.horizontal)
            HStack {
                Text("Measurement")
                Spacer()
                Text(measurement.rawValue)
            }
        }
    }
}
