//
//  SupplierDetailsTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 15/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This SupplierDetailsTableViewCell class used for creating supplier table cell
import UIKit

class SupplierDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productCostLabel : UILabel!
    @IBOutlet weak var plusButton       : UIButton!
    @IBOutlet weak var minusButton      : UIButton!
    @IBOutlet weak var productCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true;
        self.layer.shadowColor = UIColor(hexFromString: "#E1EFFC").cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
