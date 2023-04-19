//
//  LoginVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 25/08/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import SystemConfiguration
import LGSideMenuController
import GoogleSignIn
import GoogleSignInSwift
import DLRadioButton

class LoginVC: UIViewController {
    
    @IBOutlet weak var vwBlur         : UIView!
    @IBOutlet weak var txtPassword    : UITextField!
    @IBOutlet weak var txtEmail       : UITextField!
    @IBOutlet weak var btnSignInOut   : UIButton!
    @IBOutlet weak var lblDontHaveAccountText: UILabel!
    @IBOutlet weak var versionlabel: UILabel!
    @IBOutlet weak var passwordAlertLabel: UILabel!
    @IBOutlet weak var emailAlertLabel   : UILabel!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var btnLogIn: UIButton!
    var button = UIButton(type: .custom)
    var iconClick = true
    var emailAddress = ""
    var fullName = ""
    var activeTextField : UITextField?
    var weightage = 80
    let signInConfig = GIDConfiguration.init(clientID: "367054230747-2looppk43o4ccofe6mbgeqqpt5q1onmt.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionlabel.text = appVersion
        btnLogIn.cornerRadius = 6
        self.passwordAlertLabel.textColor = .red
        self.emailAlertLabel.textColor    = .red
        self.hideUnhideAlerts(bool: true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        txtPassword.isSecureTextEntry = true
        txtPassword.enablePasswordToggle()
        let strPopup = "Don’t have an account? Sign Up"
        let attributedStringPopup = NSMutableAttributedString(string: strPopup, attributes: [
            .font: self.lblDontHaveAccountText.font!,
            .foregroundColor: hexStringToUIColor(hex: "#7B868A")
        ])
        let rangePopUp2 = (strPopup as NSString).range(of: "Don’t have an account? Sign Up")
        attributedStringPopup.addAttribute(NSAttributedString.Key.font, value: font(name: .robotoRegular, size: 15.0), range: rangePopUp2)
        let rangePopUpClick = (strPopup as NSString).range(of: "Sign Up")
        attributedStringPopup.addAttribute(NSAttributedString.Key.font, value: font(name: .robotoRegular, size: 15.0), range: rangePopUpClick)
        attributedStringPopup.addAttribute(NSAttributedString.Key.foregroundColor, value:  hexStringToUIColor(hex: "#EC187B"), range: rangePopUpClick)
        lblDontHaveAccountText.attributedText = attributedStringPopup
        lblDontHaveAccountText.addTapGesture {[unowned self] (gesture) in
            if let objRegisterVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
                USERDEFAULTS.setDataForKey("1", .user_type)
                self.navigationController?.pushViewController(objRegisterVC, animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }
    //MARK: - Login alidation check
    func hideUnhideAlerts(bool: Bool){
        self.passwordAlertLabel.isHidden = bool
        self.emailAlertLabel.isHidden    = bool
    }
    //This method is used for validation purpose
    func validationLogin(){
        var emailError = true
        var passwordError = true
        if Validation().isEmpty(txtField: txtEmail.text!){
            emailAlertLabel.text = Constants.AlertMessage.email
            emailAlertLabel.isHidden  = false
            emailError = true
        }else if !txtEmail.text!.isEmail{
            emailAlertLabel.text = Constants.AlertMessage.validEmail
            emailAlertLabel.isHidden  = false
            emailError = true
        }else{
            emailError = false
            emailAlertLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: txtPassword.text!){
            passwordAlertLabel.text = Constants.AlertMessage.password
            passwordAlertLabel.isHidden = false
            passwordError = true
        }else {
            passwordError = false
            passwordAlertLabel.isHidden = true
        }
        if emailError == false && passwordError == false{
            wsLogin()
            self.txtEmail.resignFirstResponder()
            self.txtPassword.resignFirstResponder()
            self.hideUnhideAlerts(bool: true)
        }
        
    }
    //This method is used for invoke the guestLogin
    func wsGuestLogin(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        USERDEFAULTS.setDataForKey(/*arrLoginData[0].firstname ?? ""*/ "Guest", .user_first_name)
        let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
        dashboardvc?.selectedIndex = 0
        Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
    }
    //This method is used for invoke the google login API
    func wsGoogleLogin(email:String, name:String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "email=\(email)&name=\(name)&social_media_type=1&platform=mobile&login_user_type=b2c&buyer_type=Individual&login_type=2"
        var arrLoginData = [LoginResponse]()
        print(postString)
        print(arrLoginData)
        print(email)
        print(name)
        APICall().post(apiUrl: Constants.WebServiceURLs.googleLoginURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(LoginResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            if let data = dicResponseData.data {
                                
                                arrLoginData = [data]
                                print(arrLoginData)
                                self.showCustomAlert(message:dicResponseData.message ?? "")
                                USERDEFAULTS.setDataForKey("true", .isLogin)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].token ?? "" , .accessToken)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].email ?? "" , .user_email)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].firstname ?? "" , .user_first_name)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].middlename ?? "" , .user_middle_name)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].lastname ?? "" , .user_last_name)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].id ?? "" , .userID)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].userTypeID ?? "" , .user_type_id)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].mobileNoCode ?? "" , .user_mobile_number_code)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].phoneNumber ?? "" , .user_phone)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].profile ?? "" , .userPic)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].designation ?? "" , .designation)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].notified ?? "" , .getNotified)
                                var buyerType: String = ""
                                //                                if arrLoginData[0].userType == 1 {
                                //                                    if let buyerTypeDetails = arrLoginData[0].buyerType?.lowercased() {
                                //                                        buyerType = buyerTypeDetails
                                //                                    } else {
                                //                                        buyerType = "company"
                                //                                    }
                                //                                }
                                var address: [String: String] = [:]
                                address["address"] = arrLoginData[0].address ?? ""
                                address["area"] = arrLoginData[0].area ?? ""
                                address["city"] = arrLoginData[0].city ?? ""
                                address["country"] = arrLoginData[0].country ?? ""
                                address["state"] = arrLoginData[0].state ?? ""
                                address["pincode"] = arrLoginData[0].pincode ?? ""
                                
                                var billingAddress: [String: String] = [:]
                                billingAddress["billingAddress"] = arrLoginData[0].billingAddress ?? ""
                                billingAddress["billingArea"] = arrLoginData[0].billingArea ?? ""
                                billingAddress["billingCity"] = arrLoginData[0].billingCity ?? ""
                                billingAddress["billingCountry"] = arrLoginData[0].billingCountry ?? ""
                                billingAddress["billingState"] = arrLoginData[0].billingState ?? ""
                                billingAddress["billingPincode"] = arrLoginData[0].billingPincode ?? ""
                                
                                var shippingAddress: [String: String] = [:]
                                if let shipaddress = arrLoginData[0].shippingAddress {
                                    shippingAddress["shippingAddress"] = arrLoginData[0].shippingAddress ?? ""
                                    shippingAddress["shippingArea"] = arrLoginData[0].shippingArea ?? ""
                                    shippingAddress["shippingCity"] = arrLoginData[0].shippingCity ?? ""
                                    shippingAddress["shippingCountry"] = arrLoginData[0].shippingCountry ?? ""
                                    shippingAddress["shippingState"] = arrLoginData[0].shippingState ?? ""
                                    shippingAddress["shippingPincode"] = arrLoginData[0].shippingPincode ?? ""
                                } else {
                                    shippingAddress = billingAddress
                                }
                                USERDEFAULTS.setDataForKey(address.jsonString() , .address)
                                USERDEFAULTS.setDataForKey(billingAddress.jsonString() , .billingAddress)
                                USERDEFAULTS.setDataForKey(shippingAddress.jsonString() , .deliveryAddress)
                                USERDEFAULTS.setDataForKey(buyerType , .buyerType)
                                
                                if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                                    if let WelcomeViewController = AuthenticationStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
                                        WelcomeViewController.modalPresentationStyle = .fullScreen
                                        self.present(WelcomeViewController, animated: true)
                                    }
                                } else {
                                    let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
                                    dashboardvc?.selectedIndex = 0
                                    Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
                                }
                            }
                        } else {
                            
                            self.showCustomAlert(message: dicResponseData.message ?? "")
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
    //This method is used for invoke the normal login
    func wsLogin(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "\(Constants.WebServiceParameter.paramEmail)=\(txtEmail.text ?? "")&\(Constants.WebServiceParameter.paramPassword)=\(txtPassword.text ?? "")&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))&login_user_type=b2c"
        var arrLoginData = [LoginResponse]()
        print(postString)
        print(arrLoginData)
        APICall().post(apiUrl: Constants.WebServiceURLs.loginURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(LoginResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            if let data = dicResponseData.data {
                                
                                arrLoginData = [data]
                                print(arrLoginData)
                                self.showCustomAlert(message:dicResponseData.message ?? "")
                                USERDEFAULTS.setDataForKey("true", .isLogin)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].token ?? "" , .accessToken)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].email ?? "" , .user_email)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].firstname ?? "" , .user_first_name)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].middlename ?? "" , .user_middle_name)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].lastname ?? "" , .user_last_name)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].id ?? "" , .userID)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].userTypeID ?? "" , .user_type_id)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].mobileNoCode ?? "" , .user_mobile_number_code)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].phoneNumber ?? "" , .user_phone)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].profile ?? "" , .userPic)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].designation ?? "" , .designation)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].notified ?? "" , .getNotified)
                                USERDEFAULTS.setDataForKey(self.weightage, .weightage)
                                print(self.weightage)
                                var buyerType: String = ""
                                //                                if arrLoginData[0].userType == 1 {
                                //                                    if let buyerTypeDetails = arrLoginData[0].buyerType?.lowercased() {
                                //                                        buyerType = buyerTypeDetails
                                //                                    } else {
                                //                                        buyerType = "company"
                                //                                    }
                                //                                }
                                
                                var address: [String: String] = [:]
                                address["address"] = arrLoginData[0].address ?? ""
                                address["area"] = arrLoginData[0].area ?? ""
                                address["city"] = arrLoginData[0].city ?? ""
                                address["country"] = arrLoginData[0].country ?? ""
                                address["state"] = arrLoginData[0].state ?? ""
                                address["pincode"] = arrLoginData[0].pincode ?? ""
                                
                                var billingAddress: [String: String] = [:]
                                billingAddress["billingAddress"] = arrLoginData[0].billingAddress ?? ""
                                billingAddress["billingArea"] = arrLoginData[0].billingArea ?? ""
                                billingAddress["billingCity"] = arrLoginData[0].billingCity ?? ""
                                billingAddress["billingCountry"] = arrLoginData[0].billingCountry ?? ""
                                billingAddress["billingState"] = arrLoginData[0].billingState ?? ""
                                billingAddress["billingPincode"] = arrLoginData[0].billingPincode ?? ""
                                
                                var shippingAddress: [String: String] = [:]
                                if let shipaddress = arrLoginData[0].shippingAddress {
                                    shippingAddress["shippingAddress"] = arrLoginData[0].shippingAddress ?? ""
                                    shippingAddress["shippingArea"] = arrLoginData[0].shippingArea ?? ""
                                    shippingAddress["shippingCity"] = arrLoginData[0].shippingCity ?? ""
                                    shippingAddress["shippingCountry"] = arrLoginData[0].shippingCountry ?? ""
                                    shippingAddress["shippingState"] = arrLoginData[0].shippingState ?? ""
                                    shippingAddress["shippingPincode"] = arrLoginData[0].shippingPincode ?? ""
                                } else {
                                    shippingAddress = billingAddress
                                }
                                
                                //Baryons-Surendra added on 24/01/22 -- start
                                USERDEFAULTS.setDataForKey(arrLoginData[0].billingAdd?.city ?? "" , .billingCity)
                                USERDEFAULTS.setDataForKey(arrLoginData[0].shippingAdd?.city ?? "" , .shippingCity)
                                //Baryons-Surendra added on 24/01/22 -- end
                                
                                USERDEFAULTS.setDataForKey(address.jsonString() , .address)
                                USERDEFAULTS.setDataForKey(billingAddress.jsonString() , .billingAddress)
                                USERDEFAULTS.setDataForKey(shippingAddress.jsonString() , .deliveryAddress)
                                USERDEFAULTS.setDataForKey(buyerType , .buyerType)
                                
                                if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                                    if let WelcomeViewController = AuthenticationStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
                                        WelcomeViewController.modalPresentationStyle = .fullScreen
                                        self.present(WelcomeViewController, animated: true)
                                    }
                                } else {
                                    let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
                                    dashboardvc?.selectedIndex = 0
                                    Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
                                   
                                }
                            }
                        } else {
                            self.showCustomAlert(message:dicResponseData.message ?? "")
                        }
                    }catch let err {
                        self.showCustomAlert(message: "Invalid credentials. Please try again", isSuccessResponse: false)
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for profile complete progress
    func wsProfileCompleteProgress() {
        var weightage = 80
        if USERDEFAULTS.getDataForKey(.userPic) as! String == "" {
            weightage = weightage + 20
            print(weightage)
            USERDEFAULTS.setDataForKey(weightage, .weightage)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        if let backScreen = AuthenticationStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
            self.navigationController?.pushViewController(backScreen, animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func googleSignInAction(_ sender: Any) {
        handleSignInButton()
    }
    
    var appVersion: String {
        //versionNumber
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "1.0"
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "1.0"
        return "Version : \(versionNumber)"
    }
    //This function used for google sign in
    func handleSignInButton() {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print(emailAddress,fullName,givenName)
            print("*********** Google sign in ")
            self.wsGoogleLogin(email: emailAddress ?? "", name: fullName ?? ""  )
        }
    }
    @IBAction func btnSignInAct(_ sender: Any) {
        self.validationLogin()
    }
    @IBAction func btnForgotPasswordAct(_ sender: Any) {
        if let objForgotPasswordVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC {
            objForgotPasswordVC.modalPresentationStyle = .fullScreen
            self.present(objForgotPasswordVC, animated: true)
        }
    }
}

//MARK: - UITextField Delegate Methods
extension LoginVC {
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if(textField.returnKeyType==UIReturnKeyType.next) {
            textField.superview?.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        }
        else if(textField.returnKeyType==UIReturnKeyType.done){
            textField.resignFirstResponder()
            validationLogin()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
