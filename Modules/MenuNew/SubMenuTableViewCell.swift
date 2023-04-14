//
//  SubMenuTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 09/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This SubMenuTableViewCell class used for creating sub menu table cell
import UIKit

class SubMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subMenuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
