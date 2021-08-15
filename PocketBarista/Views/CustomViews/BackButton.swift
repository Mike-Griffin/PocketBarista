//
//  BackButton.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/30/21.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }
                .font(.callout)
            })
            .padding()
            Spacer()
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
