//
//  LargeTextField.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/25/21.
//

import SwiftUI

struct LargeTextEditor: View {
    @Binding var text: String
    var title: String
    var body: some View {
//        if #available(iOS 15.0, *) {
//            ReviewPlaceholderTextEditor(text: $text, title: title)
//        } else {
            ReviewTitleTextEditor(text: $text, title: title)
       // }
    }
}

private struct ReviewTitleTextEditor: View {
    @Binding var text: String
    var title: String
    var body: some View {
        VStack {
            Text(title)
            TextEditor(text: $text)
        }
    }
}

// TODO bring in this iOS 15 logic later
//  @available(iOS 15.0, *)
//  private struct ReviewPlaceholderTextEditor: View {
//    @FocusState private var isFocused: Bool
//    @Binding var text: String
//    var title: String
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            TextEditor(text: $text)
//                .focused($isFocused, equals: true)
//                .zIndex(1)
//            if !isFocused {
//                Text(text.isEmpty ? title : "")
//            }
//        }
//    }
//  }

struct LargeTextField_Previews: PreviewProvider {
    static var previews: some View {
        LargeTextEditor(text: .constant("hi"), title: "Field Title")
    }
}
