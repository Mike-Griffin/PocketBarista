//
//  BrewStrengthView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/28/21.
//

import SwiftUI

struct BrewStrengthView: View {
    @ObservedObject var viewModel: BrewStepsViewModel
    var body: some View {
        StrengthPromptView(strength: $viewModel.strength, showingStrengthSheet: $viewModel.showingStrengthSheet)
    }
}

private struct StrengthPromptView: View {
    @Binding var strength: Strength
    @Binding var showingStrengthSheet: Bool
    var body: some View {
        VStack {
            Text("What strength did you want?")
            Text(strength.rawValue.capitalized)
                .onTapGesture {
                    showingStrengthSheet = true
                }
        }
        .sheet(isPresented: $showingStrengthSheet, content: {
            StrengthSelectionView(selection: $strength)
        })
    }
}

//struct BrewStrengthView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrewStrengthView()
//    }
//}
