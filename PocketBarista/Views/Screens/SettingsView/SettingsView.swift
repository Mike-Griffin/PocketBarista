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
                DefaultsSection(heading: "Brew Amount",
                                quantityVal: $viewModel.brewQuantity,
                                measurement: $viewModel.brewMeasurement)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct DefaultsSection: View {
    var heading: String
    @Binding var quantityVal: String
    @Binding var measurement: MeasurementType
    var body: some View {
        if #available(iOS 15.0, *) {
            Section(heading) {
                Section {
                    SectionContent(quantityVal: $quantityVal,
                                   measurement: $measurement)
                }
            }
        } else {
            Section {
                SectionContent(quantityVal: $quantityVal,
                               measurement: $measurement)
            }
        }

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
