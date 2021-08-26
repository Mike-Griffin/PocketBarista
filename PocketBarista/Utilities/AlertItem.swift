//
//  AlertItem.swift
//  PocketBarista
//
//  Created by Mike Griffin on 8/20/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let primaryButton: Alert.Button?
    let secondaryButton: Alert.Button?
}

struct AlertContext {
    static let noCoffeeSelected = AlertItem(title: Text("No Coffee"),
                                            message: Text("You sure about that"),
                                            primaryButton: .default(Text("Yes"), action: {
                                                print("do something crazy")
                                            }),
                                            secondaryButton: .cancel())
}
