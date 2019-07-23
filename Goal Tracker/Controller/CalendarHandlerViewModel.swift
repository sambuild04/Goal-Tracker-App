//
//  CalendarHandlerViewModel.swift
//  Goal Tracker
//
//  Created by Sam  on 7/19/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

struct CalendarHandlerViewModel: CalendarSelectionViewModelContrast {

    mutating func setDays(_ days: [Date]) {
        selectedDays = days.sorted()
    }

//    private var goal:
//    
//    var isEditing: Bool {
//        return goal != nil
//    }
    
    private var selectedDays: [Date]?
    
    
    func getFirstDateText() -> String? {
        if let days = selectedDays, !days.isEmpty {
            return DateFormatter.shortCurrent.string(from: days.first!)
        } else {
            return nil
        }
    }
}
