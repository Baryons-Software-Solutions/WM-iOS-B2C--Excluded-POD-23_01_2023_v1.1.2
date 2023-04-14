//
//  AddAddressTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 03/10/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This AddAddressTableViewCell class used for create add address table cell
import UIKit

class AddAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addNewAddressButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
