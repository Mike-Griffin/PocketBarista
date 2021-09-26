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
                CoffeeSection(viewModel: viewModel)
                RoasterSection(viewModel: viewModel)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchCoffees()
                viewModel.fetchRoasters()
            }
            .sheet(isPresented: $viewModel.showingCreateCoffee,
                   onDismiss: {
                    viewModel.fetchCoffees()
                    viewModel.fetchRoasters()
                    viewModel.selectedCoffee = nil
                   },
                   content: {
                    CoffeeBeanView(viewModel: CoffeeBeanViewModel(coffee: viewModel.selectedCoffee))
                   })
            .sheet(isPresented: $viewModel.showingCreateRoaster,
                   onDismiss: {
                    viewModel.fetchRoasters()
                   }, content: {
                    RoasterView(viewModel: RoasterViewModel(roaster: viewModel.selectedRoaster))
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
                            .font(.title2)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

private struct CoffeeSection: View {
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        Section(header: Text("Coffees").font(.title3)) {
            ForEach(viewModel.coffees) { coffee in
                HStack {
                    Button {
                        viewModel.selectedCoffee = coffee
                        viewModel.showingCreateCoffee = true
                    } label: {
                        Text(coffee.name ?? "Uh oh no name")
                            .fontWeight(.semibold)
                            .foregroundColor(.textColor)
                            .padding()
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
    }
}

private struct RoasterSection: View {
    @ObservedObject var viewModel: FavoritesViewModel
    var body: some View {
        Section(header: Text("Roasters").font(.title3)) {
            ForEach(viewModel.roasters) { roaster in
                HStack {
                    Button {
                        viewModel.selectedRoaster = roaster
                        viewModel.showingCreateRoaster = true
                    } label: {
                        Text(roaster.name ?? "Uh oh no name")
                            .fontWeight(.semibold)
                            .foregroundColor(.textColor)
                            .padding()
                    }
                    Spacer()
                    Menu {
                        Button {
                            viewModel.deleteRoaster(roaster)
                            viewModel.fetchRoasters()
                        } label: {
                            Text("Delete Roaster")
                        }
                        Button {
                            viewModel.selectedRoaster = roaster
                            viewModel.showingCreateRoaster = true
                        } label: {
                            Text("Edit Roaster")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .frame(width: 30, height: 30)
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
