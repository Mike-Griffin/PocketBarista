//
//  FavoritesView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    @State private var showingCreateCoffee = false
    @State private var showingCreateRoaster = false
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Coffees")) {
                    ForEach(viewModel.coffees) { coffee in
                        HStack {
                            Text(coffee.name ?? "Uh oh no name")
                            Spacer()
                            Menu {
                                Button {
                                    viewModel.deleteCoffee(coffee)
                                } label: {
                                    Text("Delete Coffee")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
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
            .onAppear {
                viewModel.fetchCoffees()
                viewModel.fetchRoasters()
            }
            .sheet(isPresented: $showingCreateCoffee, content: {
                CreateCoffeeView()
            })
            .sheet(isPresented: $showingCreateRoaster, content: {
                CreateRoasterView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            showingCreateCoffee = true
                        } label: {
                            Text("Create Coffee")
                        }
                        Button {
                            showingCreateRoaster = true
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
