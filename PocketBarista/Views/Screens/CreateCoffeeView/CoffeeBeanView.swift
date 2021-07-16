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
                ZStack {
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 84, height: 84)

                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .offset(y: 30)
                        .foregroundColor(.white)

                }
                .clipShape(Circle())
                .onTapGesture {
                    viewModel.isShowingPhotoPicker = true
                }
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
                        } else {
                            NavigationLink(destination: CreateRoasterView(), label: {
                                Text("No roasters exist. Create one")
                            })
                        }

                    }
                    Section {
                        Button(action: {
                            viewModel.isShowingTagPicker = true
                        }, label: {
                            Text("Select Tags")
                        })
                        if !viewModel.tags.isEmpty {
                            LazyVGrid(columns: viewModel.columns, content: {
                                ForEach(viewModel.tags) { tag in
                                    Text(tag.name!)
                                }
                            })
                        }
                    }
                    Section {
                        HStack {
                            Text("Rating")
                            Spacer()
                            RatingView(rating: $viewModel.rating)
                        }
                        ReviewTextArea(text: $viewModel.review)
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
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveCoffee()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            })

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

struct ReviewTextArea: View {
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
            Text(text.isEmpty ? "Review" : "")
        }

    }
}
