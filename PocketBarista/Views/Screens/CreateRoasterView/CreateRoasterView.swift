//
//  CreateRoasterView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/30/21.
//

import SwiftUI

struct CreateRoasterView: View {
    @StateObject var viewModel = CreateRoasterViewModel()
    var body: some View {
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

struct CreateRoasterView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoasterView()
    }
}
