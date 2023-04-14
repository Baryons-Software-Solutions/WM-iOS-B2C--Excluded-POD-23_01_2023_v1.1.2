//
//  ReferFriendVC.swift
//  Watermelon-iOS_GIT
//
//  Created by admin on 12/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class ReferFriendVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var FilterBG: UIView!
    @IBOutlet weak var VwSuccess: UIView!
    @IBOutlet weak var btnSendInvite: UIButton!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var countryTitleLable: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var mobileTitleLabel: UILabel!
    @IBOutlet weak var nameAlertLabel: UILabel!
    @IBOutlet weak var emailAlertTitleLabel: UILabel!
    @IBOutlet weak var countryAlertTitleLable: UILabel!
    @IBOutlet weak var cityAlertTitleLabel: UILabel!
    @IBOutlet weak var mobileAlertTitleLabel: UILabel!
    @IBOutlet weak var successDescriptionLabel: UILabel!
    
    var pickerCountry           = UIPickerView()
    var pickerCity              = UIPickerView()
    var arrParams               = [ParameterResponse]()
    var arrCountry              = [ParameterResponse]()
    var arrCity                 = [ParameterResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wsParameters()
        FilterBG.isHidden = true
        nameTitleLabel.addRequiredAsterisk()
        emailTitleLabel.addRequiredAsterisk()
        countryTitleLable.addRequiredAsterisk()
        cityTitleLabel.addRequiredAsterisk()
        mobileTitleLabel.addRequiredAsterisk()
        VwSuccess.isHidden = true
        VwSuccess.cornerRadius = 10
        self.btnSendInvite.cornerRadius = 6
        hideAlert(bool: true)
        pickerCountry.dataSource = self
        pickerCountry.delegate = self
        txtCountry.inputView = pickerCountry
        self.pickerViewSet(pickerCountry, txtCountry, btnDoneSelector: #selector(self.donePickerCountry))
        pickerCity.dataSource = self
        pickerCity.delegate = self
        txtCity.inputView = pickerCity
        self.pickerViewSet(pickerCity, txtCity, btnDoneSelector: #selector(self.donePickerCity))
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func donePickerCity() {
        if txtCity.text == "" || arrCity.count == 1{
            txtCity.text = arrCity[0].value
        }
        self.txtCity.resignFirstResponder()
    }
    @objc func donePickerCountry() {
        if txtCountry.text == "" || arrCountry.count == 1{
            txtCountry.text = arrCountry[0].value
        }
        if txtCountry.text != "United Arab Emirates" {
            let alert = UIAlertController(title: "", message: "Sorry, we currently are not operating in your country. Please send an email to support@watermelon.market for enquiries.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.arrCity.removeAll()
        for i in self.arrParams{
            //print(i.dependentValue)
            if i.name
                == "city" && i.dependentValue == txtCountry.text{
                self.arrCity.append(i)
            }
        }
        self.pickerCity.reloadAllComponents()
        self.txtCountry.resignFirstResponder()
    }
    func hideAlert(bool:Bool){
        [self.countryAlertTitleLable,  self.emailAlertTitleLabel, self.mobileAlertTitleLabel,self.cityAlertTitleLabel,self.nameAlertLabel].forEach({ (label) in
            label?.isHidden = bool
            label?.textColor = .red
        })
        
        [self.txtName,  self.txtEmailAddress, self.txtCountry,self.txtCountry,self.txtPhoneNo].forEach({ (textfield) in
            textfield?.resignFirstResponder()
        })
    }
    func pickerViewSet(_ pickerViewName:UIPickerView, _ textField:UITextField, btnDoneSelector:Selector) {
        textField.inputView = pickerViewName
        pickerViewName.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let doneBtnAction = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDoneSelector)
        toolBar.setItems([doneBtnAction], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    //This method is used for vallidation purpose
    func validationReferFriend(){
        var nameError  = true
        var emailError = true
        var mobileNumberError = true
        var countryError = true
        var cityError = true
        
        if Validation().isEmpty(txtField: txtName.text!){
            nameAlertLabel.text = Constants.AlertMessage.firstName
            nameAlertLabel.isHidden  = false
            nameError = true
        }else  if !Validation().isValidateFirstName(fname: txtName.text!){
            nameAlertLabel.text = Constants.AlertMessage.validFirstName
            nameAlertLabel.isHidden  = false
            nameError = true
        }else{
            nameError = false
            nameAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtEmailAddress.text!){
            emailAlertTitleLabel.text = Constants.AlertMessage.email
            emailAlertTitleLabel.isHidden  = false
            emailError = true
        }else if !txtEmailAddress.text!.isEmail{
            emailAlertTitleLabel.text = Constants.AlertMessage.validEmail
            emailAlertTitleLabel.isHidden  = false
            emailError = true
        }else{
            emailError = false
            emailAlertTitleLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: txtPhoneNo.text!){
            mobileAlertTitleLabel.text = Constants.AlertMessage.mobileNumber
            mobileAlertTitleLabel.isHidden = false
            mobileNumberError = true
        }else if !(Validation().checkMinAndMaxLength(txtField: txtPhoneNo.text!, withMinLimit: 6, withMaxLimit: 12)){
            mobileAlertTitleLabel.text = Constants.AlertMessage.phoneCharacter
            mobileAlertTitleLabel.isHidden = false
            mobileNumberError = true
        }else{
            mobileNumberError = false
            mobileAlertTitleLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: txtCountry.text!){
            countryAlertTitleLable.text = Constants.AlertMessage.country
            countryAlertTitleLable.isHidden = false
            countryError = true
        }else {
            countryError = false
            countryAlertTitleLable.isHidden = true
        }
        if Validation().isEmpty(txtField: txtCity.text!){
            cityAlertTitleLabel.text = Constants.AlertMessage.city
            cityAlertTitleLabel.isHidden = false
            cityError = true
        }else {
            cityError = false
            cityAlertTitleLabel.isHidden = true
        }
        if nameError == false && emailError == false && mobileNumberError == false && countryError == false && cityError == false  {
            self.hideAlert(bool: true)
            self.wsRefer()
        }
        
    }
    //This method is used for get the data country and city
    func wsParameters() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        APICall().post(apiUrl: Constants.WebServiceURLs.ParametersURL, requestPARAMS: "", isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ParameterResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.arrParams = dicResponseData.data!
                            for i in self.arrParams{
                                if i.name == "country" {
                                    self.arrCountry.append(i)
                                }
                            }
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoking the refferls API
    func wsRefer(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            
            return
        }
        let postString = "name=\(txtName.text ?? "")&email=\(txtEmailAddress.text ?? "")&city=\(txtCity.text ?? "")&mobile=\(txtPhoneNo.text ?? "")&country=\(txtCountry.text ?? "")&type=\(0)"
        APICall().post(apiUrl: Constants.WebServiceURLs.referralsURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.successDescriptionLabel.text = dicResponseData.message
                        if dicResponseData.success == "1" {
                            self.FilterBG.isHidden = false
                            self.VwSuccess.isHidden = false
                        }else{
                            self.showCustomAlert(message: dicResponseData.message)
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
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSendInviteAct(_ sender: Any) {
        validationReferFriend()
    }
    @IBAction func BtnCountinue(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension ReferFriendVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == pickerCountry {
            return arrCountry.count
        } else if pickerView == pickerCity {
            return arrCity.count
        } else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCountry {
            return arrCountry[row].value
        } else if pickerView == pickerCity {
            return arrCity[row].value
        }  else{
            return ""
        }
    }
    //This methos is used for picking or selecting thr city 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerCountry{
            txtCountry.text = arrCountry[row].value
            selectCountryPicker()
        } else if pickerView == pickerCity {
            let cityName = arrCity[row].value
            if !cityName.isEmpty {
                txtCity.text = arrCity[row].value
            }
        }
    }
    //This methos is selecting the country
    func selectCountryPicker() {
        if txtCountry.text == "" || arrCountry.count == 1{
            txtCountry.text = arrCountry[0].value
        }
        if txtCountry.text != "United Arab Emirates" {
            let alert = UIAlertController(title: "", message: "Sorry, we currently are not operating in your country. Please send an email to support@watermelon.market for enquiries.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            txtCity.text = ""
        }
        self.arrCity.removeAll()
        for i in self.arrParams{
            //print(i.dependentValue)
            if i.name
                == "city" && i.dependentValue == txtCountry.text{
                self.arrCity.append(i)
            }
        }
        self.pickerCity.reloadAllComponents()
    }
}

