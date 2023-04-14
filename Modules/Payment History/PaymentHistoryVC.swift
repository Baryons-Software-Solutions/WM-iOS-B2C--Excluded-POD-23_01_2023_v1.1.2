//
//  PaymentHistoryVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 10/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class PaymentHistoryVC: UIViewController {

    @IBOutlet weak var tblPaymentHistory: UITableView!
    var arrPayment = [Payment]()
    var arrPaymentHistory = [PaymentHistory]()
    var isHistory = true
    var objPaymentHistoryTblCell: PaymentHistoryTblCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblPaymentHistory.register(UINib.init(nibName: "PaymentHistoryTblCell", bundle: nil), forCellReuseIdentifier: "PaymentHistoryTblCell")
        self.tblPaymentHistory.tableFooterView = UIView()
        self.tblPaymentHistory.delegate = self
        self.tblPaymentHistory.dataSource = self
        self.tblPaymentHistory.reloadData()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnCloseAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
// MARK: - UITableView Delegate Methods

extension PaymentHistoryVC: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHistory{
            return self.arrPaymentHistory.count

        } else {
            return self.arrPayment.count

        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        objPaymentHistoryTblCell = tableView.dequeueReusableCell(withIdentifier: "PaymentHistoryTblCell", for: indexPath as IndexPath) as? PaymentHistoryTblCell
        if isHistory{
           // objPaymentHistoryTblCell?.lblDate.text = self.arrPaymentHistory[indexPath.row].date.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy hh:mm a")
            objPaymentHistoryTblCell?.lblDate.text = "\(self.arrPaymentHistory[indexPath.row].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy hh:mm a"))"

            objPaymentHistoryTblCell?.lblType.text = "Payment type: \(self.arrPaymentHistory[indexPath.row].type)"
            objPaymentHistoryTblCell?.lblAmount.text = self.arrPaymentHistory[indexPath.row].amount?.rawValue
            objPaymentHistoryTblCell?.lblRemarks.text = self.arrPaymentHistory[indexPath.row].remarks
            objPaymentHistoryTblCell?.lblTransactionId.text = "Transaction Id : \(self.arrPaymentHistory[indexPath.row].transactionId?.rawValue ?? "---")"

            objPaymentHistoryTblCell?.lblSupplierBuyer.text = "\(self.arrPaymentHistory[indexPath.row].supplierInfo.supplierName?.rawValue ?? "")"


        } else {
            objPaymentHistoryTblCell?.lblDate.text = "\(self.arrPayment[indexPath.row].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy hh:mm a"))"
            objPaymentHistoryTblCell?.lblType.text = "Payment type: \(self.arrPayment[indexPath.row].type)"

            objPaymentHistoryTblCell?.lblAmount.text = self.arrPayment[indexPath.row].amount?.rawValue
            objPaymentHistoryTblCell?.lblRemarks.text = self.arrPayment[indexPath.row].remarks
        //    objPaymentHistoryTblCell?.lblTransactionId.text = "Transaction Id : \(self.arrPayment[indexPath.row].transactionId?.rawValue ?? "--")"
            objPaymentHistoryTblCell?.lblTransactionId.text = "Transaction Id : \(self.arrPayment[indexPath.row].transactionId?.rawValue ?? "---")"

            objPaymentHistoryTblCell?.lblSupplierBuyer.text = "\(self.arrPayment[indexPath.row].supplierInfo?.supplierName?.rawValue ?? "")"

        }

        return objPaymentHistoryTblCell ?? UITableViewCell()

    }
}
