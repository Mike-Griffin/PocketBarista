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
        VStack {
            Spacer()
            StrengthPromptView(strength: $viewModel.strength, showingStrengthSheet: $viewModel.showingStrengthSheet)
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                NavigationLink(destination: BrewRequiredSummaryView(viewModel: viewModel)) {
                    VStack {
                        Image(systemName: "chevron.forward")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.brandPrimary)
                            .clipShape(Circle())
                        Text("Continue")
                            .font(.subheadline)
                    }
                }
                Spacer()
                Button {
                    print("ya boy")
                } label: {
                    VStack {
                        Image(systemName: "pencil.circle")
                        Text("Custom\nRatio")
                            .font(.subheadline)
                    }
                }
            }
            .padding()
        }
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
