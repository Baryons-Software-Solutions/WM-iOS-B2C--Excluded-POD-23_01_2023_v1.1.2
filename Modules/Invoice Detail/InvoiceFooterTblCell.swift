//
//  InvoiceFooterTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 24/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This InvoiceFooterTblCell class used for create invoice footer table cell
import UIKit

class InvoiceFooterTblCell: UITableViewCell {
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var btnMarkAsPaidOut: UIButton!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var lblVatPrice: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblVatTitle: UILabel!
    @IBOutlet weak var lblPaidAmount: UILabel!
    @IBOutlet weak var lblRemainingAmount: UILabel!
    @IBOutlet weak var lblReceivedAmountTitle: UILabel!
    @IBOutlet weak var lblPaidNotes: UILabel!
    @IBOutlet weak var vwPaidNotes: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnPayNow.cornerRadius = 6
        self.btnMarkAsPaidOut.cornerRadius = 6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
