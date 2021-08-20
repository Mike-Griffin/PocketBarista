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
        self.roaster = roaster
        if let roaster = roaster {
            self.name = roaster.name ?? ""
            self.location = roaster.location ?? ""
        }
    }

    func addRoaster() {
        guard !name.isEmpty, !location.isEmpty else { return }
        if roaster != nil {
            roaster?.name = name
            roaster?.location = location
            manager.editRoaster(roaster: roaster!)
        } else {
            manager.addRoaster(name: name, location: location)
        }
    }
    func updateState() {
        if roaster == nil {
            name = ""
            location = ""
        }
    }
}
