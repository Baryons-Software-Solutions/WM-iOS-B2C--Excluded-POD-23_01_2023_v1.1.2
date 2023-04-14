//
//  CartProductListTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 24/11/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This CartProductListTblCell class used for create cart product table cell
import UIKit

class CartProductListTblCell: UITableViewCell {
    @IBOutlet weak var btnEditProduct: UIButton!
    @IBOutlet weak var lblPricePerUnit: UILabel!
    @IBOutlet weak var stackPlusMinus: UIStackView!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var btnProductNotes: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTotalProductPrice: UILabel!
    @IBOutlet weak var btnDeleteProduct: UIButton!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblProductCode: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnPLus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var stackReceivedQty: UIStackView!
    @IBOutlet weak var btnMinusReceivedQty: UIButton!
    @IBOutlet weak var lblReceivedQty: UILabel!
    @IBOutlet weak var btnPlusReceivedQty: UIButton!
    @IBOutlet weak var lblReceivedQtyTitle: UILabel!
    
    static let identifier: String = "CartProductListTblCell"
    static func nib() -> UINib {
        return UINib(nibName: "CartProductListTblCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgProduct.layer.cornerRadius = self.imgProduct.frame.height / 2
        self.imgProduct.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
