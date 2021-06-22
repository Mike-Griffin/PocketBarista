//
//  BrewView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import SwiftUI

struct BrewView: View {
    @ObservedObject var viewModel = BrewViewModel()
    var body: some View {
        NavigationView {
            Form {
                RatioView(expand: $viewModel.ratioExpanded,
                          coffeeAmount: $viewModel.coffeeRatioValue,
                          coffeeMeasurement: $viewModel.coffeeRatioMeasurement,
                          waterAmount: $viewModel.waterRatioValue,
                          waterMeasurement: $viewModel.waterRatioMeasurement)
            }
        }
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView()
    }
}

struct RatioView: View {
    @Binding var expand: Bool
    @Binding var coffeeAmount: String
    @Binding var coffeeMeasurement: MeasurementType
    @Binding var waterAmount: String
    @Binding var waterMeasurement: MeasurementType
    var body: some View {
        VStack {
            HStack {
                Text("Ratio")
                Spacer()
                Text("22 G Coffee to 30 G Water")
            }
            .onTapGesture {
                expand = true
            }
            if expand {
                RatioSelectionView(sectionName: "Coffee",
                                   amount: $coffeeAmount,
                                   measurement: $coffeeMeasurement)
                RatioSelectionView(sectionName: "Water",
                amount: $waterAmount,
                measurement: $waterMeasurement)
            }
        }
    }
}

struct RatioSelectionView: View {
    var sectionName: String
    @Binding var amount: String
    @Binding var measurement: MeasurementType
    var body: some View {
        HStack(spacing: 48) {
            Text(sectionName)
            VStack {
                TextField("Amount", text: $amount)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 8)
                Picker("Measure", selection: $measurement) {
                    ForEach(MeasurementType.allCases, id: \.self) { value in
                        Text(value.rawValue)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}
