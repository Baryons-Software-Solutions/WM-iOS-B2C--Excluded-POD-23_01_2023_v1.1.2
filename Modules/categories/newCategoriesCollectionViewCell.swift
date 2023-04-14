//
//  newCategoriesCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Baryons on 21/11/22.
// Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This newCategoriesCollectionViewCell class used for creating the category table cell
import UIKit

class newCategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ProductName      : UILabel!
    @IBOutlet weak var bottomSectionView: UILabel!
    @IBOutlet weak var backGroundView   : UIView!
    @IBOutlet weak var imgBGView        : UIView!
    @IBOutlet weak var catogoryImgView  : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.catogoryImgView.layer.cornerRadius = catogoryImgView.frame.size.width / 2
        self.catogoryImgView.clipsToBounds = true
        self.imgBGView.clipsToBounds = true
        self.imgBGView.layer.cornerRadius = catogoryImgView.frame.size.width / 2
        self.imgBGView.cornerRadius  = 6
    }
    
}
