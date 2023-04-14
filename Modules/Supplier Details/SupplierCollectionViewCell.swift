//
//  SupplierCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 24/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This SupplierCollectionViewCell class used for creating supplier collection cell
import UIKit
import Cosmos
class SupplierCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView     : UIImageView!
    @IBOutlet weak var heartButton          : UIButton!
    @IBOutlet weak var discountPercetagelabel: UILabel!
    @IBOutlet weak var productName          : UILabel!
    @IBOutlet weak var addedQuantityLabel : UILabel!
    @IBOutlet weak var plusButton           : UIButton!
    @IBOutlet weak var minusButton          : UIButton!
    @IBOutlet weak var cartbutton           : UIButton!
    @IBOutlet weak var productpriceLabel    : UILabel!
    @IBOutlet weak var quantityLabel        : UILabel!
    @IBOutlet weak var reviewView           : CosmosView!
    @IBOutlet weak var supplierNameLabel    : UILabel!
    @IBOutlet weak var quantityStackView    : UIStackView!
    
    @IBOutlet weak var greenBgImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
