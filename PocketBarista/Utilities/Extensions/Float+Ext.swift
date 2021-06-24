//
//  Float+Ext.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/23/21.
//

import SwiftUI

extension Float {
    // This function rounds to a maximum of 2 significant digits
    // and also will not display trailing zeros
    func textDisplay() -> Text {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if self == Float(Int(self)) {
            return Text(formatter.string(for: self)!)
        } else if self * 10 == Float(Int(self * 10)) {
            return Text("\(self, specifier: "%.1f")")
        } else {
            return Text("\(self, specifier: "%.2f")")
        }
    }
}
