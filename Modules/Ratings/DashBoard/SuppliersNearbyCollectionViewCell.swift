//
//  SuppliersNearbyCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This SuppliersNearbyCollectionViewCell class used for suppliers near by cell
import UIKit

class SuppliersNearbyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBacGroundView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageBacGroundView.clipsToBounds = true
        self.imageBacGroundView.cornerRadius  = 6
    }

}

