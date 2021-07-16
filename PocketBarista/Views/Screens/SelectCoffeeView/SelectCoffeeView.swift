//
//  SelectCoffeeView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/16/21.
//

import SwiftUI

struct SelectCoffeeView: View {
    @StateObject var viewModel = SelectCoffeeViewModel()
    @Binding var selectedCoffee: PBCoffee?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            SearchField(searchText: $viewModel.searchText)
            ForEach(viewModel.searchCoffees) { coffee in
                HStack {
                    Text(coffee.roaster != nil ? "\(coffee.roaster!.name!): \(coffee.name!)" : coffee.name!)
                    Spacer()
                    Image(systemName: viewModel.checkSelected(selected: selectedCoffee, coffee: coffee)
                          ? "checkmark.square"
                          : "square")
                }
                .onTapGesture {
                    selectedCoffee = coffee
                    presentationMode.wrappedValue.dismiss()
                }
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchCoffees()
        }

    }
}

struct SelectCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCoffeeView(selectedCoffee: .constant(nil))
    }
}
