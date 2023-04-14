//
//  PaymentDetailTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 24/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This PaymentDetailTblCell class used for create payment details table cell
import UIKit

class PaymentDetailTblCell: UITableViewCell {
    @IBOutlet weak var lblTransactionID: UILabel!
    
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblRemarks: UILabel!
    @IBOutlet weak var lblOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
