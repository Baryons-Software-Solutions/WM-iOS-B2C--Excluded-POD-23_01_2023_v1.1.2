//
//  OffersCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This OffersCollectionViewCell class used for offer collection cell
import UIKit

class OffersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGroundview: UIView!
    @IBOutlet weak var productImageview: UIImageView!
    @IBOutlet weak var productnameLabel : UILabel!
    @IBOutlet weak var productOfferLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

