//
//  CreateRoasterViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/30/21.
//

import Foundation

final class CreateRoasterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    let manager = CoreDataManager.shared

    func addRoaster() {
        guard !name.isEmpty, !location.isEmpty else { return }
        manager.addRoaster(name: name, location: location)
    }
}
