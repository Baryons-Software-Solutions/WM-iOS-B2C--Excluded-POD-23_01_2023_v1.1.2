//
//  LogsTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 30/11/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This LogsTblCell class used for create logs table cell
import UIKit

class LogsTblCell: UITableViewCell {
    
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblSupplierName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTiem:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
