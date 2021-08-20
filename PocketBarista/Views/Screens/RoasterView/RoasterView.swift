//
//  CreateRoasterView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/30/21.
//

import SwiftUI

struct RoasterView: View {
    @ObservedObject var viewModel: RoasterViewModel
    var body: some View {
        VStack {
            BackButton()
            Form {
                TextField("Name", text: $viewModel.name)
                TextField("Location", text: $viewModel.location)
                Button(action: {
                    viewModel.addRoaster()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}
