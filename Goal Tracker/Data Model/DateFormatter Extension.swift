//
//  DateFormatter Extension.swift
//  Goal Tracker
//
//  Created by Sam  on 7/19/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// The short styled formatter configure with the current settings (calendar, time zone, and locale).
    static var shortCurrent: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.calendar = Calendar.current
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        return formatter
    }
}
