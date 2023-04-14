//
//  WelcomeCollectionViewCells.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 16/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This WelcomeCollectionViewCells class used for creating Welcome collection cell
import UIKit

class WelcomeCollectionViewCells: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var onBoardingImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
