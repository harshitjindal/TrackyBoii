//
//  ViewController.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 16/07/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

class MarkAttendanceViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet var tableView: UITableView!
    var pickedDate: Date = Date.init()
    var weekDay: Int = Calendar(identifier: .gregorian).component(.weekday, from: Date.init())
    var subjectString: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        updateSubjects(weekDay)
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        pickedDate = sender.date.addingTimeInterval(19800)
        weekDay = Calendar(identifier: .gregorian).component(.weekday, from: pickedDate)
//        print(weekDay)
        
        updateSubjects(weekDay)
    }
    
}

extension MarkAttendanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func updateSubjects(_ day: Int) {
        switch day {
        case 2:
            subjectString = ["Database Management Systems", "Network Security and Cryptography", "Design and Analysis of Algorithms", "Python", "TUT Network Security and Cryptography", "TUT Design and Analysis of Algorithms"]
        case 3:
            subjectString = ["Wireless Communication", "Network Security and Cryptography", "Database Management Systems", "Python", "LAB Design and Analysis of Algorithms"]
        case 4:
            subjectString = ["LAB Database Management Systems", "Database Management Systems", "Design and Analysis of Algorithms", "Wireless Communication", "Wireless Communication"]
        case 5:
            subjectString = ["LAB Python", "Python", "TUT Database Management Systems"]
        case 6:
            subjectString = ["TUT Wireless Communication", "Python", "Network Security and Cryptography", "Design and Analysis of Algorithms", "LAB Wireless Communication"]
        default:
            subjectString = ["NIL"]
        }
        //TODO: - RELOAD TABLEVIEW
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectString!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectTableViewCell
        cell.SessionType.text = ""
        cell.SessionName.text = subjectString![indexPath.row]
        
        cell.segmentControlOutlet.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// TODO: - DATA HANDLING METHODS
extension MarkAttendanceViewController {
    func saveData(date: Date) {
        
    }
    
    func loadData(date: Date) {
        
    }
}

class SubjectTableViewCell: UITableViewCell {
    @IBOutlet var SessionType: UILabel!
    @IBOutlet var SessionName: UILabel!
    
    @IBOutlet var segmentControlOutlet: UISegmentedControl!
    @IBAction func segmentedControlIndex(_ sender: UISegmentedControl) {
        print("Cell \(sender.tag + 1) modified to \(sender.selectedSegmentIndex + 1)")
    }
}
