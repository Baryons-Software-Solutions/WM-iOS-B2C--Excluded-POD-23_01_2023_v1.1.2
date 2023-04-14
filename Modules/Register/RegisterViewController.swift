//
//  RegisterViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 26/09/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import CountryPickerView

protocol TermsAcceptance{
    func termsaccepted(accpeted:Bool)
}

class RegisterViewController: UIViewController,CountryPickerViewDelegate,CountryPickerViewDataSource  {
    @IBOutlet weak var backButton              : UIButton!
    @IBOutlet weak var registerTitle           : UILabel!
    @IBOutlet weak var firstNameTextField      : UITextField!
    @IBOutlet weak var lastNameTextField       : UITextField!
    @IBOutlet weak var emailTextField          : UITextField!
    @IBOutlet weak var passwordTextFied        : UITextField!
    @IBOutlet weak var confirmTextField        : UITextField!
    @IBOutlet weak var dateofBirthTextField    : UITextField!
    @IBOutlet weak var countryCodeTextField    : UITextField!
    @IBOutlet weak var mobileNumberTextField   : UITextField!
    @IBOutlet weak var cityTextField           : UITextField!
    @IBOutlet weak var countryTextField        : UITextField!
    @IBOutlet weak var countryPicker: CountryPickerView!
    @IBOutlet weak var firstNameTitle   : UILabel!
    @IBOutlet weak var lastTimeTitle    : UILabel!
    @IBOutlet weak var emailTitle       : UILabel!
    @IBOutlet weak var passwordTitle    : UILabel!
    @IBOutlet weak var confirmPaswordTitle: UILabel!
    @IBOutlet weak var dateOfBirthTitle : UILabel!
    @IBOutlet weak var countryCodeTitle : UILabel!
    @IBOutlet weak var mobileNumberTitle: UILabel!
    @IBOutlet weak var countryTitle     : UILabel!
    @IBOutlet weak var cityTitle        : UILabel!
    @IBOutlet weak var addressTitle     : UILabel!
    @IBOutlet weak var firstNameAlertLabel  : UILabel!
    @IBOutlet weak var lastNameAlertlabel   : UILabel!
    @IBOutlet weak var emailAlertLabel      : UILabel!
    @IBOutlet weak var passwordAlertLabel   : UILabel!
    @IBOutlet weak var confirmPasswordAlert : UILabel!
    @IBOutlet weak var dateOfBirthAlert     : UILabel!
    @IBOutlet weak var cityAlert            : UILabel!
    @IBOutlet weak var countryAlert         : UILabel!
    @IBOutlet weak var mobileNumberAlert    : UILabel!
    @IBOutlet weak var addressEmailAlert    : UILabel!
    @IBOutlet weak var termaLabel: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var termsAlertLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var termsStackView: UIStackView!
    @IBOutlet weak var terms: UIButton!
    @IBOutlet weak var addressTextView      : UITextView!

    var arrParams = [ParameterResponse]()
    var arrCountry = [ParameterResponse]()
    var arrCity = [ParameterResponse]()
    var arrcity = ["Dubai", "Abu Dhabi", "Ajman", "Umm Al Quwain", "Sharjah", "Ras Al Khaimah", "Fujairah"] //commented for does not depend on country
    var countryCode = "+1"
    var pickerCountry = UIPickerView()
    var pickerCity = UIPickerView()
    var termsAccepted = false
    var termsDelegate : TermsAcceptance?

    override func viewDidLoad() {
        super.viewDidLoad()
        termsStackView.isHidden = true
        wsParameters()
        uiElementsSetup()
    }
    func uiElementsSetup(){
        self.hideAlert(bool: true)
        self.firstNameAlertLabel.textColor   = .red
        self.lastNameAlertlabel.textColor    = .red
        self.emailAlertLabel.textColor       = .red
        self.passwordAlertLabel.textColor    = .red
        self.confirmPasswordAlert.textColor  = .red
        self.dateOfBirthAlert.textColor      = .red
        self.cityAlert.textColor             = .red
        self.countryAlert.textColor          = .red
        self.mobileNumberAlert.textColor     = .red
        self.addressEmailAlert.textColor     = .red
        self.termsAlertLabel.textColor       = .red
        self.termsAlertLabel.text = "Please click on Terms & Conditions link"
        self.countryTextField.text = "United Arab Emirates"
        self.cityTextField.text = "Dubai"
        self.firstNameTitle.addRequiredAsterisk()
        self.lastTimeTitle.addRequiredAsterisk()
        self.emailTitle.addRequiredAsterisk()
        self.passwordTitle.addRequiredAsterisk()
        self.confirmPaswordTitle.addRequiredAsterisk()
        self.dateOfBirthTitle.addRequiredAsterisk()
        self.mobileNumberTitle.addRequiredAsterisk()
        self.countryTitle.addRequiredAsterisk()
        self.cityTitle.addRequiredAsterisk()
        self.addressTitle.addRequiredAsterisk()
        self.passwordTextFied.isSecureTextEntry = true
        self.confirmTextField.isSecureTextEntry = true
        passwordTextFied.enablePasswordToggle()
        confirmTextField.enablePasswordToggle()
        self.addressTextView.text = ""
        self.addressTextView.layer.borderColor      = UIColor.lightGray.cgColor
        self.addressTextView.layer.borderWidth      = 0.3
        self.addressTextView.delegate               = self
        self.addressTextView.layer.cornerRadius     = 5
        countryCodeTextField.alpha = 0
        countryPicker.showCountryCodeInView = false
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.setCountryByPhoneCode("+971")
        pickerCountry.dataSource = self
        pickerCountry.delegate = self
        countryTextField.inputView = pickerCountry
        self.pickerViewSet(pickerCountry, countryTextField, btnDoneSelector: #selector(self.donePickerCountry))
        pickerCity.dataSource = self
        pickerCity.delegate = self
        cityTextField.inputView = pickerCity
        self.pickerViewSet(pickerCity, cityTextField, btnDoneSelector: #selector(self.donePickerCity))
        checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        let strTermAndCondition = "I Accept The Terms & Conditions"
        let attributedString = NSMutableAttributedString(string: strTermAndCondition, attributes: [
            .font: self.termaLabel.font!,
            .foregroundColor: UIColor.black
        ])
        let range1 = (strTermAndCondition as NSString).range(of: "Terms & Conditions")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hexFromString: "#EC187B"), range: range1)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font(name: .robotoMedium, size: 13.0), range: range1)
        termaLabel.attributedText = attributedString
        termaLabel.addTapGesture {[unowned self] (gesture) in
            let text = self.termaLabel.text ?? ""
            let range1 = (text as NSString).range(of: "Terms & Conditions")
            if gesture.didTapAttributedTextInLabel(label: self.termaLabel, inRange: range1) {
                if let objTermsNconditionsVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as? PrivacyPolicyVC {
                    objTermsNconditionsVC.termsDelegate = self
                    objTermsNconditionsVC.strTitle = "Terms & Conditions"
                    self.navigationController?.pushViewController(objTermsNconditionsVC, animated: true)
                }
            }
        }
    }
    
    @objc func checkboxButtonTapped() {
            checkboxButton.isSelected = !checkboxButton.isSelected
            updateUI()
    }
    //This is used for update the terms and conditions buttons and label color
    func updateUI() {
        if checkboxButton.isSelected {
            self.termsAlertLabel.textColor = hexStringToUIColor(hex: "#36B152")
            self.termsButton.setImage(UIImage(named: "icons8-approval"), for: .normal)
            self.termsAlertLabel.text = "You have accepted Terms & Conditions"
            // Update the UI to show that the checkbox is checked
            checkboxButton.setImage(UIImage(named: "ic_checkbox"), for: .normal)
            self.termsAccepted = true
            self.termsDelegate?.termsaccepted(accpeted: true)
        } else {
            self.termsButton.setImage(UIImage(named: "ios-close-circle-outline"), for: .normal)
            self.termsAlertLabel.textColor = .red
            self.termsAlertLabel.text = "Please accept Terms & Conditions"
            // Update the UI to show that the checkbox is not checked
            checkboxButton.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            self.termsDelegate?.termsaccepted(accpeted: false)
        }
    }
        
    
    func hideAlert(bool:Bool){
        [self.firstNameAlertLabel,  self.lastNameAlertlabel, self.emailAlertLabel,self.passwordAlertLabel,self.confirmPasswordAlert,  self.dateOfBirthAlert, self.cityAlert,self.countryAlert,self.mobileNumberAlert,self.addressEmailAlert].forEach({ (label) in
            label?.isHidden = bool
        })
        [self.firstNameTextField,  self.lastNameTextField, self.emailTextField,self.passwordTextFied,self.confirmPasswordAlert,  /*self.dateofBirthTextField*/ self.countryCodeTextField,self.mobileNumberTextField,self.cityTextField,self.countryTextField].forEach({ (textfield) in
            textfield?.resignFirstResponder()
        })
        addressTextView.resignFirstResponder()
    }
    @objc func donePickerCity() {
        if cityTextField.text == "" || arrCity.count == 1{
            cityTextField.text = arrCity[0].value
        }
        self.cityTextField.resignFirstResponder()
    }
    @objc func donePickerCountry() {
        if countryTextField.text == "" || arrCountry.count == 1{
            countryTextField.text = arrCountry[0].value
        }
        if countryTextField.text != "United Arab Emirates" {
            let alert = UIAlertController(title: "", message: "Sorry, we currently are not operating in your country. Please send an email to support@watermelon.market for enquiries.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.arrCity.removeAll()
        for i in self.arrParams{
            //print(i.dependentValue)
            if i.name
                == "city" && i.dependentValue == countryTextField.text{
                self.arrCity.append(i)
            }
        }
        self.pickerCity.reloadAllComponents()
        self.countryTextField.resignFirstResponder()
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
    @IBAction func submitAction(_ sender: Any) {
        validationLogin()
    }
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: CPVCountry){
        DispatchQueue.main.async {
            self.countryCodeTextField.text = country.name
            self.countryCode = country.phoneCode
        }
    }
}
extension RegisterViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == pickerCountry {
            return arrCountry.count
        } else if pickerView == pickerCity {
            return arrcity.count // //commented for does not depend on country
        } else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerCountry {
            return arrCountry[row].value
        } else if pickerView == pickerCity {
            return arrcity[row]/*.value*/ //commented for does not depend on country
        }  else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerCountry{
            countryTextField.text = arrCountry[row].value
            selectCountryPicker()
        } else if pickerView == pickerCity {
            let cityName = arrcity[row]/*.value*/ //commented for does not depend on country
            if !cityName.isEmpty {
                cityTextField.text = arrcity[row]/*.value*/ //commented for does not depend on country
            }
        }
    }
    func selectCountryPicker() {
        if countryTextField.text == "" || arrCountry.count == 1{
            countryTextField.text = arrCountry[0].value
        }
        if countryTextField.text != "United Arab Emirates" {
            let alert = UIAlertController(title: "", message: "Sorry, we currently are not operating in your country. Please send an email to support@watermelon.market for enquiries.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            cityTextField.text = "Dubai"
        }
        self.arrCity.removeAll()
        for i in self.arrParams{
            //print(i.dependentValue)
            if i.name
                == "city" && i.dependentValue == countryTextField.text{
                self.arrCity.append(i)
            }
        }
        self.pickerCity.reloadAllComponents()
    }
}
extension RegisterViewController{
    //This method is used for validation purpose
func validationLogin(){
        var fnamerror  = true
        var lnameError = true
        var emailError = true
        var passwordError = true
        var confirmPassswordError = true
        var cityError = true
        var countryError = true
        var mobileError = true
        var addressError = true
        var termsError = true
        
        if Validation().isEmpty(txtField: firstNameTextField.text!){
            firstNameAlertLabel.text = Constants.AlertMessage.firstName
            firstNameAlertLabel.isHidden  = false
            fnamerror = true
        }else  if !Validation().isValidateFirstName(fname: firstNameTextField.text!){
            firstNameAlertLabel.text = Constants.AlertMessage.validFirstName
            firstNameAlertLabel.isHidden  = false
            fnamerror = true
        }else{
            fnamerror = false
            firstNameAlertLabel.isHidden = true
        }
        
        if Validation().isEmpty(txtField: lastNameTextField.text!){
            lastNameAlertlabel.text = Constants.AlertMessage.validLastName
            lastNameAlertlabel.isHidden  = false
            lnameError = true
        }else  if !Validation().isValidateFirstName(fname: lastNameTextField.text!){
            lastNameAlertlabel.text = Constants.AlertMessage.validLastName
            lastNameAlertlabel.isHidden  = false
            lnameError = true
        }else{
            lnameError = false
            lastNameAlertlabel.isHidden = true
        }
        
        
        if Validation().isEmpty(txtField: emailTextField.text!){
            emailAlertLabel.text = Constants.AlertMessage.email
            emailAlertLabel.isHidden  = false
            emailError = true
        }else if !emailTextField.text!.isEmail{
            emailAlertLabel.text = Constants.AlertMessage.validEmail
            emailAlertLabel.isHidden  = false
            emailError = true
        }else{
            emailError = false
            emailAlertLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: passwordTextFied.text!){
            passwordAlertLabel.text = Constants.AlertMessage.password
            passwordAlertLabel.isHidden = false
            passwordError = true
            passwordTextFied.borderWidth = 0
            confirmTextField.borderWidth = 0
        }else {
            passwordError = false
            passwordAlertLabel.isHidden = true
            passwordTextFied.borderWidth = 0
            confirmTextField.borderWidth = 0
        }
        
        
        if Validation().isEmpty(txtField: confirmTextField.text!){
            confirmPasswordAlert.text = Constants.AlertMessage.confirmPassword
            confirmPasswordAlert.isHidden = false
            confirmPassswordError = true
            passwordTextFied.borderWidth = 0
            confirmTextField.borderWidth = 0
        } else if (passwordTextFied.text != confirmTextField.text) {
            confirmPasswordAlert.isHidden = false
            confirmPassswordError = true
            confirmPasswordAlert.text = Constants.AlertMessage.SamePassword
            passwordTextFied.borderWidth = 1
            confirmTextField.borderWidth = 1
            passwordTextFied.borderColor = .red
            confirmTextField.borderColor = .red
        }else{
            confirmPassswordError = false
            confirmPasswordAlert.isHidden = true
            passwordTextFied.borderWidth = 0
            confirmTextField.borderWidth = 0
        }
        
        if termsAccepted == false{
            self.termsStackView.isHidden = false
        }
        if Validation().isEmpty(txtField: mobileNumberTextField.text!){
            mobileNumberAlert.text = Constants.AlertMessage.mobileNumber
            mobileNumberAlert.isHidden = false
            mobileError = true
        }else if !(Validation().checkMinAndMaxLength(txtField: mobileNumberTextField.text!, withMinLimit: 6, withMaxLimit: 12)){
            mobileNumberAlert.text = Constants.AlertMessage.phoneCharacter
            mobileNumberAlert.isHidden = false
            mobileError = true
        }else{
            mobileError = false
            mobileNumberAlert.isHidden = true
        }
        if let addressText = self.addressTextView.text{
            if addressText.trim().isEmpty{
                addressEmailAlert.text = Constants.AlertMessage.address
                addressEmailAlert.isHidden = false
                addressError = true
            }else{
                addressError = false
                addressEmailAlert.isHidden = true
            }
        }else{
            addressError = false
            addressEmailAlert.isHidden = true
        }
        
        if Validation().isEmpty(txtField: countryTextField.text!){
            countryAlert.text = Constants.AlertMessage.country
            countryAlert.isHidden = false
            countryError = true
        }else {
            countryError = false
            countryAlert.isHidden = true
        }
        
        if Validation().isEmpty(txtField: cityTextField.text!){
            cityAlert.text = Constants.AlertMessage.city
            cityAlert.isHidden = false
            cityError = true
        }else {
            cityError = false
            cityAlert.isHidden = true
        }
        if fnamerror == false && lnameError == false && emailError == false && passwordError == false && confirmPassswordError == false && cityError == false && countryError == false && mobileError == false && addressError == false && termsAccepted == true{
            self.hideAlert(bool: true)
            self.uploadValidated()
        }
        
    }
    // This method is used for invoke the parameter API
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
    // This method is used for invoke the register buyer  API
    func uploadValidated(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message:Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramPassword] = passwordTextFied.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramEmail] = emailTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAddress] = addressTextView.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCpassword] = confirmTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountry] = countryCodeTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCity] = cityTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramFirstname] = firstNameTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramLastname] = lastNameTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramCountryCode] = countryCode as AnyObject
        paramDic [Constants.WebServiceParameter.paramMobileNo] = mobileNumberTextField.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramAdminRights] = 1 as AnyObject
        paramDic [Constants.WebServiceParameter.dob] = "" as AnyObject
        paramDic ["email_notification"] = 1 as AnyObject
        paramDic ["phone_notification"] = 1 as AnyObject
        paramDic ["status"] = 0 as AnyObject
        paramDic ["buyer_type"] = "Individual" as AnyObject
        let arrFiles = Array<Dictionary<String, Any>>()
        let strUrl = Constants.WebServiceURLs.registerBuyerURL
        print(strUrl)
        print(paramDic)
        paramDic [Constants.WebServiceParameter.paramPlatform] = "iPhone" as AnyObject
        MultiPart().callPostWebService1(strUrl, parameters: paramDic, filePathArr: arrFiles, model: RegisterResponseModel.self) { (success, responseData) in
            if success ,let dicResponseData = responseData as? RegisterResponseModel {
                if (success) {
                    if let responseData = responseData as? RegisterResponseModel {
                        //success = true = 1 , unsuccess = false =0
                        if dicResponseData.success == "1" {
                            if let objLoginVC = mainStoryboard.instantiateViewController(withIdentifier: "Loginscreen") as? Loginscreen {
                              objLoginVC.modalPresentationStyle = .fullScreen
                              objLoginVC.customePopUpDelegate = self
                              self.present(objLoginVC, animated: true, completion: nil)
                            }
                        }else {
                            self.showCustomAlert(message:dicResponseData.message ,isSuccessResponse: false)
                        
                        }
                    } else {
                        self.showCustomAlert(message:responseData?.message ?? "")
    
                    }
                }
            } else {
                self.showCustomAlert(message:responseData?.message ?? "", isSuccessResponse: false)
                 //  self.showToast(message:responseData?.message ?? "")
            }
        }
    }
}
extension RegisterViewController{
    
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        if textView.text.count == 0 &&  textView.text == " "{
            return false
        }
        if textView.text.isEmpty {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        if text == "\n"{
            self.addressTextView.resignFirstResponder()
        }
        return numberOfChars < 501
    }
    
}

extension RegisterViewController : SuccessPopupDelegate {
    func globalButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension UILabel {
    func addRequiredAsterisk()  {
          let asterisk =  UILabel()
          let string = ("*" as NSString).range(of: "*")
          asterisk.frame =  CGRect.init(x: self.frame.size.width+2, y: self.frame.size.height/4, width: 10, height: 10)
          let redAst = NSMutableAttributedString(string: "*", attributes: [.foregroundColor: UIColor.red])
          redAst.addAttribute(NSAttributedString.Key.font,value:UIFont.systemFont(ofSize: 16, weight: .regular), range: string)

          asterisk.attributedText = redAst
          self.addSubview(asterisk)
      }
}


extension String{
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
 //This method is used for create the terms and condtion label colour, button and etc
extension RegisterViewController : TermsAcceptance{
    func termsaccepted(accpeted: Bool) {
        if accpeted{
            self.termsAccepted = true
            self.termsAlertLabel.textColor = hexStringToUIColor(hex: "#36B152")
            self.termsStackView.isHidden = false
            self.termsButton.setImage(UIImage(named: "icons8-approval"), for: .normal)
            self.termsAlertLabel.text = "You have accepted Terms & Conditions"
        }else{
            self.termsButton.setImage(UIImage(named: "ios-close-circle-outline"), for: .normal)
            self.termsAccepted = false
            self.termsAlertLabel.textColor = .red
            self.termsStackView.isHidden = false
            self.termsAlertLabel.text = "Please accept Terms & Conditions"
        }
    }
}
