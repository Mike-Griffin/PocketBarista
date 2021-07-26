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
        List {
            ForEach(viewModel.brewLogs) { log in
                VStack {
                    Text(log.coffee != nil ? log.coffee!.displayText : "No Coffee Selected")
                    Text(log.date?.toDateTime() ?? "no date")
                }
            }
        }
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
