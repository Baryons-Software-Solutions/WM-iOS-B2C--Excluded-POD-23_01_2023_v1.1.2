//
//  FavouritesTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by admin on 20/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This FavouritesTblCell class used for creating favorite table cell
import UIKit
import Cosmos

class FavouritesTblCell: UITableViewCell {
    @IBOutlet weak var registrationNumber: UILabel!
    @IBOutlet weak var typeOfOutlet: UILabel!
    @IBOutlet weak var supplierImageview: UIImageView!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var gmailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var supplierEmail: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var itemTapped:(() -> Void)?
    
    static let identifier: String = "FavouritesTblCell"
    static func nib() -> UINib {
        return UINib(nibName: "FavouritesTblCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func wishListTapped(_ sender: UIButton) {
        itemTapped!()
    }
}
