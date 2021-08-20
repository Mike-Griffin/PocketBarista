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
            Section {
                Text("You're brewing \(brewQuantity) \(brewMeasurement.checkPlural(Float(brewQuantity) ?? 0))")
                Text("with a ratio of")
                Text("\(coffeeRatioQuantity) "
                     + "\(coffeeRatioMeasurement.checkPlural(Float(coffeeRatioQuantity) ?? 0))"
                     + " coffee to \(waterRatioQuantity)"
                     + " \(waterRatioMeasurement.checkPlural(Float(waterRatioQuantity) ?? 0)) water")
            }
            Form {
                Section {
                    Text(viewModel.selectedCoffee == nil ? "Select Coffee" : viewModel.selectedCoffee!.name!)
                        .onTapGesture(count: 1) {
                            viewModel.isShowingCoffeePicker = true
                        }
                }
                Section {
                    RatingSelectionView(rating: $viewModel.rating)
                    LargeTextEditor(text: $viewModel.notes, title: "Notes")
                }

                Section {
                    TextField("Grind Setting", text: $viewModel.grindSetting)
                }
                Button(action: {
                    viewModel.saveBrewLog(
                        brewQuantity: brewQuantity,
                        waterQuantity: waterRatioQuantity,
                        coffeeQuantity: coffeeRatioQuantity)
                }, label: {
                    Text("Save")
                        .foregroundColor(.textColor)
                })
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            dismissKeyboard()
        }
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
