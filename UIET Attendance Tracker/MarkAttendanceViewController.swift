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

var weekDay: Int?

class MarkAttendanceViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    
    var pickedDate: Date = Date.init()
    var stringDate: String = "NIL"
    
    var subjectNameString: Array<String>?
    var subjectTypeString: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        weekDay = Calendar(identifier: .gregorian).component(.weekday, from: Date.init())
        updateSubjects(weekDay!, reloadTableView: true)
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        pickedDate = sender.date.addingTimeInterval(19800)
        stringDate = formatDate(pickedDate)
        weekDay = Calendar(identifier: .gregorian).component(.weekday, from: pickedDate)
        print(pickedDate)
        print(stringDate)
        print(weekDay!)
        
        updateSubjects(weekDay!, reloadTableView: true)
//        loadData(stringDate)
//        let cell = SubjectTableViewCell()
//        cell.clearSegmentControl()
        
        
    }
    
    func generateNewEntry(weekDay: Int, cellIndex: Int, segmentedControlIndex: Int) {
        let newEntry = SubjectData()
//        newEntry.date = pickedDate
        newEntry.stringDate = formatDate(pickedDate)
        self.updateSubjects(weekDay, reloadTableView: false)
        newEntry.subjectName = self.subjectNameString![cellIndex]
        newEntry.subjectType = self.subjectTypeString![cellIndex]
        switch segmentedControlIndex {
        case 0:
            newEntry.subjectStatus = "No Lecture"
        case 1:
            newEntry.subjectStatus = "Attended"
        case 2:
            newEntry.subjectStatus = "Missed"
        case 3:
            newEntry.subjectStatus = "Mass Bunk"
        default:
            return
        }
        
        print(newEntry)
        saveData(date: pickedDate, entry: newEntry)
    }
    
    func formatDate(_ pickedDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: pickedDate)
    }
}

extension MarkAttendanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func updateSubjects(_ day: Int, reloadTableView: Bool) {
        switch day {
        case 2:
            subjectNameString = ["Database Management Systems", "Network Security and Cryptography", "Design and Analysis of Algorithms", "Python", "Network Security and Cryptography", "Design and Analysis of Algorithms"]
            subjectTypeString = ["Lecture", "Lecture", "Lecture", "Lecture", "Tutorial", "Tutorial"]
        case 3:
            subjectNameString = ["Wireless Communication", "Network Security and Cryptography", "Database Management Systems", "Python", "Design and Analysis of Algorithms"]
            subjectTypeString = ["Lecture", "Lecture", "Lecture", "Lecture", "Lab"]
        case 4:
            subjectNameString = ["Database Management Systems", "Database Management Systems", "Design and Analysis of Algorithms", "Wireless Communication", "Wireless Communication"]
            subjectTypeString = ["Lab", "Lecture", "Lecture", "Lecture", "Lecture"]
        case 5:
            subjectNameString = ["Python", "Python", "Database Management Systems"]
            subjectTypeString = ["Lab", "Lecture", "Tutorial"]
        case 6:
            subjectNameString = ["Wireless Communication", "Python", "Network Security and Cryptography", "Design and Analysis of Algorithms", "Wireless Communication"]
            subjectTypeString = ["Tutorial", "Lecture", "Lecture", "Lecture", "Lab"]
        default:
            subjectNameString = ["NIL"]
            subjectTypeString = ["NIL"]
        }
        
        if reloadTableView == true {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subjectNameString!.contains("NIL") {
            return 0
        } else {
            return subjectNameString!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! SubjectTableViewCell
        cell.SessionType.text = subjectTypeString![indexPath.row]
        cell.SessionName.text = subjectNameString![indexPath.row]
        cell.clearSegmentControl()
        cell.segmentControlOutlet.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// TODO: - DATA HANDLING METHODS
extension MarkAttendanceViewController {
    func saveData(date: Date, entry: SubjectData) {
        do {
            try realm.write {
                realm.add(entry)
            }
        } catch {
            print(error.localizedDescription)
        }
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
        
        //TODO:- Create SubjectData Entry
        let markAttendanceViewController = MarkAttendanceViewController()
        markAttendanceViewController.generateNewEntry(weekDay: weekDay! ,cellIndex: sender.tag, segmentedControlIndex: sender.selectedSegmentIndex)
//        segmentControlOutlet.isMomentary = false
    }
    
    func clearSegmentControl() {
        segmentControlOutlet.selectedSegmentIndex = 0
    }
}
