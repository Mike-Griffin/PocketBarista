//
//  SelectTagsViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/7/21.
//

import Foundation

class SelectTagsViewModel: ObservableObject {
    @Published var availableTags: [PBTag] = []
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
    func fetchTags() {
        availableTags = CoreDataManager.shared.fetchTags()
    }
    func saveTag() {
        if !searchText.isEmpty {
            CoreDataManager.shared.addTag(name: searchText)
            fetchTags()
        }
    }
}
