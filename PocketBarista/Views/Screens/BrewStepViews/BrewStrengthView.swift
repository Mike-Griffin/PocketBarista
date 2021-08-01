//
//  BrewStrengthView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/28/21.
//

import SwiftUI

struct BrewStrengthView: View {
    @ObservedObject var viewModel: BrewStepsViewModel
    var body: some View {
        VStack {
            Spacer()
            if viewModel.customRatio {
                RatioSelectionView(viewModel: viewModel)
            } else {
                StrengthPromptView(strength: $viewModel.strength, showingStrengthSheet: $viewModel.showingStrengthSheet)
            }
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                NavigationLink(destination: BrewRequiredSummaryView(viewModel: viewModel)) {
                    VStack {
                        Image(systemName: "chevron.forward")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.brandPrimary)
                            .clipShape(Circle())
                        Text("Continue")
                            .font(.subheadline)
                    }
                }
                Spacer()
                Button {
                    viewModel.customRatio.toggle()
                } label: {
                    VStack {
                        Image(systemName: "pencil.circle")
                        Text("Custom\nRatio")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .offset(y: -24)
            .padding()
        }
    }
}

private struct RatioSelectionView: View {
    @ObservedObject var viewModel: BrewStepsViewModel
    var body: some View {
        VStack {
            Text("What ratio for your brew?")
            RatioSelectionLine(categoryText: "coffee",
                               quantity: $viewModel.coffeeRatioQuantity,
                               measurement: $viewModel.coffeeRatioMeasurement,
                               showingMeasurementSheet: $viewModel.showingMeasurementSheet)
            Text("to")
                .foregroundColor(.secondary)
            RatioSelectionLine(categoryText: "water",
                               quantity: $viewModel.waterRatioQuantity,
                               measurement: $viewModel.waterRatioMeasurement,
                               showingMeasurementSheet: $viewModel.showingMeasurementSheet)
        }
        .font(.title2)

    }
}

private struct RatioSelectionLine: View {
    var categoryText: String
    @Binding var quantity: String
    @Binding var measurement: MeasurementType
    @Binding var showingMeasurementSheet: Bool
//    @State var showingMeasurementSheet = false
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
    }
}

private struct StrengthPromptView: View {
    @Binding var strength: Strength
    @Binding var showingStrengthSheet: Bool
    var body: some View {
        VStack {
            Text("What's your strength preference?")
            Text(strength.rawValue.capitalized)
                .underline()
                .onTapGesture {
                    showingStrengthSheet = true
                }
        }
        .font(.title2)
        .sheet(isPresented: $showingStrengthSheet, content: {
            StrengthSelectionView(selection: $strength)
        })
    }
}

//struct BrewStrengthView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrewStrengthView()
//    }
//}
