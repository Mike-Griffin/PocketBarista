//
//  QuantitySelectionView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/23/21.
//

import SwiftUI

struct QuantitySelectionView: View {
    @Binding var selection: String
    var body: some View {
        TextField("Quantity: ", text: $selection)
    }
}

struct QuantitySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        QuantitySelectionView(selection: .constant("3"))
    }
}
