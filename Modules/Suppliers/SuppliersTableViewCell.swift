//
//  SuppliersTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 16/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This SuppliersTableViewCell class used for creating supplier table cell
import UIKit

class SuppliersTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var supplierImageview: UIImageView!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var supplierofflineStatus: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var gmailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var activeStatusLabel: UILabel!
    @IBOutlet weak var deletebutton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

