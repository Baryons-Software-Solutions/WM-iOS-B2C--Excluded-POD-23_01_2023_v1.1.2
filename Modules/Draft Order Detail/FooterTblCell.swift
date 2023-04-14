//
//  FooterTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 23/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This FooterTblCell class used for create footer table cell
import UIKit

class FooterTblCell: UITableViewCell {
    @IBOutlet weak var stackApproveReject: UIStackView!
    @IBOutlet weak var lblDeliveryError: UILabel!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnCalender: UIButton!
    @IBOutlet weak var btnDeliveryInfo: UIButton!
    @IBOutlet weak var txtScheduleDelivery: UITextField!
    @IBOutlet weak var vwScheduleDelivery: UIView!
    @IBOutlet weak var lblVatTitle: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var lblVatPrice: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var btnRejectOut: UIButton!
    @IBOutlet weak var btnApproveOut: UIButton!
    @IBOutlet weak var btnEditDeliveryNoteOut: UIButton!
    @IBOutlet weak var btnEditOrderNoteOut: UIButton!
    @IBOutlet weak var btnAddCustomProductOut: UIButton!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel! //Baryons-Surendra added on 31/01/22
    var orderId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnApproveOut.cornerRadius = 6
        btnRejectOut.cornerRadius = 6
        txtScheduleDelivery.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.lblDeliveryError.isHidden = true
        self.lblEmpty.isHidden = true
        
        
    }
    
    @IBAction func btnCalender(_ sender: Any) {
        txtScheduleDelivery.becomeFirstResponder()
    }
    // MARK: - PickerView Methods
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtScheduleDelivery.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            // dateFormatter.dateFormat = "dd-MMM-yyyy"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            self.txtScheduleDelivery.text = dateFormatter.string(from: datePicker.date)
            
        }
        self.txtScheduleDelivery.resignFirstResponder()
        wsDeliveryDateAvailability()
    }
    func wsDeliveryDateAvailability(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            Watermelon.showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        
        let postString = "draft_order_id=\(orderId)&delivery_date=\(txtScheduleDelivery.text ?? "")"
        APICall().post(apiUrl: Constants.WebServiceURLs.DraftDeliveryDateAvailabilityURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        Watermelon.showToast(message: dicResponseData.message)
                        if dicResponseData.success == "0" {
                            self.lblDeliveryError.text = dicResponseData.message
                            self.lblDeliveryError.isHidden = false
                            self.lblEmpty.isHidden = false
                            
                        } else {
                            self.lblDeliveryError.isHidden = true
                            self.lblEmpty.isHidden = true
                            
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    Watermelon.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
