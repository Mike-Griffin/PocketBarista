//
//  AppTabView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/21/21.
//

import SwiftUI

struct AppTabView: View {
    @StateObject var viewModel = AppTabViewModel()
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .navigationViewStyle(.stack)
                .tabItem { Label("Home", systemImage: "house") }
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "star") }
            BrewLogsView()
                .tabItem { Label("Logs", systemImage: "text.book.closed")}
            NavigationView {
                SettingsView()
            }
            .navigationViewStyle(.stack)
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .onAppear {
            viewModel.startupChecks()
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView, content: {
            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
        })
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
