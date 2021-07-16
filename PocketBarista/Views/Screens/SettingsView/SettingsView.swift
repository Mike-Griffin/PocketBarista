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
        VStack {
            Text("Settings")
            List {
                if #available(iOS 15.0, *) {
                    Section("Brew Amount") {
                        Section {
                            SectionContent(quantityVal: $viewModel.brewQuantity, measurement: $viewModel.brewMeasurement)
                        }
                    }
                } else {
                    Section {
                        SectionContent(quantityVal: $viewModel.brewQuantity, measurement: $viewModel.brewMeasurement)
                    }
                }
            }
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
