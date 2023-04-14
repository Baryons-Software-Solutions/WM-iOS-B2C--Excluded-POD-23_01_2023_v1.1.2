//
//  ChangePasswordVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 21/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var btnSubmitOut: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var ConfirmPasswordLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var CurrentPasswordLabel: UILabel!
    @IBOutlet weak var CurrentPasswordAlertLabel: UILabel!
    @IBOutlet weak var PasswordAlertLabel: UILabel!
    @IBOutlet weak var ConfirmPasswordAlertLabel: UILabel!
    
    var button                = UIButton(type: .custom)
    var iconClick             = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
        uiElementsSetup()
    }
    //MARK: - Initialization
    
    func initialization(){
        tabBarController?.tabBar.isHidden = true
        self.btnSubmitOut.cornerRadius = 6
        txtOldPassword.isSecureTextEntry = true
        txtNewPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        txtOldPassword.enablePasswordToggle()
        txtNewPassword.enablePasswordToggle()
        txtConfirmPassword.enablePasswordToggle()
        
    }
    func uiElementsSetup(){
        self.hideAlert(bool: true)
        self.CurrentPasswordAlertLabel.textColor   = .red
        self.PasswordAlertLabel.textColor   = .red
        self.ConfirmPasswordAlertLabel.textColor   = .red
        self.CurrentPasswordLabel.addRequiredAsterisk()
        self.PasswordLabel.addRequiredAsterisk()
        self.ConfirmPasswordLabel.addRequiredAsterisk()
    }
    func hideAlert(bool:Bool){
        [self.CurrentPasswordAlertLabel,PasswordAlertLabel,ConfirmPasswordAlertLabel].forEach({ (label) in
            label?.isHidden = bool
            label?.textColor = .red
        })
    }
    
    //MARK: - Login alidation check
    // This method is used for validation check
    func validationChangePassword(){
        var currenterror = true
        var passworderror = true
        var confirmerror = true
        if Validation().isEmpty(txtField: txtOldPassword.text!){
            CurrentPasswordAlertLabel.text = Constants.AlertMessage.currentpassword
            CurrentPasswordAlertLabel.isHidden  = false
            currenterror = true
        }else{
            currenterror = false
            CurrentPasswordAlertLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: txtNewPassword.text!){
            PasswordAlertLabel.text = Constants.AlertMessage.newPassword
            PasswordAlertLabel.isHidden  = false
            passworderror = true
        }else {
            passworderror = false
            PasswordAlertLabel.isHidden = true
        }
        if Validation().isEmpty(txtField: txtConfirmPassword.text!){
            ConfirmPasswordAlertLabel.text = Constants.AlertMessage.confirmPassword
            ConfirmPasswordAlertLabel.isHidden  = false
            confirmerror = true
        }else if (txtNewPassword.text != txtConfirmPassword.text) {
            confirmerror = true
            ConfirmPasswordAlertLabel.text = Constants.AlertMessage.SamePassword
        }else {
            confirmerror = false
            ConfirmPasswordAlertLabel.isHidden = true
        }
        if currenterror == false && passworderror == false && confirmerror == false {
            self.hideAlert(bool: true)
            self.wsChangePassword()
        }
    }
    //This method to call change password API
    func wsChangePassword(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramOldPassword] = txtOldPassword.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramNewPassword] = txtNewPassword.text as AnyObject
        paramDic [Constants.WebServiceParameter.paramConfirm_Password] = txtConfirmPassword.text as AnyObject
        let postString = "\(Constants.WebServiceParameter.paramOldPassword)=\(txtOldPassword.text ?? "")&\(Constants.WebServiceParameter.paramNewPassword)=\(txtNewPassword.text ?? "")&\(Constants.WebServiceParameter.paramConfirm_Password)=\(txtConfirmPassword.text ?? "")"
        APICall().post(apiUrl: Constants.WebServiceURLs.changepasswordURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        print(self.showCustomAlert)
                        if dicResponseData.success == "1" {
                            self.showCustomAlert(message: dicResponseData.message)
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showCustomAlert(message: dicResponseData.message,isSuccessResponse: false)
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
    @IBAction func btnSubmitAct(_ sender: Any) {
        validationChangePassword()
    }
    
}
extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "eye-off"), for: .normal)
        } else {
            button.setImage(UIImage(named: "ic_eye"), for: .normal)
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
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
//MARK: - UITextField Delegate Methods
extension ChangePasswordVC {
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if(textField.returnKeyType==UIReturnKeyType.next) {
            textField.superview?.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        }
        else if(textField.returnKeyType==UIReturnKeyType.done){
            textField.resignFirstResponder()
            validationChangePassword()
        }
        return true
    }
}

