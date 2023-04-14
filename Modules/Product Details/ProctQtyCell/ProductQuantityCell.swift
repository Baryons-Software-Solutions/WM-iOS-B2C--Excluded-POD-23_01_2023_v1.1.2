//
//  ProductQuantityCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 22/05/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This ProductQuantityCell class used for create product quantity collection cell
import UIKit

class ProductQuantityCell: UICollectionViewCell {
    
    static let identifier: String = "ProductQuantityCell"
    static func nib() -> UINib{
        return UINib(nibName: "ProductQuantityCell", bundle: nil)
    }
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
