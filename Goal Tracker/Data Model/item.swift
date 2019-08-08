//
//  item.swift
//  Goal Tracker
//
//  Created by Sam  on 5/27/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

class item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var color: String = ""
    @objc dynamic var date: String = ""

}

