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
        
        pickedDate = sender.date.addingTimeInterval(19800)
        let weekDay = Calendar(identifier: .gregorian).component(.weekday, from: pickedDate)
        print(weekDay)
        
        updateSubjects(pickedDate)
    }
    
    func updateSubjects(_ pickedDate: Date) {
        
    }

}

extension MarkAttendanceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectTableViewCell
        cell.SessionType.text = "Lecture"
        cell.SessionName.text = "Network Security"
        return cell
    }
}

class SubjectTableViewCell: UITableViewCell {
    @IBOutlet var SessionType: UILabel!
    @IBOutlet var SessionName: UILabel!
    
}
