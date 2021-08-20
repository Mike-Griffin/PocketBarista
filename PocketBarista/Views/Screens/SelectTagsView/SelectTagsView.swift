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
            BackButton()
            SearchBarView(searchText: $viewModel.searchText, isSearching: $viewModel.isSearching)
            if viewModel.availableTags.isEmpty
                && viewModel.searchText.isEmpty {
                Text("No tags yet. Start typing the name of a tag")
            } else {
                List {
                    ForEach(viewModel.searchTags) { tag in
                        HStack {
                            Text(tag.name!)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                            Spacer()
                            Image(systemName: tags.contains(tag)
                                    ? "checkmark.square"
                                    : "square")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .padding(.leading, 24)
                        .padding(.trailing, 8)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            playHaptic()
                            if let index = tags.firstIndex(of: tag) {
                                tags.remove(at: index)
                            } else {
                                tags.append(tag)
                            }
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
        .onReceive(viewModel.createdTagPublisher) { tag in
            tags.append(tag)
        }
    }
}

struct SelectTagsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTagsView(tags: .constant([]))
    }
}
