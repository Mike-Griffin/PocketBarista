//
//  KeyboardHandler.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/20/21.
//

import SwiftUI
import Combine

final class KeyboardHandler: ObservableObject {
    @Published private(set) var keyboardShowing: Bool = false
    private var cancellable: AnyCancellable?
    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        .map { _ in true }
    private let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in false }
    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.self.keyboardShowing, on: self)
    }
}
