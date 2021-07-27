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
    
    func toDayOfWeek() -> String {
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        return weekdays[calendar - 1]
    }
        
    func relativeFromToday() -> String {
        let date = Date()
        // MARK: Difference from today components
        let components:DateComponents = Calendar.current.dateComponents([.minute,.day,.month,.year], from: self, to: date)
        let year = components.year  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let minutes = components.minute ?? 0
        // MARK: Date as components
        let selfComponents :DateComponents = Calendar.current.dateComponents([.year], from: self)
        let dateYear = selfComponents.year  ?? 0
        if year >= 1 {
            return "in \(dateYear)"
        } else if week > 1 {
            return "on \(self.toDateTime(format: "MM/dd/yy"))"
        } else if day > 2 {
            return "on \(self.toDayOfWeek())"
        } else if day > 1 {
            return "yesterday"
        } else if minutes > 1 {
            // this one has an issue with the crossing midnight thing
            return "today at \(self.toDateTime(format: "h:mm a"))"
        } else {
            return "Just now"
        }
    }
}
