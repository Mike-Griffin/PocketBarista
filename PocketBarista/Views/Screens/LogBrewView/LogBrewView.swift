//
//  LogBrew.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/23/21.
//

import SwiftUI

struct LogBrewView: View {
    var brewQuantity: String
    var brewMeasurement: MeasurementType
    var coffeeRatioQuantity: String
    var coffeeRatioMeasurement: MeasurementType
    var waterRatioQuantity: String
    var waterRatioMeasurement: MeasurementType
    @StateObject var viewModel = LogBrewViewModel()
    var body: some View {
        VStack {
            NavigationLink(destination: HomeView(), isActive: $viewModel.navigateHome) { EmptyView() }
            HeaderDetailsSection(brewQuantity: brewQuantity,
                                 brewMeasurement: brewMeasurement,
                                 coffeeRatioQuantity: coffeeRatioQuantity,
                                 coffeeRatioMeasurement: coffeeRatioMeasurement,
                                 waterRatioQuantity: waterRatioQuantity,
                                 waterRatioMeasurement: waterRatioMeasurement)
            Form {
                Section {
                    Text(viewModel.selectedCoffee == nil ? "Select Coffee" : viewModel.selectedCoffee!.displayText)
                        .onTapGesture(count: 1) {
                            viewModel.isShowingCoffeePicker = true
                        }
                }
                Section {
                    RatingSelectionView(rating: $viewModel.rating)
                    LargeTextEditor(text: $viewModel.notes, title: "Notes")
                }
                Section {
                    Text("Save")
                        .foregroundColor(.textColor)
                        .onTapGesture {
                            viewModel.saveBrewLog(
                                brewQuantity: brewQuantity,
                                waterQuantity: waterRatioQuantity,
                                coffeeQuantity: coffeeRatioQuantity
                            )
                        }
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            dismissKeyboard()
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            if alertItem.primaryButton != nil {
            return Alert(title: alertItem.title, message: alertItem.message,
                         primaryButton: .default(Text("Yes"), action: {
                viewModel.saveWithoutCoffee(
                    brewQuantity: brewQuantity,
                    waterQuantity: waterRatioQuantity,
                    coffeeQuantity: coffeeRatioQuantity)
            }), secondaryButton: .cancel()) } else {
                return Alert(title: alertItem.title, message: alertItem.message,
                             dismissButton: .default(Text("Ok"), action: {
                    viewModel.navigateHome = true
                }))
            }
        })
        .sheet(isPresented: $viewModel.isShowingCoffeePicker, content: {
            SelectCoffeeView(selectedCoffee: $viewModel.selectedCoffee)
        })
    }
}

struct LogBrew_Previews: PreviewProvider {
    static var previews: some View {
        LogBrewView(brewQuantity: "1",
                    brewMeasurement: .cup,
                    coffeeRatioQuantity: "1",
                    coffeeRatioMeasurement: .gram,
                    waterRatioQuantity: "17",
                    waterRatioMeasurement: .gram)
    }
}

struct HeaderDetailsSection: View {
    var brewQuantity: String
    var brewMeasurement: MeasurementType
    var coffeeRatioQuantity: String
    var coffeeRatioMeasurement: MeasurementType
    var waterRatioQuantity: String
    var waterRatioMeasurement: MeasurementType
    var body: some View {
        Section {
            Text("You're brewing \(brewQuantity) \(brewMeasurement.checkPlural(Float(brewQuantity) ?? 0))")
            Text("with a ratio of")
            Text("\(coffeeRatioQuantity) "
                 + "\(coffeeRatioMeasurement.checkPlural(Float(coffeeRatioQuantity) ?? 0))"
                 + " coffee to \(waterRatioQuantity)"
                 + " \(waterRatioMeasurement.checkPlural(Float(waterRatioQuantity) ?? 0)) water")
        }
    }
}
