//
//  DeliveryTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 25/03/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//
//This DeliveryTblCell class used for create delivery table cell
import UIKit

class DeliveryTblCell: UITableViewCell {
    
    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderName: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var imgDelivery: UIImageView!
    @IBOutlet weak var lblDelivery: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.lblDelivery.cornerRadius = 10
        // Configure the view for the selected state
    }
    
}
