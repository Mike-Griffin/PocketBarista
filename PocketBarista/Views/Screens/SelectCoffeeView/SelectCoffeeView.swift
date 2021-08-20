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
            // SearchField(text: "Search Coffees", searchText: $viewModel.searchText)
            BackButton()
            SearchBarView(searchText: $viewModel.searchText, isSearching: $viewModel.isSearching)
            List {
                ForEach(viewModel.searchCoffees) { coffee in
                    HStack {
                        Text(coffee.displayText)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        Spacer()
                        Image(systemName: viewModel.checkSelected(selected: selectedCoffee, coffee: coffee)
                                ? "checkmark.square"
                                : "square")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 24)
                    .padding(.trailing, 8)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        selectedCoffee = coffee
                        playHaptic()
                        presentationMode.wrappedValue.dismiss()
                    }
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
