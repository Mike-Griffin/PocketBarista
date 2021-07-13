//
//  CreateCoffeeViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

class CoffeeBeanViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var availableRoasters: [PBRoaster?] = []
    @Published var roasterIndex: Int = 0
    @Published var selectedRoaster: PBRoaster?
    @Published var roasterLabel: String
    @Published var rating: Int = 0
    @Published var review = ""
    @Published var isShowingPhotoPicker = false
    @Published var image: UIImage = PlaceholderImage.coffeeMug
    @Published var coffee: PBCoffee?
    @Published var isShowingTagPicker = false
    @Published var tags: [PBTag] = []
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    private var roasterHasBeenExpanded = false
    let manager = CoreDataManager.shared
    init(coffee: PBCoffee? = nil) {
        roasterLabel = ""
        name = ""
        self.coffee = coffee

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
                image = UIImage(data: imageData) ?? PlaceholderImage.coffeeMug
            }
        }
        manager.fetchRoasters { [self] result in
            if Thread.isMainThread {
                print("main thread fetch roasters in the coffee bean")
            } else {
                print("NOT the main thread fetch roasters in the coffee bean NOT NOT")
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let roasters):
                    self.availableRoasters = roasters
                case .failure(_):
                    // TODO reconsider if I want to just break
                    self.availableRoasters = []
                }
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
        manager.fetchRoasters { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let roasters):
                    self.availableRoasters = roasters
                case .failure(_):
                    // TODO reconsider if I want to just break
                    self.availableRoasters = []
                }
            }
        }
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
