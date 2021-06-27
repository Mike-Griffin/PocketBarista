//
//  CreateCoffeeView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

struct CreateCoffeeView: View {
    @ObservedObject var viewModel = CreateCoffeeViewModel()
    var body: some View {
        VStack {
            Text("Create Coffee Bean")
                .font(.largeTitle)
                .padding(.top)
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                }
            }
        }
    }
}

struct CreateCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCoffeeView()
    }
}
