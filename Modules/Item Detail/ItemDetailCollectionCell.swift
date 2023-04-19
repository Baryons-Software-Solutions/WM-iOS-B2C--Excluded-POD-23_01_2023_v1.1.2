//
//  ItemDetailCollectionCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 23/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This ItemDetailCollectionCell class used for create Item details collection cell
import UIKit

class ItemDetailCollectionCell: UICollectionViewCell {
    
    var itemTapped:(() -> Void)?
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var vwReqAquote: UIView!
    @IBOutlet weak var stackAdd: UIStackView!
    @IBOutlet weak var btnRequestAquote: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnAdToCart: UIButton!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSupplierName: UILabel!
    @IBOutlet weak var txtQty: UITextField!
    @IBOutlet weak var lblMOQ: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var stackAddAndEditQty: UIStackView!
    @IBOutlet weak var btnAddWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackPlusMinus: UIStackView!
    @IBOutlet weak var btnAddOut: UIButton!
    
    var pickerOrderingOption  = UIPickerView()
    var arrOrderingOption = [PricingRange]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerOrderingOption.dataSource = self
        pickerOrderingOption.delegate = self
        lblName.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        lblName.addGestureRecognizer(tap)
    }
    func pickerViewSet(_ pickerViewName:UIPickerView, _ textField:UITextField, btnDoneSelector:Selector) {
        
        textField.inputView = pickerViewName
        pickerViewName.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        let doneBtnAction = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDoneSelector)
        toolBar.setItems([doneBtnAction], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func donePickerCountry() {
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer? = nil) {
        itemTapped?()
    }
}
// MARK: - Pickerview Methods

extension ItemDetailCollectionCell : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arrOrderingOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrOrderingOption[row].priceunit?.rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if let id = arrOrderingOption[row].pricemoq {
            print(id) // 0
            lblMOQ.text = "MOQ: \(id)"
        }
        lblPrice.text = "AED \(arrOrderingOption[row].promo?.rawValue ?? "")"
        
    }
}
