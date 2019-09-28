//
//  ViewAttendanceViewController.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 09/09/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import UIKit
import RealmSwift

class ViewAttendanceViewController: UIViewController {

    let realm = try! Realm()
    var selectedType = "Lecture"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedType = "Lecture"
            tableView.reloadData()
        case 1:
            selectedType = "Lab"
            tableView.reloadData()
        default: break
        }
    }
    

}

extension ViewAttendanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedType == "Lecture" { return 5 }
        else { return 4 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordsTableViewCell", for: indexPath) as! RecordsTableViewCell
        if selectedType == "Lecture" {
            switch indexPath.row {
            case 0:
                cell.subjectNameLabel.text = "Network Security and Cryptography"
                let results = realm.objects(SubjectData.self).filter("subjectName == 'Network Security and Cryptography' AND subjectType == 'Lecture' AND subjectStatus == 'Attended' ")
                print(results)
            case 1:
                cell.subjectNameLabel.text = "Design and Analysis of Algorithms"
            case 2:
                cell.subjectNameLabel.text = "Database Management Systems"
            case 3:
                cell.subjectNameLabel.text = "Wireless Communication"
            case 4:
                cell.subjectNameLabel.text = "Python"
            default: break
            }
        }
        
        else if selectedType == "Lab" {
            switch indexPath.row {
            case 0:
                cell.subjectNameLabel.text = "Design and Analysis of Algorithms"
            case 1:
                cell.subjectNameLabel.text = "Database Management Systems"
            case 2:
                cell.subjectNameLabel.text = "Wireless Communication"
            case 3:
                cell.subjectNameLabel.text = "Python"
            default: break
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

class RecordsTableViewCell: UITableViewCell {
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var attendaceLabel: UILabel!
    @IBOutlet weak var massBunksLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
}
