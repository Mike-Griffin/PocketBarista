//
//  CreateCoffeeView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

struct CoffeeBeanView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CoffeeBeanViewModel
    var body: some View {
        VStack {
            if viewModel.coffee == nil {
                Text("Create Coffee Bean")
                    .font(.largeTitle)
                    .padding(.top)
            }
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                    if !viewModel.availableRoasters.isEmpty {
                        DisclosureGroup(viewModel.roasterLabel, isExpanded: $viewModel.roasterSelectExpanded) {
                            Picker("Roaster", selection: $viewModel.roasterIndex) {
                                ForEach(0 ..< viewModel.availableRoasters.count) { index in
                                    Text(viewModel.availableRoasters[index].name!)
                                }
                            }
                            .onChange(of: viewModel.roasterIndex, perform: { _ in
                                viewModel.updateRoasterLabel()
                                viewModel.roasterSelectExpanded = false
                            })
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                    RatingView(rating: $viewModel.rating)
                    Button(action: {
                        viewModel.isShowingPhotoPicker = true
                    }, label: {
                        HStack {
                            Text("Add Image")
                            Spacer()
                            Image(systemName: "camera.fill")
                        }
                    })
                    if viewModel.image != nil {
                        Image(uiImage: viewModel.image!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                    }
                }
                Button(action: {
                    viewModel.saveCoffee()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
        .onAppear {
            // doing this to reset all the values in the view model
            // for when the sheet has been closed and opened again
            viewModel.updateState()
        }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker(image: $viewModel.image)
        })
    }
}

struct CreateCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeBeanView(viewModel: CoffeeBeanViewModel())
    }
}
