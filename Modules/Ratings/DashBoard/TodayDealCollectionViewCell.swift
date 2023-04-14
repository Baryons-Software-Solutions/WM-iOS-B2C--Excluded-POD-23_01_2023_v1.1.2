//
//  TodayDealCollectionViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This TodayDealCollectionViewCell class used for Todays deals collection cell
import UIKit

class TodayDealCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var todayDealImage: UIImageView!
    @IBOutlet weak var todayDealName: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backGroundView.clipsToBounds = true
        self.backGroundView.cornerRadius  = 6
    }

}

