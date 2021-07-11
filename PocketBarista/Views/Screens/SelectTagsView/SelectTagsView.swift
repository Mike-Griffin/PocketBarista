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
            TextField("Search Tag", text: $viewModel.searchText)
                .padding(24)
                .autocapitalization(.none)
            if viewModel.availableTags.isEmpty
                && viewModel.searchText.isEmpty {
                Text("No tags yet. Start typing the name of a tag")
            } else {
                ForEach(viewModel.availableTags) { tag in
                    Button(action: {
                        print("implement the select tag logic")
                        tags.append(tag)
                    }, label: {
                        Text(tag.name ?? "no tag name uh oh").tag(tag)
                    })
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
