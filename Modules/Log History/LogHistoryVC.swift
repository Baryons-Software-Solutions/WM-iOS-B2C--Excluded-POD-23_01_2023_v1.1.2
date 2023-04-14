//
//  LogHistoryVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 07/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class LogHistoryVC: UIViewController {
    
    @IBOutlet weak var tblLogHistory: UITableView!
    var arrLogs = [Log]()
    var objLogsTblCell: LogsTblCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblLogHistory.register(UINib.init(nibName: "LogsTblCell", bundle: nil), forCellReuseIdentifier: "LogsTblCell")
        self.tblLogHistory.tableFooterView = UIView()
        self.tblLogHistory.delegate = self
        self.tblLogHistory.dataSource = self
        self.tblLogHistory.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - UITableView Delegate Methods
// This method is used for create table
extension LogHistoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrLogs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        objLogsTblCell = tableView.dequeueReusableCell(withIdentifier: "LogsTblCell", for: indexPath as IndexPath) as? LogsTblCell
        objLogsTblCell?.lblDate.text = self.arrLogs[indexPath.row].dateTime?.convertDateString(currentFormat: "yyyy-MM-dd HH:mm:ss", extepectedFormat: "dd-MMM-yyyy")
        objLogsTblCell?.lblTiem.text = self.arrLogs[indexPath.row].dateTime?.convertDateString(currentFormat: "yyyy-MM-dd HH:mm:ss", extepectedFormat: "hh:mm a")
        objLogsTblCell?.lblStatus.text = self.arrLogs[indexPath.row].statusName?.rawValue
        objLogsTblCell?.lblNotes.text = self.arrLogs[indexPath.row].notes?.rawValue ?? "---"
        objLogsTblCell?.lblSupplierName.text = self.arrLogs[indexPath.row].ownerName
        return objLogsTblCell ?? UITableViewCell()
        
    }
}
