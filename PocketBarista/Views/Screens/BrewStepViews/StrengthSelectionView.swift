//
//  StrengthSelectionView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/30/21.
//

import SwiftUI

struct StrengthSelectionView: View {
    @Binding var selection: Strength
    var body: some View {
        VStack {
            DismissButton()
            Spacer()
            Picker("Strength Selection Picker", selection: $selection) {
                ForEach(Strength.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct StrengthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StrengthSelectionView(selection: .constant(.regular))
    }
}
