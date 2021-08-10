//
//  QuantityTextField.swift
//  PocketBarista
//
//  Created by Mike Griffin on 8/9/21.
//

import SwiftUI

struct QuantityTextField: View {
    @Binding var quantity: String
    @State var previousQuantity: String = ""
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $quantity) { change in
                if previousQuantity.isEmpty {
                    previousQuantity = quantity
                }
                if change {
                    quantity = ""
                } else {
                    if quantity.isEmpty {
                        quantity = previousQuantity
                        previousQuantity = ""
                    }
                }
            }
            .keyboardType(.numbersAndPunctuation)
            .frame(height: 34)
            .frame(minWidth: 24)
            .onTapGesture {
                previousQuantity = quantity
                quantity = ""
            }
            Rectangle()
                .frame(height: 2)
        }
        .fixedSize()
    }
}
