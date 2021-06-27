//
//  FavoritesView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import SwiftUI

struct FavoritesView: View {
    @State private var showingCreateCoffee = false
    @State private var showingCreateRoaster = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Favorites")
                DisclosureGroup("Testing disclosure group") {
                    Text("More stuff inside here")
                }
            }

            .sheet(isPresented: $showingCreateCoffee, content: {
                CreateCoffeeView()
            })
            .sheet(isPresented: $showingCreateRoaster, content: {
                Text("Create Roaster View will go here soon")
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
