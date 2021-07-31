//
//  MeasurementSelectionView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/23/21.
//

import SwiftUI

struct MeasurementSelectionView: View {
    @Binding var selection: MeasurementType
    var body: some View {
        VStack {
            DismissButton()
            Spacer()
            Picker("Measurement Selection Picker", selection: $selection) {
                ForEach(MeasurementType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            Spacer()
        }
    }
}

struct MeasurementSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementSelectionView(selection: .constant(.cup))
    }
}
