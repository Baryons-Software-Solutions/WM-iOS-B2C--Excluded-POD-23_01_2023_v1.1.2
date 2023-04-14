//
//  FilterCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 30/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This FilterCollectionViewCell class used for creating filter collection cell
import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var filteredLabel: UILabel!
    
    var productSectionName = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.cornerRadius = 10.0
        self.bgView.clipsToBounds = true
    }
    
}

