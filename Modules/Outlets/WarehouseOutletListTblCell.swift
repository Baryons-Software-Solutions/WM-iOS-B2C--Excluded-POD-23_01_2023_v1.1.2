//
//  WarehouseOutletListTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 21/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This WarehouseOutletListTblCell class used for create warehouse outlet list table cell
import UIKit

class WarehouseOutletListTblCell: UITableViewCell {
    @IBOutlet weak var imgOutletWarehouse: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var editbutton: UIButton!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.DeleteButton.isHidden = false
        // Configure the view for the selected state
    }
    
}

