//
//  CreateCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

class CoffeeBeanViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var availableRoasters: [PBRoaster?]
    @Published var roasterIndex: Int = 0
    @Published var selectedRoaster: PBRoaster?
    @Published var rating: Int = 0
    @Published var review = ""
    @Published var isShowingPhotoPicker = false
    @Published var photoPickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var image: UIImage = PlaceholderImage.coffeeMug
    @Published var coffee: PBCoffee?
    @Published var isShowingTagPicker = false
    @Published var tags: [PBTag] = []
    @Published var isshowingPhotoActionSheet = false
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    let manager = CoreDataManager.shared
    init(coffee: PBCoffee? = nil) {
        name = ""
        self.coffee = coffee
        availableRoasters = manager.fetchRoasters()
        if coffee != nil {
            name = coffee?.name ?? ""
            rating = Int(coffee?.rating ?? 0)
            tags = coffee?.tags?.allObjects as? [PBTag] ?? []
            selectedRoaster = coffee?.roaster
            if let imageData = coffee?.image {
                image = UIImage(data: imageData) ?? PlaceholderImage.coffeeMug
            }
        }
    }
    func saveCoffee() {
        guard !name.isEmpty else { return }
        if let coffee = coffee {
            editCoffee(coffee)
        } else {
            manager.addCoffee(name: name, roaster: selectedRoaster, rating: rating, image: image, tags: tags)
        }
    }
    private func editCoffee(_ coffee: PBCoffee) {
        coffee.name = name
        coffee.roaster = selectedRoaster
        coffee.rating = Int16(rating)
        coffee.image = image.pngData()
        let tagsSet = Set(tags) as NSSet
        coffee.setValue(tagsSet, forKey: "tags")
        manager.editCoffee(coffee: coffee)
    }
    func fetchRoasters() {
        availableRoasters = manager.fetchRoasters()
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
