//
//  PaymentTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 14/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This PaymentTblCell class used for create payment table cell
import UIKit

class PaymentTblCell: UITableViewCell {
    
    @IBOutlet weak var lblTransactionID: UILabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblInvoiceNum: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblSupplier: UILabel!
    
    @IBOutlet weak var BtnPaid: UIButton!
    @IBOutlet weak var lblRemark: UILabel!
    @IBOutlet weak var lblOutlet: UILabel!
    @IBOutlet weak var lblType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.BtnPaid.cornerRadius = 6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
