//
//  ExploreMoreCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 30/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This ExploreMoreCollectionViewCell class used for Exlpore collection cell
import UIKit

class ExploreMoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backGroundView.clipsToBounds = true
        self.backGroundView.cornerRadius  = 6
    }
}
