//
//  SearchField.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/16/21.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    var body: some View {
        TextField("Search Tag", text: $searchText)
            .padding(24)
            .autocapitalization(.none)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(searchText: .constant("hello"))
    }
}
