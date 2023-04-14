//
//  CutOffTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 31/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This CutOffTableViewCell class used for creating cut off table cell
import UIKit

class CutOffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectButton : UIButton!
    @IBOutlet weak var timeLabel    : UILabel!
    @IBOutlet weak var toggleButton : UISwitch!
    @IBOutlet weak var dayLabel     : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
