//
//  PaymentHistoryTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 10/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This PaymentHistoryTblCell class used for create payment history table cell
import UIKit

class PaymentHistoryTblCell: UITableViewCell {
    @IBOutlet weak var lblSupplierBuyer: UILabel!
    
    @IBOutlet weak var lblTransactionId: UILabel!
    @IBOutlet weak var lblTitleRemarks: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblRemarks: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
