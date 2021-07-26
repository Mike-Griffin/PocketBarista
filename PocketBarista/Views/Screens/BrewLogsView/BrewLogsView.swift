//
//  BrewLogsView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/25/21.
//

import SwiftUI

struct BrewLogsView: View {
    @StateObject var viewModel = BrewLogsViewModel()
    var body: some View {
        Text("Hello, Brew Logs!")
            .onAppear {
                viewModel.fetchBrewLogs()
                print(viewModel.brewLogs)
            }
    }
}

struct BrewLogsView_Previews: PreviewProvider {
    static var previews: some View {
        BrewLogsView()
    }
}
