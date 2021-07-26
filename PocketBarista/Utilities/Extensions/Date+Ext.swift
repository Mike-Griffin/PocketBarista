//
//  Date+Ext.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/25/21.
//

import Foundation

extension Date {

    func toDateTime(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
