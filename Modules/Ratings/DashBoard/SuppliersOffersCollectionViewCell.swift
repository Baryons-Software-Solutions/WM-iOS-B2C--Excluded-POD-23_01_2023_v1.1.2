//
//  SuppliersOffersCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This SuppliersOffersCollectionViewCell class used for supplier offers collection cell
import UIKit

class SuppliersOffersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var suppliersImageView   : UIImageView!
    @IBOutlet weak var backGrundView        : UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.suppliersImageView.clipsToBounds = true
        self.suppliersImageView.cornerRadius  = 6
    }

    
}

