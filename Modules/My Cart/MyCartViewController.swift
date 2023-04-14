//
//  MyCartViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 28/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import PaymentSDK
import SwiftyJSON

class MyCartViewController: UIViewController, PaymentManagerDelegate {
    @IBOutlet weak var BtnPayNow: UIButton!
    @IBOutlet weak var lblCartDelete: UILabel!
    @IBOutlet weak var vwSuccess: UIView!
    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var FilterBGView: UIView!
    @IBOutlet weak var btnAddproduct: UIButton!
    @IBOutlet weak var lblEmptycart: UILabel!
    @IBOutlet weak var lbladdsome: UILabel!
    @IBOutlet weak var imgcart: UIImageView!
    @IBOutlet weak var backButton       : UIButton!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var ordersTableView  : UITableView!
    @IBOutlet weak var nodataAvailable  : UILabel!
    @IBOutlet weak var VwBlur: UIView!
    @IBOutlet weak var BtnCountinue: UIButton!
    @IBOutlet weak var BtnDelete: UIButton!
    @IBOutlet weak var BtnCancel: UIButton!
    @IBOutlet weak var tableViewStackview: UIStackView!
    @IBOutlet weak var paynowStackView: UIStackView!
    
    var mycartCount                          = 0
    var selectedIndexRow                     = 0
    var searchedText                         = ""
    var arrCartListResponse                  = [CartListResponse]()
    var arrProductsInfo                      = [ProductsInfo]()
    var arrCartProductListResponse           = [Cart]()
    var cartID                               = String()
    var userType: Int                        = USERDEFAULTS.getDataForKey(.user_type) as? Int ?? 0
    var buyerType: String                    = USERDEFAULTS.getDataForKey(.buyerType) as? String ?? ""
    var billingAddress: [String: String]     = [:]
    var shippingAddress: [String: String]    = [:]
    var payTabsPaymentProfileID: String      = ""
    var paymentsCallingCount                 = 0
    var totalConsoldatedAmount               = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BtnPayNow.cornerRadius = 6
        self.btnAddproduct.cornerRadius = 10
        self.vwDelete.cornerRadius = 10
        self.BtnCancel.cornerRadius = 10
        self.BtnDelete.cornerRadius = 10
        self.vwSuccess.cornerRadius = 10
        self.BtnCountinue.cornerRadius = 10
        self.paynowStackView.isHidden = true
        vwSuccess.isHidden = true
        registerXibs()
        UIElementsSetUp()
        delegateSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        paymentsCallingCount = 0
        self.tabBarController?.tabBar.isHidden = false
        arrCartProductListResponse.removeAll()
        arrProductsInfo.removeAll()
        arrCartListResponse.removeAll()
        vwDelete.isHidden = true
        VwBlur.isHidden = true
        btnAddproduct.isHidden = true
        lblEmptycart.isHidden = true
        lbladdsome.isHidden = true
        imgcart.isHidden = true
        wsCartGet()
    }
    
    func delegateSetup(){
        ordersTableView.delegate   = self
        ordersTableView.dataSource = self
    }
    
    func registerXibs(){
        ordersTableView.register(UINib.init(nibName: "MyCartTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCartTableViewCell")
    }
    
    func UIElementsSetUp(){
        self.titleLabel.text = "My Cart"
    }
    
    @IBAction func BtnAddPrroducts(_ sender: Any) {
        let SearchViewController = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(SearchViewController, animated: true)
        
    }
    @IBAction func BtnCancel(_ sender: Any) {
        VwBlur.isHidden = true
        vwDelete.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    @IBAction func BtnDelete(_ sender: Any) {
        wsDeleteProduct(productID: arrCartProductListResponse[selectedIndexRow].productsInfo![0].id, priceRangeID: arrCartProductListResponse[selectedIndexRow].productsInfo![0].priceRangeID,supplierId: arrCartProductListResponse[selectedIndexRow].supplierID,cartID: arrCartProductListResponse[selectedIndexRow].id )
        showCustomAlert(message: "Order deleted successfully")
    }
    @IBAction func BtnCountinue(_ sender: Any) {
        self.dismiss(animated:true)
        VwBlur.isHidden = true
        vwDelete.isHidden = true
        vwSuccess.isHidden = true
    }
    @IBAction func BtnPayNow(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            dashboardVC.modalPresentationStyle = .fullScreen
        }else{
            print("userType: \(userType)")
            print("self.arrCartListResponse.count: \(self.arrCartListResponse.count)")
            let cartItemDetails = self.arrCartProductListResponse[0]
            if let paymentInfo = cartItemDetails.totalPayableAmount, let payableAmount: Double = Double(paymentInfo.rawValue) , payableAmount > 0 {
                paymentChecking(payableAmount: totalConsoldatedAmount)
                print(payableAmount)
            } else {
                wsProcessCart()
            }
        }
    }
    //This function used for navigating to notification screen
    @IBAction func notificatiojAction(_ sender: Any) {
        let notificationVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        notificationVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(notificationVC, animated: true)
    }
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //This method is used for getting the delivery address
    func getDeliveryAddress() -> [String: String] {
        var deliveryAddress: [String: String] = [:]
        let addresss = self.arrCartProductListResponse[0].deliveryAddress
        var name = ""
        if let firstName =  USERDEFAULTS.getDataForKey(.user_first_name) as? String {
            name = firstName
        }
        if let lastName = USERDEFAULTS.getDataForKey(.user_last_name) as? String {
            if !name.isEmpty {
                name = name + " "
            }
            name = name + lastName
        }
        deliveryAddress["name"] = name
        deliveryAddress["email"] = USERDEFAULTS.getDataForKey(.user_email) as? String
        deliveryAddress["addresss"] = addresss
        deliveryAddress["phone"] = USERDEFAULTS.getDataForKey(.user_phone) as? String
        deliveryAddress["city"] = USERDEFAULTS.getDataForKey(.shippingCity) as? String //Baryons-Surendra added on 24/01/22
        deliveryAddress["state"] = USERDEFAULTS.getDataForKey(.shippingCity) as? String //Baryons-Surendra added on 24/01/22
        deliveryAddress["countryCode"] = USERDEFAULTS.getDataForKey(.state) as? String ?? "ae"
        deliveryAddress["zip"] = USERDEFAULTS.getDataForKey(.pincode) as? String
        return deliveryAddress
    }
    func showMinOrderValidation() {
        self.BtnPayNow.isHidden = false
        self.paynowStackView.isHidden = false
        for element in arrCartProductListResponse {
            if element.rejectMinOrderValue == "1" {
                let priceDifference = element.minOrderValue.doubleValue() - (element.totalPayableAmount?.rawValue.doubleValue() ?? 0.0)
                print(priceDifference)
                let roundpriceDifference = round(priceDifference*100)/100.0
                if element.minOrderValue.doubleValue() > element.totalPayableAmount?.rawValue.doubleValue() ?? 0.0 {
                    showCustomAlert(message: "The Minimum order value for \(element.supplierInfo.companyName?.rawValue ?? "") is \(element.minOrderValue). Add prouducts worth \(roundpriceDifference) or more to complete the order.",isSuccessResponse: false,alertTitle: "N/A")
                    self.BtnPayNow.isHidden = true
                    self.paynowStackView.isHidden = true
                }
            }
        }
    }
    //This method is used for getting the billing address
    func getBillingAddress() -> [String: String] {
        var bAddress: [String: String] = [:]
        let addresss = self.arrCartProductListResponse[0].billingAddress
        var name = "", phoneCode = ""
        if let firstName =  USERDEFAULTS.getDataForKey(.user_first_name) as? String {
            name = firstName
        }
        if let lastName = USERDEFAULTS.getDataForKey(.user_last_name) as? String {
            if !name.isEmpty {
                name = name + " "
            }
            name = name + lastName
        }
        if let phoneNo = USERDEFAULTS.getDataForKey(.user_phone) as? String {
            phoneCode = phoneNo
        }
        bAddress["name"] = name
        bAddress["email"] = USERDEFAULTS.getDataForKey(.user_email) as? String
        bAddress["addresss"] = addresss
        bAddress["phone"] = phoneCode
        bAddress["city"] = USERDEFAULTS.getDataForKey(.billingCity) as? String //Baryons-Surendra added on 24/01/22
        bAddress["state"] = USERDEFAULTS.getDataForKey(.billingCity) as? String //Baryons-Surendra added on 24/01/22
        bAddress["countryCode"] = USERDEFAULTS.getDataForKey(.state) as? String ?? "ae"
        bAddress["zip"] = USERDEFAULTS.getDataForKey(.pincode) as? String
        return bAddress
    }
    //This method is used for payment checking
    func paymentChecking(payableAmount: Double){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            hideLoader()
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        showLoader()
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.pricingCheck
        print(url)
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
        }
        do{
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                hideLoader()
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        print ("productListURL response:::",jsonResponse)
                        do {
                            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                                print(convertedJsonIntoDict)
                                let decoder = JSONDecoder()
                                let dicResponseData = try decoder.decode(FilterPricingModel.self, from: data )
                                if dicResponseData.success == "1" {
                                    DispatchQueue.main.async {
                                        self.payNow(payableAmount: payableAmount)
                                    }
                                } else {
                                    self.showCustomAlert(message: dicResponseData.message)
                                }
                            }
                        } catch let error as NSError {
                            print("Session Error: ",error)
                            DispatchQueue.main.async {
                                hideLoader()
                            }
                        }
                    }catch _ {
                        hideLoader()
                        print ("OOps not good JSON formatted response")
                    }
                }
            })
            task.resume()
        }catch _ {
            hideLoader()
            print ("Oops something happened buddy")
        }
    }
    func payNow(payableAmount: Double) {
        let addresss = self.arrCartProductListResponse[0].billingAddress
        self.billingAddress = getBillingAddress()
        self.shippingAddress = getDeliveryAddress()
        
        //Error showing in my cart Billing InvalidPhoneNumber
        var billingPhoneNumber = "9090909090"
        if ((self.billingAddress["phone"]) == nil || (self.billingAddress["phone"]) == "") {
            billingPhoneNumber = /*self.billingAddress["phone"] ??*/ "9090909090"
            print(billingPhoneNumber)
        }
        var billingCity = "Dubai"
        if ((self.billingAddress["city"]) == nil || (self.billingAddress["city"]) == "") {
            billingCity = self.billingAddress["city"] ?? "Dubai"
        }
        var billingState = "Dubai"
        if ((self.billingAddress["state"]) == nil || (self.billingAddress["state"]) == "") {
            billingState = self.billingAddress["state"] ?? "Dubai"
        }
        var shippingPhoneNumber = "9090909090"
        if ((self.shippingAddress["phone"]) == nil || (self.shippingAddress["phone"]) == "") {
            shippingPhoneNumber = self.shippingAddress["phone"] ?? "9090909090"
        }
        var shippingCity = "Dubai"
        if ((self.shippingAddress["city"]) == nil || (self.shippingAddress["city"]) == "") {
            shippingCity = self.shippingAddress["city"] ?? "Dubai"
        }
        var shippingState = "Dubai"
        if ((self.shippingAddress["state"]) == nil || (self.shippingAddress["state"]) == "") {
            shippingState = self.shippingAddress["state"] ?? "Dubai"
        }
        let billingDetails = PaymentSDKBillingDetails(name: self.billingAddress["name"],
                                                      email: self.billingAddress["email"],
                                                      phone: billingPhoneNumber,
                                                      addressLine: self.billingAddress["addresss"],
                                                      city: billingCity,
                                                      state: billingState,
                                                      countryCode: self.billingAddress["countryCode"],
                                                      zip: self.billingAddress["zip"])
        
        let shippingDetails = PaymentSDKShippingDetails(name: self.shippingAddress["name"],
                                                        email: self.shippingAddress["email"],
                                                        phone: shippingPhoneNumber,
                                                        addressLine: self.shippingAddress["addresss"],
                                                        city: shippingCity,
                                                        state: shippingState,
                                                        countryCode: self.shippingAddress["countryCode"],
                                                        zip: self.shippingAddress["zip"])
        
        
        let sdkConfig = PayTabsService.getSDKConfiguration()
        sdkConfig.cartID = self.arrCartProductListResponse[0].id
        sdkConfig.amount =  payableAmount
        sdkConfig.cartDescription = self.arrCartProductListResponse[0].id
        sdkConfig.billingDetails = billingDetails
        sdkConfig.shippingDetails = shippingDetails
        sdkConfig.showBillingInfo(false)
        sdkConfig.showShippingInfo(false)
        sdkConfig.profileID = ""
        if payableAmount > 0, !self.payTabsPaymentProfileID.isEmpty {
            sdkConfig.profileID = "80475"//self.payTabsPaymentProfileID
            PaymentManager.startCardPayment(on: self, configuration: sdkConfig, delegate: self)
        }
    }
    //This method is used for invoking the process cart
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            let para:NSMutableDictionary = NSMutableDictionary()
            para.setValue(transactionDetails.transactionReference, forKey: "transactionReference")
            para.setValue(transactionDetails.transactionType, forKey: "transactionType")
            para.setValue(transactionDetails.cartID, forKey: "cartId")
            para.setValue(transactionDetails.cartDescription, forKey: "cartDescription")
            para.setValue(transactionDetails.cartCurrency, forKey: "cartCurrency")
            para.setValue(transactionDetails.cartAmount, forKey: "cartAmount")
            para.setValue("Authorised", forKey: "payResponseReturn")
            let paymentResult:NSMutableDictionary = NSMutableDictionary()
            paymentResult.setValue(transactionDetails.paymentResult?.responseCode, forKey: "responseCode")
            paymentResult.setValue(transactionDetails.paymentResult?.responseMessage, forKey: "responseMessage")
            paymentResult.setValue(transactionDetails.paymentResult?.responseStatus, forKey: "responseStatus")
            paymentResult.setValue(transactionDetails.paymentResult?.transactionTime , forKey: "transactionTime")
            para.setValue(paymentResult, forKey: "paymentResult")
            let paymentInfo:NSMutableDictionary = NSMutableDictionary()
            paymentInfo.setValue(transactionDetails.paymentInfo?.cardScheme, forKey: "cardScheme")
            paymentInfo.setValue(transactionDetails.paymentInfo?.cardType, forKey: "cardType")
            paymentInfo.setValue(transactionDetails.paymentInfo?.paymentDescription, forKey: "paymentDescription")
            para.setValue(paymentInfo, forKey: "paymentInfo")
            para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "redirectUrl")
            para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "errorCode")
            para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "errorMsg")
            para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "token")
            let billingDetails: NSMutableDictionary = NSMutableDictionary()
            billingDetails.setValue(transactionDetails.billingDetails?.city, forKey: "city")
            billingDetails.setValue(transactionDetails.billingDetails?.countryCode, forKey: "countryCode")
            billingDetails.setValue(transactionDetails.billingDetails?.email, forKey: "email")
            billingDetails.setValue(transactionDetails.billingDetails?.name, forKey: "name")
            billingDetails.setValue(transactionDetails.billingDetails?.phone, forKey: "phone")
            billingDetails.setValue(transactionDetails.billingDetails?.state, forKey: "state")
            billingDetails.setValue(transactionDetails.billingDetails?.addressLine, forKey: "addressLine")
            billingDetails.setValue(transactionDetails.billingDetails?.zip, forKey: "zip")
            para.setValue(billingDetails, forKey: "billingDetails")
            let shippingDetails: NSMutableDictionary = NSMutableDictionary()
            shippingDetails.setValue(transactionDetails.shippingDetails?.city, forKey: "city")
            shippingDetails.setValue(transactionDetails.shippingDetails?.countryCode, forKey: "countryCode")
            shippingDetails.setValue(transactionDetails.shippingDetails?.email, forKey: "email")
            shippingDetails.setValue(transactionDetails.shippingDetails?.name, forKey: "name")
            shippingDetails.setValue(transactionDetails.shippingDetails?.phone, forKey: "phone")
            shippingDetails.setValue(transactionDetails.shippingDetails?.state, forKey: "state")
            shippingDetails.setValue(transactionDetails.shippingDetails?.addressLine, forKey: "addressLine")
            shippingDetails.setValue(transactionDetails.shippingDetails?.zip, forKey: "zip")
            para.setValue(shippingDetails, forKey: "shippingDetails")
            
            guard case ConnectionCheck.isConnectedToNetwork() = true else {
                showToast(message: Constants.AlertMessage.NetworkConnection)
                return
            }
            // Below code is required for payments status
            //       if (transactionDetails.paymentResult?.responseStatus == "A") {
            APICall().get(apiUrl: Constants.WebServiceURLs.ProcessCartURL) {
                (success, responseData) in DispatchQueue.main.async {
                    let orderJSON = JSON(responseData)
                    if success, orderJSON != JSON.null, orderJSON.count > 0, orderJSON["success"].stringValue == "1",
                       var parameters: [String: Any] = para as? [String: Any] {
                        
                        for i in 0..<orderJSON["data"].count {
                            let orderNo = orderJSON["data"][i]["order_number"].string
                            let orderId = orderJSON["data"][i]["order_id"].string
                            parameters["cartId"] = orderNo
                            parameters["orderId"] = orderId
                            if ((orderId?.isEmpty) == false){
                                if let parameterString = JSON(["PaymentSdkTransactionDetails": parameters]).rawString(), !parameterString.isEmpty {
                                    let paymentInfoString = parameterString.replacingOccurrences(of: "\n", with: "")
                                    self.updatePaymentinfo(paymentDetails: paymentInfoString, orderId: orderId ?? "",responseMessage : orderJSON["message"].string ?? "Thank you for placing the order. You can track order status in View Orders page.")
                                }
                            }
                        }
                    } else if !orderJSON["message"].stringValue.isEmpty {
                        self.showCustomAlert(message: orderJSON["message"].stringValue, isSuccessResponse: false)
                    } else {
                       //    self.view.makeToast("Error: Unable to create order")
                    }
                    
                }
            }
            //            } else if (transactionDetails.paymentResult?.responseStatus == "D") {
            //                self.showCustomAlert(message: "Transaction Declined", isSuccessResponse: false)  //self.view.makeToast("Transaction Declined")//
            //            } else if (transactionDetails.paymentResult?.responseStatus == "P") {
            //                self.showCustomAlert(message: "Transaction Pending", isSuccessResponse: false)// self.view.makeToast("Transaction Pending")
            //            } else if (transactionDetails.paymentResult?.responseStatus == "H") {
            //                self.showCustomAlert(message:"Transaction On Hold", isSuccessResponse: false)   //  self.view.makeToast("Transaction On Hold")
            //            } else if (transactionDetails.paymentResult?.responseStatus == "V") {
            //                self.showCustomAlert(message: "Transaction Voided", isSuccessResponse: false)    // self.view.makeToast("Transaction Voided")
            //            } else if (transactionDetails.paymentResult?.responseStatus == "E") {
            //                self.showCustomAlert(message: "Transaction Error", isSuccessResponse: false)    // self.view.makeToast("Transaction Error")
            //            } else if (transactionDetails.paymentResult?.responseStatus == "C") {
            //                self.showCustomAlert(message:"Transaction Cancelled", isSuccessResponse: false)//  self.view.makeToast("Transaction Cancelled")
            //            }
            
        } else if let error = error {
          //  self.view.makeToast(Constants.AlertMessage.error)
            print(error)
        }
    }
    //This method is used for invoking the paynow API
    func updatePaymentinfo(paymentDetails: String, orderId: String, responseMessage :String) {
        guard !paymentDetails.isEmpty, !orderId.isEmpty else {
            showToast(message: "Something went wrong")
            return
        }
        APICall().post1(apiUrl: Constants.WebServiceURLs.PayNowURL, requestPARAMS: paymentDetails, isTimeOut: false) {
            (success, responseData) in DispatchQueue.main.async {
                hideLoader()
                if success {
                    let paymentInfoUpdateResponse = JSON(responseData)
                    if paymentInfoUpdateResponse["success"].stringValue == "1" {
                        let alert = UIAlertController(title: "Message", message: responseMessage, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                            //Baryons team commented below code,
                            //becaause after placing the payment navigating to Order list page as per the Android APP
                            //                                                        if let objPlacedOrderViewVC = mainStoryboard.instantiateViewController(withIdentifier: "PlacedOrderViewVC") as? PlacedOrderViewVC {
                            //                                objPlacedOrderViewVC.orderId = orderId
                            //                                objPlacedOrderViewVC.routeFrom = "payment"
                            //                                self.navigationController?.pushViewController(objPlacedOrderViewVC, animated: true)
                            //                        }
                            //Baryons added the
                            let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
                            dashboardvc?.selectedIndex = 1
                            Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else{
                        print("Session Error: ")
                        self.showToast(message: Constants.AlertMessage.error)
                    }
                } else {
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
}
//This method is used for invoking process cart API
extension MyCartViewController{
    func wsProcessCart(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        APICall().get(apiUrl: Constants.WebServiceURLs.ProcessCartURL){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ProcessCartResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            let alert = UIAlertController(title: "Message", message: dicResponseData.message, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                                if dicResponseData.redirectCode?.status == 10{
                                    if let objDraftOrderVC = mainStoryboard.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController {
                                        self.navigationController?.pushViewController(objDraftOrderVC, animated: true)
                                    }
                                } else  {
                                    // status == 20
                                    if let objPlacedOrderVC = mainStoryboard.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController {
                                        self.navigationController?.pushViewController(objPlacedOrderVC, animated: true)
                                    }
                                }
                            }))
                            self.present(alert, animated: true) {
                                DispatchQueue.main.async {
                                    self.ordersTableView.reloadData()
                                }
                            }
                        } else {
                            print("Session Error: ")
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                }
            }
        }
    }
    //This method is used for Cart get API
    func wsCartGet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        self.arrCartListResponse.removeAll()
        APICall().get(apiUrl: Constants.WebServiceURLs.cartListURL){
            (success, responseData) in DispatchQueue.main.async { [self] in
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(CartListResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            if let data = dicResponseData.data {
                                self.arrCartListResponse = [data]
                            }
                            if self.arrCartListResponse.count > 0 {
                                self.titleLabel.text            = "My Cart (\(self.arrCartListResponse.first?.cart?.count ?? 0) Suppliers)"
                                self.arrCartProductListResponse = self.arrCartListResponse.first?.cart ?? [Cart]()
                                if let profileId = self.arrCartProductListResponse[0].supplierInfo.supplierProfileID?.rawValue, profileId != ""  {
                                    self.payTabsPaymentProfileID = profileId
                                } else {
                                    self.payTabsPaymentProfileID = ""
                                }
                                self.totalConsoldatedAmount = dicResponseData.data?.consolidatedPayableAmount ?? 0.0
                                self.tableViewStackview.isHidden = false
                                self.ordersTableView.isHidden = false
                                self.btnAddproduct.isHidden = true
                                self.lblEmptycart.isHidden = true
                                self.lbladdsome.isHidden = true
                                self.imgcart.isHidden = true
                                self.ordersTableView.delegate = self
                                self.ordersTableView.dataSource = self
                                self.ordersTableView.reloadData()
                                self.showMinOrderValidation()
                                self.tabBarController?.tabBar.items![2].badgeValue = "\(self.arrCartListResponse.first?.cart?.count ?? 0)"
                            } else {
                                self.titleLabel.text            = "My Cart"
                                self.tableViewStackview.isHidden = true
                                self.btnAddproduct.isHidden = false
                                self.lblEmptycart.isHidden = false
                                self.lbladdsome.isHidden = true
                                self.imgcart.isHidden = false
                                self.ordersTableView.isHidden = true
                                self.nodataAvailable.text = dicResponseData.message
                            }
                        } else {
                            self.titleLabel.text            = "My Cart"
                            self.btnAddproduct.isHidden = false
                            self.lblEmptycart.isHidden = false
                            self.lbladdsome.isHidden = true
                            self.imgcart.isHidden = false
                            self.ordersTableView.isHidden = true
                            self.tableViewStackview.isHidden = true
                        }
                    } catch let err {
                        print("Session Error: ",err)
                        self.btnAddproduct.isHidden = false
                        self.lblEmptycart.isHidden = false
                        self.lbladdsome.isHidden = true
                        self.imgcart.isHidden = false
                        self.ordersTableView.isHidden = true
                        self.tableViewStackview.isHidden = true
                        self.titleLabel.text            = "My Cart"
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: 0)
                        self.tabBarController?.tabBar.items![2].badgeValue = nil
                    }
                } else {
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
        
    }
    
}


// MARK: -table view delegate functions
//This method is used for crete the table cell
extension MyCartViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCartProductListResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath)as? MyCartTableViewCell
        let element = self.arrCartProductListResponse[indexPath.row]
        cell?.productCostLabel.text =  "AED \(self.arrCartProductListResponse[indexPath.row].totalPayableAmount?.rawValue ?? "0")"
        cell?.productTitle.text = "\(self.arrCartProductListResponse[indexPath.row].supplierInfo.companyName?.rawValue ?? "")"
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrCartProductListResponse[indexPath.row].supplierInfo.profile?.rawValue ?? "")")
        cell?.productImage.kf.indicatorType = .activity
        cell?.productImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "HomePlaceHolder"),
            options: nil)
        cell?.numberofItemsLabel.text = "Total No. of Items : \(self.arrCartProductListResponse[indexPath.row].productsInfo?.count ?? 0)"
        cell?.deleteButton.tag = indexPath.row
        cell?.deleteButton.addTarget(self, action: #selector(dropdown(_:)), for: .touchUpInside)
        cell?.rightArrow.tag = indexPath.row
        cell?.rightArrow.addTarget(self, action: #selector(rightArrowNavigation(_:)), for: .touchUpInside)
        if element.rejectMinOrderValue == "1" {
            if element.minOrderValue.doubleValue() > element.totalPayableAmount?.rawValue.doubleValue() ?? 0.0 {
                cell?.minOrderLabel.text = "Minimum order value is: \(element.minOrderValue)"
            }
            else {
                cell?.minOrderLabel.text = ""
            }
        }
        else {
            cell?.minOrderLabel.text = ""
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = menuStoryBoard.instantiateViewController(withIdentifier: "MyCartDetailsViewController") as? MyCartDetailsViewController
        vc?.supplierID = arrCartProductListResponse[indexPath.row].supplierID
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func dropdown(_ sender: UIButton){
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            selectedIndexRow = indexPath.row
            cartID = arrCartProductListResponse[indexPath.row].id
            VwBlur.isHidden = false
            vwDelete.isHidden = false
            self.tabBarController?.tabBar.backgroundColor = .white
            self.tabBarController?.tabBar.alpha = 1
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }else{
            let indexPath = IndexPath(row: sender.tag, section: 0)
            selectedIndexRow = indexPath.row
            cartID = arrCartProductListResponse[indexPath.row].id
            VwBlur.isHidden = false
            vwDelete.isHidden = false
            self.tabBarController?.tabBar.backgroundColor = .white
            self.tabBarController?.tabBar.alpha = 1
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }
    }
    
    @objc func rightArrowNavigation(_ sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let vc = menuStoryBoard.instantiateViewController(withIdentifier: "MyCartDetailsViewController") as? MyCartDetailsViewController
        vc?.supplierID = arrCartProductListResponse[indexPath.row].supplierID
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func wsDeleteProduct(productID :String, priceRangeID: String,supplierId : String,cartID :String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "supplier_id=\(supplierId)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.supplierDeleteURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.VwBlur.isHidden = true
                        self.vwDelete.isHidden = true
                        self.vwSuccess.isHidden = true
                        self.wsCartGet()
                        print(Data())
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
}
