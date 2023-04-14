//
//  InvoiceDetailTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 09/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This InvoiceDetailTblCell class used for create invoice detail table cell
import UIKit

class InvoiceDetailTblCell: UITableViewCell {
    @IBOutlet weak var lblPricePerUnit: UILabel!
    
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTotalProductPrice: UILabel!
    @IBOutlet weak var lblProductCode: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgProduct.layer.cornerRadius = self.imgProduct.frame.width / 2
        self.imgProduct.layer.masksToBounds = false
        self.imgProduct.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
