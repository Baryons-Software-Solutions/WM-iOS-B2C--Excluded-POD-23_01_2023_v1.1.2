//
//  CartDetailsTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 31/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This CartDetailsTableViewCell class used for creating cart detail table cell
import UIKit

class CartDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage     : UIImageView!
    @IBOutlet weak var productName      : UILabel!
    @IBOutlet weak var prodctIDLabel    : UILabel!
    @IBOutlet weak var packagesNameLabel: UILabel!
    @IBOutlet weak var plusButton       : UIButton!
    @IBOutlet weak var addNotesButton   : UIButton!
    @IBOutlet weak var deleteButton     : UIButton!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var minusButton      : UIButton!
    @IBOutlet weak var productCostlabel : UILabel!
    @IBOutlet weak var notesLabel       : UILabel!
    @IBOutlet weak var editButton       : UIButton!
    
    var attrs = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10.0),
        NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "#617191"),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
    var addNotesButtonString = NSMutableAttributedString(string:"")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func addNotestitle(title:String){
        addNotesButtonString =  NSMutableAttributedString(string:"")
        addNotesButtonString.append(NSMutableAttributedString(string:title, attributes:attrs))
        addNotesButton.setAttributedTitle(addNotesButtonString, for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
