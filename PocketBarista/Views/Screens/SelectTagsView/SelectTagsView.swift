//
//  SelectTagsView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/7/21.
//

import SwiftUI

struct SelectTagsView: View {
    @Binding var tags: [PBTag]
    @StateObject var viewModel = SelectTagsViewModel()
    var body: some View {
        VStack {
            SearchField(text: "Search Tags", searchText: $viewModel.searchText)
            if viewModel.availableTags.isEmpty
                && viewModel.searchText.isEmpty {
                Text("No tags yet. Start typing the name of a tag")
            } else {
                ForEach(viewModel.availableTags) { tag in
                    HStack {
                        Text(tag.name!)
                        Spacer()
                        Image(systemName: tags.contains(tag) ? "checkmark.square" : "square")
                    }
                    .padding(.horizontal)
                    .onTapGesture {
                        if let index = tags.firstIndex(of: tag) {
                            tags.remove(at: index)
                        } else {
                            tags.append(tag)
                        }
                    }
                }
            }
            if viewModel.searchTags.isEmpty && !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.saveTag()
                }, label: {
                    Text("Create tag \(viewModel.searchText)")
                })
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchTags()
        }
    }
}

struct SelectTagsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTagsView(tags: .constant([]))
    }
}
