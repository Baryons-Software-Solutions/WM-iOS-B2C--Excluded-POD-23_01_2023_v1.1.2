//
//  ShopAgainCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This ShopAgainCollectionViewCell class used for shop again collection cell
import UIKit

class ShopAgainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var imageBackGroundView: UIView!
    @IBOutlet weak var produtImageview    : UIImageView!
    @IBOutlet weak var productNameLabel   : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageBackGroundView.clipsToBounds = true
        self.imageBackGroundView.cornerRadius  = 6
    }
}

