//
//  BrewLogsViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/25/21.
//

import Foundation

final class BrewLogsViewModel: ObservableObject {
    @Published var brewLogs: [PBBrewLog] = []
    func fetchBrewLogs() {
        brewLogs = CoreDataManager.shared.fetchBrewLogs()
        for log in brewLogs {
            print(log.coffee?.name ?? "nil coffee")
        }
    }
}
