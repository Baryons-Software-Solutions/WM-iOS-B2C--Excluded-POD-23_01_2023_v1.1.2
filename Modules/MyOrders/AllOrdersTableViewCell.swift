//
//  AllOrdersTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 15/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This AllOrdersTableViewCell class used for creating all order table cell
import UIKit
import Cosmos

class AllOrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var emailSentLable: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var outletNameLabel: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var ordersImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var payementDueLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var ordersSent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
