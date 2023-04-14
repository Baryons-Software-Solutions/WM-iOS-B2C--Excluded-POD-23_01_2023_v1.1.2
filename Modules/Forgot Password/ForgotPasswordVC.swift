//
//  ForgotPasswordVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 03/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSubmitOut: UIButton!
    @IBOutlet weak var RegisterEmailTitle: UILabel!
    @IBOutlet weak var RegisterEmailAlertLabel: UILabel!
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSubmitOut.cornerRadius = 6
        uiElementsSetup()
        // Do any additional setup after loading the view.
    }
    func uiElementsSetup(){
        self.hideAlert(bool: true)
        self.RegisterEmailAlertLabel.textColor   = .red
    }
    
    func hideAlert(bool:Bool){
        [self.RegisterEmailAlertLabel].forEach({ (label) in
            label?.isHidden = bool
        })
    }
    //This method is used for valliadtion purpose
    func validationEmail(){
        var registererror = true
        if Validation().isEmpty(txtField: txtEmail.text!){
            RegisterEmailAlertLabel.text = Constants.AlertMessage.email
            RegisterEmailAlertLabel.isHidden = false
            registererror = true
        } else  if !txtEmail.text!.isEmail{
            RegisterEmailAlertLabel.text = Constants.AlertMessage.email
            RegisterEmailAlertLabel.isHidden = false
            registererror = true
        }
        else{
            registererror = false
            self.hideAlert(bool: true)
            RegisterEmailAlertLabel.isHidden = true
            wsForgotPassword()
        }
    }
    //MARK: - UIButton Actions
    @IBAction func btnBackAct(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnSubmitAct(_ sender: Any) {
        self.validationEmail()
    }
    
    
    //MARK: - API Call
    //This method is used for invoke the forgot password API
    func wsForgotPassword(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showCustomAlert(message: Constants.AlertMessage.NetworkConnection as String, isSuccessResponse: false)
            return
        }
        let postString = "\(Constants.WebServiceParameter.paramEmail)=\(txtEmail.text ?? "")";
        APICall().post(apiUrl: Constants.WebServiceURLs.ForgotPasswordURL, requestPARAMS: postString, isTimeOut: true){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.showCustomAlert(message: "Temporary login password was sent to the registered Email")
                            self.navigationController?.popViewController(animated: true)
                            self.txtEmail.text = ""
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
}
