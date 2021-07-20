//
//  Notification+Ext.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/19/21.
//

import UIKit

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
