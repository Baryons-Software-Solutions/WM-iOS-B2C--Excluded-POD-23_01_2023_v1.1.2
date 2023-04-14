//
//  DeliveryScheduleTblCell.swift
//  Watermelon-iOS_GIT
//  Updated by Avinash on 11/03/23.
//  Created by Apple on 28/12/20.
//  Copyright © 2020 Mac. All rights reserved.
//
// This DeliveryScheduleTblCellis used for creating the Delivery table cell
import UIKit

class DeliveryScheduleTblCell: UITableViewCell {
    
    @IBOutlet weak var lbldays: UILabel!
    @IBOutlet weak var lblDelivery: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
