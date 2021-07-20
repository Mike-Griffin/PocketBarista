//
//  Publishers+Ext.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/19/21.
//

import Combine
import CoreGraphics
import UIKit

extension Publishers {
    static var keyboardHeight: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in true}
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in false}
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
