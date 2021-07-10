//
//  CreateCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import UIKit

class CoffeeBeanViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var availableRoasters: [PBRoaster?]
    @Published var roasterIndex: Int = 0
    @Published var selectedRoaster: PBRoaster?
    @Published var roasterLabel: String
    @Published var rating: Int = 0
    @Published var review = ""
    @Published var isShowingPhotoPicker = false
    @Published var image: UIImage?
    @Published var coffee: PBCoffee?
    @Published var isShowingTagPicker = false
    @Published var tags: [PBTag] = []
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
            tags = coffee?.tags?.allObjects as? [PBTag] ?? []
            selectedRoaster = coffee?.roaster
//            if let roaster = coffee?.roaster {
//                selectedRoaster = roaster
//
//            }
            if let imageData = coffee?.image {
                image = UIImage(data: imageData)
            }
        }
    }
    func saveCoffee() {
        guard !name.isEmpty else { return }
        if coffee == nil {
            manager.addCoffee(name: name, roaster: selectedRoaster, rating: rating, image: image, tags: tags)
        } else {
            print("need to handle the edit coffee case")
        }
    }
    func fetchRoasters() {
        availableRoasters = manager.fetchRoasters()
    }
//    func updateRoasterLabel() {
//        roasterHasBeenExpanded = true
//        let roaster = availableRoasters[roasterIndex]
//        roasterLabel = "Roaster: \(roaster.name!)"
//    }
    func updateState() {
        if coffee == nil {
            name = ""
            rating = 0
            review = ""
            roasterIndex = 0
        }
    }
}
