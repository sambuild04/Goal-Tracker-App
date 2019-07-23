//
//  CalendarSelectionViewModelContrast.swift
//  Goal Tracker
//
//  Created by Sam  on 7/19/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

protocol CalendarSelectionViewModelContrast {
//    var isEditing: Bool { get }
    
    func getFirstDateText() -> String?
    
    mutating func setDays(_ days: [Date])

}
//
//extension CalendarSelectionViewModelContrast {
//    var canDeleteDate: Bool {
//        return isEditing
//    }
//}
