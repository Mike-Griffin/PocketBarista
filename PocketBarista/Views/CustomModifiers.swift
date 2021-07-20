//
//  CustomModifiers.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: Bool = true
    
    func body(content: Content) -> some View {
        content
            .onReceive(Publishers.keyboardHeight) {  self.keyboardHeight = $0 }
    }
}
