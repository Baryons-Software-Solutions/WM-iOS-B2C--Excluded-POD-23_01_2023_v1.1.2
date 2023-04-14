//
//  SearchResultCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 30/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This SearchResultCollectionViewCell class used for creating supplier result collection cell
import UIKit
import Cosmos
class SearchResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var percentageLabel  : UILabel!
    @IBOutlet weak var likeButton       : UIButton!
    @IBOutlet weak var productImage     : UIImageView!
    @IBOutlet weak var productName      : UILabel!
    @IBOutlet weak var categoryName     : UILabel!
    @IBOutlet weak var addCart          : UIButton!
    @IBOutlet weak var weightLabel      : UILabel!
    @IBOutlet weak var amountLabel      : UILabel!
    @IBOutlet weak var percentageBackGround: UIImageView!
    @IBOutlet weak var ratingImage      : CosmosView!
    @IBOutlet weak var backGrundView    : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ratingImage.rating = 2.0
        self.backGrundView.clipsToBounds = true
        self.backGrundView.cornerRadius  = 12
    }
}

