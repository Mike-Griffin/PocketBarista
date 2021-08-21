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
        NavigationView {
        VStack {
            if viewModel.brewLogs.isEmpty {
                VStack {
                    Text("No Brew Logs Yet")
                        .font(.largeTitle)
                    Spacer()
                        .frame(height: 24)
                    NavigationLink(destination: BrewQuantityView()) {
                        Text("Start making some coffee!")
                        .font(.callout)
                    }
                }
            } else {
                List {
                    ForEach(viewModel.brewLogs) { log in
                        NavigationLink(destination: BrewLogDetailView(brewLog: log)) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(log.coffee != nil ? log.coffee!.displayText : "No Coffee Selected")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
//                                HStack {
                                    Text(log.date?.toDateTime() != nil
                                            ? "Brewed \(log.date!.relativeFromToday())"
                                            : "no date")
                                        .font(.subheadline)
//                                    Spacer()
//                                    HStack {
//                                    }
//                                }
                                RatingDisplayView(rating: Int(log.rating))

                                .frame(height: 24)
                            }
                            .padding()
                        }
                    }
                    .onDelete { index in
                        viewModel.deleteBrewLog(index: index.first)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear {
            viewModel.fetchBrewLogs()
            print(viewModel.brewLogs)
        }
        }
    }
}

struct BrewLogsView_Previews: PreviewProvider {
    static var previews: some View {
        BrewLogsView()
    }
}
