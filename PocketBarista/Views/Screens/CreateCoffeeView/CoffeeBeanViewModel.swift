//
//  CreateCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import UIKit

class CoffeeBeanViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var availableRoasters: [PBRoaster]
    @Published var roasterIndex: Int = 0
    @Published var roasterLabel: String
    @Published var roasterSelectExpanded = false
    @Published var rating: Int = 0
    @Published var review = ""
    @Published var isShowingPhotoPicker = false
    @Published var image: UIImage?
    @Published var coffee: PBCoffee?
    private var roasterHasBeenExpanded = false
    let manager = CoreDataManager.shared
    init(coffee: PBCoffee? = nil) {
        roasterLabel = ""
        name = ""
        self.coffee = coffee
        availableRoasters = manager.fetchRoasters()
        if coffee != nil {
            name = coffee?.name ?? ""
            rating = Int(coffee?.rating ?? 0)
            if let roaster = coffee?.roaster {
                roasterIndex = availableRoasters.firstIndex(of: roaster) ?? 0
                if let name = roaster.name {
                    roasterLabel = "Roaster: \(name)"
                }
            }
            if let imageData = coffee?.image {
                image = UIImage(data: imageData)
            }
        }
        if roasterLabel.isEmpty {
            roasterLabel = "Select Roaster"
        }
    }
    func saveCoffee() {
        guard !name.isEmpty else { return }
        var roaster: PBRoaster?
        if roasterHasBeenExpanded || roasterIndex != 0 {
            roaster = availableRoasters[roasterIndex]
        }
        print(rating)
        if coffee == nil {
            manager.addCoffee(name: name, roaster: roaster, rating: rating, image: image)
        } else {
            print("need to handle the edit coffee case")
        }
    }
    func fetchRoasters() {
        availableRoasters = manager.fetchRoasters()
    }
    func updateRoasterLabel() {
        roasterHasBeenExpanded = true
        let roaster = availableRoasters[roasterIndex]
        roasterLabel = "Roaster: \(roaster.name!)"
    }
    func updateState() {
        if coffee == nil {
            name = ""
            rating = 0
            review = ""
            roasterIndex = 0
        }
    }
}
