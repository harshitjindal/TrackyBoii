//
//  TimeTableData.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 25/07/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import Foundation
import RealmSwift

class TimeTableData: Object {
    
    @objc dynamic let day: String = "nil"
    
    @objc dynamic let subjectName_9to10: String = "nil"
    @objc dynamic let subjectType_9to10: String = "nil"
    
    @objc dynamic let subjectName_10to11: String = "nil"
    @objc dynamic let subjectType_10to11: String = "nil"
    
    @objc dynamic let subjectName_11to12: String = "nil"
    @objc dynamic let subjectType_11to12: String = "nil"
    
    @objc dynamic let subjectName_12to13: String = "nil"
    @objc dynamic let subjectType_12to13: String = "nil"
    
    @objc dynamic let subjectName_13to14: String = "nil"
    @objc dynamic let subjectType_13to14: String = "nil"
    
    @objc dynamic let subjectName_14to15: String = "nil"
    @objc dynamic let subjectType_14to15: String = "nil"
    
    @objc dynamic let subjectName_15to16: String = "nil"
    @objc dynamic let subjectType_15to16: String = "nil"
    
    @objc dynamic let subjectName_16to17: String = "nil"
    @objc dynamic let subjectType_16to17: String = "nil"
    
    
    //    enum day {
    //        case Monday, Tuesday, Wednesday, Thursday, Friday
    //    }
    //    enum subjectName {
    //        case Monday, Tuesday, Wednesday, Thursday, Friday
    //    }
    //    enum subjectType {
    //        case Monday, Tuesday, Wednesday, Thursday, Friday
    //    }
}
