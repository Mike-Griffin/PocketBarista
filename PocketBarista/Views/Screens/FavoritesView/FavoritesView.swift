//
//  FavoritesView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Coffees")) {
                    ForEach(viewModel.coffees) { coffee in
                        HStack {
                            Button {
                                viewModel.selectedCoffee = coffee
                                viewModel.showingCreateCoffee = true
                            } label: {
                                Text(coffee.name ?? "Uh oh no name")
                            }
                            Spacer()
                            Menu {
                                Button {
                                    viewModel.deleteCoffee(coffee)
                                    viewModel.fetchCoffees()
                                } label: {
                                    Text("Delete Coffee")
                                }
                                Button {
                                    viewModel.selectedCoffee = coffee
                                    viewModel.showingCreateCoffee = true
                                } label: {
                                    Text("Edit Coffee")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
                Section(header: Text("Roasters")) {
                    ForEach(viewModel.roasters) { roaster in
                        Text(roaster.name ?? "Uh oh no name")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchCoffees()
                viewModel.fetchRoasters()
            }
            .sheet(isPresented: $viewModel.showingCreateCoffee,
                   onDismiss: {
                viewModel.fetchCoffees()
                viewModel.selectedCoffee = nil
            },
                   content: {
                CoffeeBeanView(viewModel: CoffeeBeanViewModel(coffee: viewModel.selectedCoffee))
            })
            .sheet(isPresented: $viewModel.showingCreateRoaster,
                   onDismiss: {
                viewModel.fetchRoasters()
            }, content: {
                CreateRoasterView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            viewModel.showingCreateCoffee = true
                        } label: {
                            Text("Create Coffee")
                        }
                        Button {
                            viewModel.showingCreateRoaster = true
                        } label: {
                            Text("Create Roaster")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
