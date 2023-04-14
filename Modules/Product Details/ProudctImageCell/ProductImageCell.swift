//
//  ProductImageCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 22/05/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This ProductImageCell class used for create product image  cell
import UIKit

class ProductImageCell: UICollectionViewCell {
    
    static let identifier: String = "ProductImageCell"
    static func nib() -> UINib{
        return UINib(nibName: "ProductImageCell", bundle: nil)
    }
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
