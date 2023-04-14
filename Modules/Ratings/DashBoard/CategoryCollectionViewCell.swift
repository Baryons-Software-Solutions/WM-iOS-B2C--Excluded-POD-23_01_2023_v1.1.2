//
//  CategoryCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This CategoryCollectionViewCell class used for category collection cell
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageBgView: UIView!
    @IBOutlet weak var backGrundView: UIView!
    @IBOutlet weak var categoryname: UILabel!
    @IBOutlet weak var BottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backGrundView.clipsToBounds = true
        self.backGrundView.cornerRadius  = 6
    }
    
}


