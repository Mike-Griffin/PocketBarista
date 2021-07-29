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
        StrengthPromptView()
    }
}

private struct StrengthPromptView: View {
    var body: some View {
        VStack {
            Text("What strength did you want?")
        }
    }
}

//struct BrewStrengthView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrewStrengthView()
//    }
//}
