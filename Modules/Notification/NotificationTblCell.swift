//
//  NotificationTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 04/01/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//
//This NotificationTblCell class used for create notification table cell
import UIKit

class NotificationTblCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var ImgIcons: UIImageView!
    @IBOutlet weak var ImgBell: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      //  self.ImgBell.isHidden = false
    }
    
}


