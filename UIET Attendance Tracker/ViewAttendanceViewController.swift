//
//  ViewAttendanceViewController.swift
//  UIET Attendance Tracker
//
//  Created by Harshit Jindal on 09/09/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import UIKit

class ViewAttendanceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ViewAttendanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordsTableViewCell", for: indexPath) as! RecordsTableViewCell
        switch indexPath.row {
        case 0:
            cell.subjectNameLabel.text = "Network Security and Cryptography"
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
