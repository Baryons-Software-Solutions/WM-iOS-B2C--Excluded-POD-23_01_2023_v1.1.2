//
//  PlaceOrderFooterTblCell.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 24/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
//This PlaceOrderFooterTblCell class used for create placed order footer table cell
import UIKit

class PlaceOrderFooterTblCell: UITableViewCell {
    @IBOutlet weak var lblDeliveryError: UILabel!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var vwScheduleDelivery: UIView!
    @IBOutlet weak var stackStatus: UIStackView!
    @IBOutlet weak var lblVatTitle: UILabel!
    
    @IBOutlet weak var btnDeliveryInfo: UIButton!
    @IBOutlet weak var btnCalender: UIButton!
    @IBOutlet weak var txtScheduleDelivery: UITextField!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var lblVatPrice: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var btnAddSpecialProductOut: UIButton!
    @IBOutlet weak var btnEditDeliveryNoteOut: UIButton!
    @IBOutlet weak var btnEditOrderNoteOut: UIButton!
    @IBOutlet weak var stackChangeStatusForSupplier: UIStackView!
    @IBOutlet weak var btnAcceptOrderSupplierOut: UIButton!
    @IBOutlet weak var btnRejectOrderSupplierOut: UIButton!
    @IBOutlet weak var stackAcceptRejectOrderSupplier: UIStackView!
    @IBOutlet weak var btnGenerateInvoiceOut: UIButton!
    @IBOutlet weak var txtChangeStatus: UITextField!
    @IBOutlet weak var vwChangeStatus: UIView!
    @IBOutlet weak var btnCloseOrderOut: UIButton!
    @IBOutlet weak var lblPaymentStatus: UILabel! //Baryons-Surendra added on 31/01/22
    
    @IBOutlet weak var btnMarkAsCompleted: UIButton!
    @IBOutlet weak var btnOrderReturned: UIButton!
    @IBOutlet weak var btnSubmitStatus: UIButton!
    var orderId = ""
    var pickerStatus = UIPickerView()
    var titlesDic : [[String:Any]] = []
    static func nib() -> UINib {
        return UINib(nibName: "PlaceOrderFooterTblCell", bundle: nil)
    }
    static let identifier: String = "PlaceOrderFooterTblCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnGenerateInvoiceOut.cornerRadius =  6
        DispatchQueue.main.async {
            self.btnMarkAsCompleted.cornerRadius =  6
            self.btnOrderReturned.cornerRadius =  6
        }
        
        titlesDic.append(["Title": "Processing"  , "id" : "31" ])
        titlesDic.append(["Title": "Shipped"  , "id" : "32"])
        titlesDic.append(["Title": "Delivered"  , "id" : "33"  ])
        txtScheduleDelivery.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.btnAcceptOrderSupplierOut.cornerRadius = 6
        self.btnRejectOrderSupplierOut.cornerRadius = 6
        self.btnCloseOrderOut.cornerRadius = 6
        self.lblDeliveryError.isHidden = true
        self.lblEmpty.isHidden = true
        pickerStatus.dataSource = self
        pickerStatus.delegate = self
        pickerStatus.reloadAllComponents()
        txtChangeStatus.inputView = pickerStatus
        self.pickerViewSet(pickerStatus, txtChangeStatus, btnDoneSelector: #selector(PlaceOrderFooterTblCell.donePickerStatus))
        // Initialization code
    }
    // MARK: - PickerView Methods
    
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
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtScheduleDelivery.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            //dateFormatter.dateFormat = "dd-MMM-yyyy"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.txtScheduleDelivery.text = dateFormatter.string(from: datePicker.date)
            
        }
        self.txtScheduleDelivery.resignFirstResponder()
        wsUpdateDeliveryDate()
    }
    @objc func donePickerStatus() {
        if txtChangeStatus.text == "" {
            let objCommonModel = CommonModel(data : titlesDic[0] as NSDictionary)
            txtChangeStatus.text = objCommonModel.strTitle
            txtChangeStatus.selectedID = objCommonModel.strID
            // strStatusAcceptReject = objCommonModel.strID
            
        }
        self.txtChangeStatus.resignFirstResponder()
    }
    func wsUpdateDeliveryDate(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            Watermelon.showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        
        let postString = "order_id=\(orderId)&delivery_date=\(txtScheduleDelivery.text ?? "")"
        APICall().post(apiUrl: Constants.WebServiceURLs.UpdateDeliveryDateURL, requestPARAMS: postString, isTimeOut: false){
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
    
    @IBAction func btnCalenderAct(_ sender: Any) {
        txtScheduleDelivery.becomeFirstResponder()
        
    }
}
// MARK: - Pickerview Methods

extension PlaceOrderFooterTblCell : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.titlesDic.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let objCommonModel = CommonModel(data : titlesDic[row] as NSDictionary)
        return objCommonModel.strTitle
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        let objCommonModel = CommonModel(data : titlesDic[row] as NSDictionary)
        txtChangeStatus.text = objCommonModel.strTitle
        txtChangeStatus.selectedID = objCommonModel.strID
        // strStatusAcceptReject = objCommonModel.strID
        
    }
}
