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
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $viewModel.name)
                        if !viewModel.availableRoasters.isEmpty {
                            Picker("Roaster", selection: $viewModel.selectedRoaster) {
                                Text("Nothing").tag(nil as PBRoaster?)
                                ForEach(viewModel.availableRoasters, id: \.self) { roaster in
                                    Text(roaster!.name!).tag(roaster)
                                }
                            }
//                            .onChange(of: viewModel.roasterIndex, perform: { _ in
//                                viewModel.updateRoasterLabel()
//                            })
                        }
                        RatingView(rating: $viewModel.rating)
                        Button(action: {
                            viewModel.isShowingPhotoPicker = true
                        }, label: {
                            HStack {
                                Text("\(viewModel.image != nil ? "Edit" : "Add") Image")
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
                        Button(action: {
                            viewModel.isShowingTagPicker = true
                        }, label: {
                            if !viewModel.tags.isEmpty, let tag1 = viewModel.tags[0] {
                                Text(tag1.name!)
                            } else {
                                Text("Select Tags")
                            }
                        })
                    }
                    Button(action: {
                        viewModel.saveCoffee()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                    })
                }
            }
            .navigationTitle(viewModel.coffee == nil ? "Create Coffee Bean" : "")
        }
        .onAppear {
            // doing this to reset all the values in the view model
            // for when the sheet has been closed and opened again
            viewModel.updateState()
        }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker(image: $viewModel.image)
        })
        .sheet(isPresented: $viewModel.isShowingTagPicker, content: {
            SelectTagsView(tags: $viewModel.tags)
        })
    }
}

struct CreateCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeBeanView(viewModel: CoffeeBeanViewModel())
    }
}
