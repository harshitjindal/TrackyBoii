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

var pickedDate: Date?
var weekDay: Int?
var stringDate: String?
var subjectNameString: Array<String>?
var subjectTypeString: Array<String>?

var loadedResults: Results<SubjectData>? = nil

class MarkAttendanceViewController: UIViewController {
    
    let realm = try! Realm()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        pickedDate = Date.init()
        stringDate = formatDate(pickedDate!)
        weekDay = Calendar(identifier: .gregorian).component(.weekday, from: Date.init())
        updateSubjects(weekDay!, reloadTableView: true)
        loadData(stringDate!)
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        pickedDate = sender.date.addingTimeInterval(19800)
        stringDate = formatDate(pickedDate!)
        weekDay = Calendar(identifier: .gregorian).component(.weekday, from: pickedDate!)
        print(pickedDate!)
        print(stringDate!)
        print(weekDay!)
        
        updateSubjects(weekDay!, reloadTableView: true)
        loadData(stringDate!)
//        let cell = SubjectTableViewCell()
//        cell.clearSegmentControl()
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        print(dateFormatter.string(from: pickedDate!))
        
    }
    
    func generateNewEntry(weekDay: Int, cellIndex: Int, segmentedControlIndex: Int) {
        
        let result = (loadedResults?.filter("subjectName LIKE %@ AND subjectType like %@", subjectNameString![cellIndex], subjectTypeString![cellIndex]))
        if result?.count != 0 {
            do {
                try realm.write() {
                    switch segmentedControlIndex {
                    case 0:
                        result?.setValue("No Lecture", forKey: "subjectStatus")
                    case 1:
                        result?.setValue("Attended", forKey: "subjectStatus")
                    case 2:
                        result?.setValue("Missed", forKey: "subjectStatus")
                    case 3:
                        result?.setValue("Mass Bunk", forKey: "subjectStatus")
                    default:
                        return
                    }
                    print("Updating duplicate entry")
                }
            } catch {
                print(error.localizedDescription)
            }
        } else  {
            let newEntry = SubjectData()
            
            newEntry.stringDate = formatDate(pickedDate!)
            self.updateSubjects(weekDay, reloadTableView: false)
            newEntry.subjectName = subjectNameString![cellIndex]
            newEntry.subjectType = subjectTypeString![cellIndex]
            
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
            saveData(date: pickedDate!, entry: newEntry)
            print(newEntry)
        }
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
        cell.segmentControlOutlet.tag = indexPath.row
        
        if loadedResults?.count == 0 {
            cell.modifySegmentControl(index: 0)
        } else {
            if loadedResults?.filter("subjectName LIKE %@ AND subjectType like %@", subjectNameString![indexPath.row], subjectTypeString![indexPath.row]).count != 0 {
                switch loadedResults![indexPath.row].subjectStatus {
                case "No Lecture":
                    cell.modifySegmentControl(index: 0)
                case "Attended":
                    cell.modifySegmentControl(index: 1)
                case "Missed":
                    cell.modifySegmentControl(index: 2)
                case "Mass Bunk":
                    cell.modifySegmentControl(index: 3)
                default:
                    break
                }
            }
        }
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
    
    func loadData(_ stringDate: String) {
        loadedResults = realm.objects(SubjectData.self).filter("stringDate LIKE[c] %@", stringDate)
        if loadedResults?.count != 0 {
            print(loadedResults!)
        }
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
    }
    
    func modifySegmentControl(index: Int) {
        segmentControlOutlet.selectedSegmentIndex = index
    }
}
