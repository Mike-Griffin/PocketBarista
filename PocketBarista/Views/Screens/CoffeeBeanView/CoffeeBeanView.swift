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
                    CoffeeImage(image: viewModel.image)
                    EditImage()
                }
                .clipShape(Circle())
                .onTapGesture {
                    viewModel.isshowingPhotoActionSheet = true
                }
                Form {
                    IdentitySection(name: $viewModel.name,
                                    selectedRoaster: $viewModel.selectedRoaster,
                                    availableRoasters: viewModel.availableRoasters)
                    TagsSection(isShowingTagPicker: $viewModel.isShowingTagPicker,
                                columns: viewModel.columns,
                                tags: viewModel.tags)
                    Section {
                        HStack {
                            Text("Rating")
                            Spacer()
                            RatingView(rating: $viewModel.rating)
                        }
                        if #available(iOS 15.0, *) {
                            ReviewPlaceholderTextEditor(text: $viewModel.review)
                        } else {
                            ReviewTitleTextEditor(text: $viewModel.review)
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
        .actionSheet(isPresented: $viewModel.isshowingPhotoActionSheet, content: {
            ActionSheet(title: Text("Photo from what??"),
                        buttons: [
                            .default(Text("Take a new photo")) {
                                viewModel.photoPickerSourceType = .camera
                                viewModel.isShowingPhotoPicker = true
                            },
                            .default(Text("Choose from library")) {
                                viewModel.photoPickerSourceType = .photoLibrary
                                viewModel.isShowingPhotoPicker = true
                            }
                        ])
        })
        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker(image: $viewModel.image, sourceType: viewModel.photoPickerSourceType)
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

private struct CoffeeImage: View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 84, height: 84)
    }
}

private struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 12, height: 12)
            .offset(y: 30)
            .foregroundColor(.white)
    }
}

private struct IdentitySection: View {
    @Binding var name: String
    @Binding var selectedRoaster: PBRoaster?
    var availableRoasters: [PBRoaster?]
    var body: some View {
        Section {
            TextField("Name", text: $name)
            if !availableRoasters.isEmpty {
                RoasterPicker(selectedRoaster: $selectedRoaster, availableRoasters: availableRoasters)
            } else {
                NavigationLink(destination: CreateRoasterView(), label: {
                    Text("No roasters exist. Create one")
                })
            }
        }
    }
}

private struct RoasterPicker: View {
    @Binding var selectedRoaster: PBRoaster?
    var availableRoasters: [PBRoaster?]
    var body: some View {
        Picker("Roaster", selection: $selectedRoaster) {
            Text("Nothing").tag(nil as PBRoaster?)
            ForEach(availableRoasters, id: \.self) { roaster in
                Text(roaster!.name!).tag(roaster)
            }
        }
    }
}

private struct TagsSection: View {
    @Binding var isShowingTagPicker: Bool
    var columns: [GridItem]
    var tags: [PBTag]
    var body: some View {
        Section {
            Button(action: {
                isShowingTagPicker = true
            }, label: {
                Text("Select Tags")
            })
            if !tags.isEmpty {
                LazyVGrid(columns: columns, content: {
                    ForEach(tags) { tag in
                        Text(tag.name!)
                    }
                })
            }
        }

    }
}

private struct ReviewTitleTextEditor: View {
    @Binding var text: String
    var body: some View {
        VStack {
            Text("Review")
            TextEditor(text: $text)
        }
    }
}

@available(iOS 15.0, *)
private struct ReviewPlaceholderTextEditor: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .focused($isFocused, equals: true)
                .zIndex(1)
            if !isFocused {
                Text(text.isEmpty ? "Review" : "")
            }
        }
    }
}