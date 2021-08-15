//
//  SelectTagsViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/7/21.
//

import Foundation
import Combine

class SelectTagsViewModel: ObservableObject {
    @Published var availableTags: [PBTag] = []
    @Published var searchTags: [PBTag] = []
    @Published var createdTag: PBTag? {
        didSet {
            if let tag = createdTag {
                createdTagPublisher.send(tag)
            }
        }
    }
    var createdTagPublisher = PassthroughSubject<PBTag, Never>()
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty {
                searchTags = availableTags
            } else {
                searchTags = availableTags.filter({ $0.name!.contains(searchText) })
            }
        }
    }
    @Published var isSearching = false
    func fetchTags() {
        availableTags = CoreDataManager.shared.fetchTags()
        searchTags = availableTags
    }
    func saveTag() {
        if !searchText.isEmpty {
            createdTag = CoreDataManager.shared.addTag(name: searchText)
            // fetchTags()
            if let createdTag = createdTag {
                searchTags.append(createdTag)
                availableTags.append(createdTag)
                searchText = ""
            }
        }
    }
}
