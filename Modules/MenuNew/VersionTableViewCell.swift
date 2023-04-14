//
//  VersionTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 10/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This VersionTableViewCell class used for creating version table cell
import UIKit

class VersionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var versionNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
