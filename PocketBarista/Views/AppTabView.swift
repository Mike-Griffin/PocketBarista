//
//  AppTabView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            BrewView()
                .tabItem { Label("Home", systemImage: "house") }
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "star")}
            NavigationView {
                CreateCoffeeView()
            }
                .tabItem {
                    Label("Coffee", systemImage: "bed.double")
                }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
