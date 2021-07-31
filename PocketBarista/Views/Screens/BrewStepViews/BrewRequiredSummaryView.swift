//
//  BrewRequiredSummaryView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/31/21.
//

import SwiftUI

struct BrewRequiredSummaryView: View {
    @ObservedObject var viewModel: BrewStepsViewModel
    var body: some View {
        Text("You'll need this amount:")
    }
}
