//
//  CreateCoffeeView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

struct CreateCoffeeView: View {
    @StateObject var viewModel = CreateCoffeeViewModel()
    var body: some View {
        VStack {
            Text("Create Coffee Bean")
                .font(.largeTitle)
                .padding(.top)
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                    if !viewModel.availableRoasters.isEmpty {
                        Picker("Roaster", selection: $viewModel.roasterIndex) {
                            ForEach(0 ..< viewModel.availableRoasters.count) { index in
                                Text(viewModel.availableRoasters[index].name!)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                Button(action: {
                    viewModel.addCoffee()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

struct CreateCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCoffeeView()
    }
}
