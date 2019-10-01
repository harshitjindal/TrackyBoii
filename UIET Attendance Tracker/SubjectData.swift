//
//  SubjectData.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 25/07/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import Foundation
import RealmSwift

class SubjectData: Object {
//    @objc dynamic var date: Date = Date.init()
    @objc dynamic var stringDate: String = "nil"
    @objc dynamic var subjectName: String = "nil"
    @objc dynamic var subjectType: String = "nil"
    @objc dynamic var subjectStatus: String = "nil"
    @objc dynamic var setByUser: Bool = false
}
