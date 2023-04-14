//
//  WishlistTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by admin on 20/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This WishlistTblCell class used for creating Wishlist table cell
import UIKit

class WishlistTblCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var priceStack: UIStackView!
    @IBOutlet weak var SupplierName: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var QuantityStackView: UIStackView!
    @IBOutlet weak var MinusButton: UIButton!
    @IBOutlet weak var AddQuantityLbl: UILabel!
    @IBOutlet weak var PlusButton: UIButton!
    
    var itemTapped: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteTapped(_ sender: UIButton) {
        //     self.vwDelete.isHidden   = false
        //   itemTapped?()
    }
}

