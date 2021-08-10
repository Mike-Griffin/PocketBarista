//
//  CreateRoasterViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/30/21.
//

import Foundation

final class RoasterViewModel: ObservableObject {
    @Published var name: String
    @Published var location: String
    @Published var roaster: PBRoaster?
    let manager = CoreDataManager.shared
    init(roaster: PBRoaster?) {
        name = ""
        location = ""
        if let roaster = roaster {
            self.name = roaster.name ?? ""
            self.location = roaster.location ?? ""
        }
    }

    func addRoaster() {
        guard !name.isEmpty, !location.isEmpty else { return }
        manager.addRoaster(name: name, location: location)
    }
}
