//
//  RatingTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 31/03/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//
//This RatingTblCell class used for create rating table cell
import UIKit
import Cosmos
class RatingTblCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnEditRating: UIButton!
    @IBOutlet weak var btnDeleteRating: UIButton!
    override func awakeFromNib() {
        // Initialization code
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
        super.setSelected(selected, animated: animated)
    }
    
}
