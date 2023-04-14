//
//  MyCartTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 29/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This MyCartTableViewCell class used for creating my cart table cell
import UIKit

class MyCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage         : UIImageView!
    @IBOutlet weak var productTitle         : UILabel!
    @IBOutlet weak var outletName           : UILabel!
    @IBOutlet weak var numberofItemsLabel   : UILabel!
    @IBOutlet weak var productCostLabel     : UILabel!
    @IBOutlet weak var rightArrow           : UIButton!
    @IBOutlet weak var deleteButton         : UIButton!
    @IBOutlet weak var minOrderLabel        : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

