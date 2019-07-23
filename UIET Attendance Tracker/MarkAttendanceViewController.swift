//
//  ViewController.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 16/07/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import UIKit
import UserNotifications

class MarkAttendanceViewController: UIViewController {

    var pickedDate: Date = Date.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        pickedDate = Date.init(timeInterval: 19800, since: sender.date)
        print(pickedDate)
        
        updateSubjects(pickedDate)
    }
    
    func updateSubjects(_ pickedDate: Date) {
        
    }

}

