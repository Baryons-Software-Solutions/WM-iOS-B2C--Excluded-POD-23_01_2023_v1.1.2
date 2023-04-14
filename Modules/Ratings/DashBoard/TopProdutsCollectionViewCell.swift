//
//  TopProdutsCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This TopProdutsCollectionViewCell class used for top products collection cell
import UIKit

class TopProdutsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productNamelabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var prodcutSubNameLabel: UILabel!
    @IBOutlet weak var productBackgoundView: UIView!
    
    @IBOutlet weak var lblProductImgName: UILabel!
    @IBOutlet weak var lblPricemoq: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.productBackgoundView.clipsToBounds = true
        self.productBackgoundView.cornerRadius  = 6
    }

}


