//
//  SelectTagsViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/7/21.
//

import Foundation

class SelectTagsViewModel: ObservableObject {
    @Published var availableTags: [PBTag] = [] {
        didSet {
            if searchText.isEmpty {
                searchTags = availableTags
            }
        }
    }
    @Published var searchTags: [PBTag] = []
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty {
                searchTags = availableTags
            } else {
                searchTags = availableTags.filter({ $0.name!.contains(searchText) })
            }
        }
    }
    let manager = CoreDataManager.shared
    func fetchTags() {
        manager.fetchTags { [self] result in
            if Thread.isMainThread {
                print("main thread fetch tags in the select tags")
            } else {
                print("NOT the main thread fetch tags in the select tags NOT NOT")
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let tags):
                    self.availableTags = tags
                case .failure(_):
                    // TODO reconsider if I want to just break
                    self.availableTags = []
                }
            }
        }
    }
    func saveTag() {
        if !searchText.isEmpty {
            CoreDataManager.shared.addTag(name: searchText)
            fetchTags()
        }
    }
}
