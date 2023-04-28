//
//  NeedHelpVC.swift
//  Watermelon-iOS_GIT
//
//  Created by admin on 11/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class NeedHelpVC: UIViewController {
    
    
    @IBOutlet weak var submitbtn: UIButton!
    @IBOutlet weak var txtFullName        : UITextField!
    @IBOutlet weak var txtEmailID         : UITextField!
    @IBOutlet weak var txtMobileNo        : UITextField!
    @IBOutlet weak var txtSubject         : UITextField!
    @IBOutlet weak var txtCategory        : UITextField!
    @IBOutlet weak var txtDescription     : UITextView!
    @IBOutlet weak var FilterBG: UIView!
    @IBOutlet weak var VwSuccess: UIView!
    @IBOutlet weak var nameTitleLabel     : UILabel!
    @IBOutlet weak var emailtitleLabel    : UILabel!
    @IBOutlet weak var mobileNumberTitle  : UILabel!
    @IBOutlet weak var subjectTitleLabel    : UILabel!
    @IBOutlet weak var categoryTitleLabel   : UILabel!
    @IBOutlet weak var descriptionTitleLable: UILabel!
    @IBOutlet weak var nameAlertLabel       : UILabel!
    @IBOutlet weak var emailAlertLabel      : UILabel!
    @IBOutlet weak var mobileAlertlabel     : UILabel!
    @IBOutlet weak var subjectAlertLabel    : UILabel!
    @IBOutlet weak var categoryAlertlabel   : UILabel!
    @IBOutlet weak var descriptionAlertLabel: UILabel!
    @IBOutlet weak var BtnCountinue: UIButton!
    
    var pickerCategory = UIPickerView()
    var arrCategory = ["Payments","Order Placed","Orders","Refund"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FilterBG.isHidden           = true
        VwSuccess.isHidden          = true
        BtnCountinue.cornerRadius   = 10
        submitbtn.cornerRadius      = 10
        VwSuccess.cornerRadius      = 10
        uiElementsSetup()
        pickerCategory.dataSource   = self
        pickerCategory.delegate     = self
        txtCategory.inputView   = pickerCategory
        self.pickerViewSet(pickerCategory, txtCategory, btnDoneSelector: #selector(NeedHelpVC.donepickerCategory))
    }
    func uiElementsSetup(){
        hideAlert(bool: true)
        self.txtDescription.text = ""
        self.txtDescription.layer.borderColor      = UIColor.lightGray.cgColor
        self.txtDescription.layer.borderWidth      = 0.3
        self.txtDescription.delegate               = self
        self.txtDescription.layer.cornerRadius     = 5
    }
    func hideAlert(bool:Bool){
        [self.nameAlertLabel,  self.emailAlertLabel, self.mobileAlertlabel,self.subjectAlertLabel,self.categoryAlertlabel,  self.descriptionAlertLabel, ].forEach({ (label) in
            label?.isHidden = bool
            label?.textColor = .red
        })
        [self.txtFullName,  self.txtEmailID, self.txtMobileNo,self.txtSubject,self.txtCategory].forEach({ (textfield) in
            textfield?.resignFirstResponder()
        })
        txtDescription.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    //This method is used for vallidation purpose
    func validationNeedHelp(){
        var nameError  = true
        var emailError = true
        var mobileNumberError = true
        var subjectError = true
        var categoryerror = true
        var descriptionError = true
        
        if Validation().isEmpty(txtField: txtFullName.text!){
            nameAlertLabel.text = Constants.AlertMessage.firstName
            nameAlertLabel.isHidden  = false
            nameError = true
        }else  if !Validation().isValidateFirstName(fname: txtFullName.text!){
            nameAlertLabel.text = Constants.AlertMessage.validFirstName
            nameAlertLabel.isHidden  = false
            nameError = true
        }else{
            nameError = false
            nameAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtEmailID.text!){
            emailAlertLabel.text = Constants.AlertMessage.email
            emailAlertLabel.isHidden  = false
            emailError = true
        }else if !txtEmailID.text!.isEmail{
            emailAlertLabel.text = Constants.AlertMessage.validEmail
            emailAlertLabel.isHidden  = false
            emailError = true
        }else{
            emailError = false
            emailAlertLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: txtMobileNo.text!){
            mobileAlertlabel.text = Constants.AlertMessage.mobileNumber
            mobileAlertlabel.isHidden = false
            mobileNumberError = true
        }else if !(Validation().checkMinAndMaxLength(txtField: txtMobileNo.text!, withMinLimit: 6, withMaxLimit: 12)){
            mobileAlertlabel.text = Constants.AlertMessage.phoneCharacter
            mobileAlertlabel.isHidden = false
            mobileNumberError = true
        }else{
            mobileNumberError = false
            mobileAlertlabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtSubject.text!){
            subjectAlertLabel.text = "Subject is required"
            subjectAlertLabel.isHidden = false
            subjectError = true
        }else {
            subjectError = false
            subjectAlertLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: txtCategory.text!){
            categoryAlertlabel.text = "Category is required"
            categoryAlertlabel.isHidden = false
            categoryerror = true
        }else {
            categoryerror = false
            categoryAlertlabel.isHidden = true
        }
        
        if let addressText = self.txtDescription.text{
            if addressText.trim().isEmpty{
                descriptionAlertLabel.text = Constants.AlertMessage.desc
                descriptionAlertLabel.isHidden = false
                descriptionError = true
            }else{
                descriptionError = false
                descriptionAlertLabel.isHidden = true
            }
        }else{
            descriptionError = false
            descriptionAlertLabel.isHidden = true
        }
        if nameError == false && emailError == false && mobileNumberError == false && subjectError == false && categoryerror == false && descriptionError == false {
            self.hideAlert(bool: true)
            self.wsNeedHelp()
        }
    }
    // This method is used to invoke for Need help API
    func wsNeedHelp(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "name=\(txtFullName.text ?? "")&email=\(txtEmailID.text ?? "")&mobile=\(txtMobileNo.text ?? "")&subject=\(txtSubject.text ?? "")&category=\(txtCategory.text ?? "")&description=\(txtDescription.text!)"
        APICall().post(apiUrl: Constants.WebServiceURLs.NeedHelpURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        if dicResponseData.success == "1" {
                            print("")
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    
    @objc func donepickerCategory() {
        if txtCategory.text == "" {
            txtCategory.text =  arrCategory[0]
        }
        self.txtCategory.resignFirstResponder()
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitAct(_ sender: Any) {
        validationNeedHelp()
    }
    @IBAction func BtnCountinue(_ sender: Any) {
        let MenuNewViewControllerVC = mainStoryboard.instantiateViewController(withIdentifier: "MenuNewViewController") as! MenuNewViewController
        self.tabBarController?.tabBar.isHidden = false
        self.present(MenuNewViewControllerVC, animated: true)
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
}
//This method is used for picking the country , are and city 
extension NeedHelpVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerCategory{
            return arrCategory.count
        } else {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCategory{
            return (arrCategory[row])
        } else {
            return arrCategory[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == pickerCategory{
            txtCategory.text = (arrCategory[row])
        } else {
            return
        }
    }
}

