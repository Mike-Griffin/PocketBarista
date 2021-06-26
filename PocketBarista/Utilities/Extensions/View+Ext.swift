//
//  View+Ext.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/24/21.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
