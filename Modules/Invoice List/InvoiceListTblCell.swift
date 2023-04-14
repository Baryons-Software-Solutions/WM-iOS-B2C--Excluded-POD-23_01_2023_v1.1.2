//
//  InvoiceListTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 07/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This InvoiceListTblCell class used for create invoice list table cell
import UIKit

class InvoiceListTblCell: UITableViewCell {
    
    @IBOutlet weak var ButtonDelete: UIButton!
    @IBOutlet weak var btnPaid: UIButton!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSupplierName: UILabel!
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var btnPayments: UIButton!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var btnMarkAsPaidOut: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblReceivedPaidAmount: UILabel!
    @IBOutlet weak var lblInvoiceID: UILabel!
    @IBOutlet weak var lblRemainingPendingAmount: UILabel!
    @IBOutlet weak var lblInvoiceAmount: UILabel!
    @IBOutlet weak var lblremainingAmountTitle: UILabel!
    @IBOutlet weak var lblReceivedAmounttitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblStatus.cornerRadius = 10
        self.backgroundColor = hexStringToUIColor(hex: "#F2F7FC")
        self.ContentView.backgroundColor = hexStringToUIColor(hex: "#F2F7FC")
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnPayNow.layer.borderColor = UIColor(hexFromString: "#EC187B").cgColor
        // Configure the view for the selected state
    }
    
}
