//
//  SearchField.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/16/21.
//

import SwiftUI

struct SearchField: View {
    var text: String
    @Binding var searchText: String
    var body: some View {
        TextField(text, text: $searchText)
            .padding(24)
            .autocapitalization(.none)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(text: "Search", searchText: .constant("hello"))
    }
}
