//
//  OrderDetailsViewController.swift
//  
//
//  Created by chittiraju on 12/10/22.
// Updated by Avinash on 11/03/23.
//

import UIKit
import SwiftyJSON
import PaymentSDK
import FittedSheets

class OrderDetailsViewController: UIViewController  ,PaymentManagerDelegate, URLSessionDelegate{
    
    @IBOutlet weak var paidLabel                : UILabel!
    @IBOutlet weak var backbutton               : UIButton!
    @IBOutlet weak var orderNumberLabel         : UILabel!
    @IBOutlet weak var outletNameLabel          : UILabel!
    @IBOutlet weak var addressNameLabel         : UILabel!
    @IBOutlet weak var subaddressNameLabel      : UILabel!
    @IBOutlet weak var itemsCountLabel          : UILabel!
    @IBOutlet weak var emailSentLabel           : UILabel!
    @IBOutlet weak var createdDateLabel         : UILabel!
    @IBOutlet weak var amountLabel              : UILabel!
    @IBOutlet weak var productsTableView        : UITableView!
    @IBOutlet weak var addSpecialProductButton  : UIButton!
    @IBOutlet weak var addNotesButton           : UIButton!
    @IBOutlet weak var billingAddressLabel      : UILabel!
    @IBOutlet weak var deliveryAddressLabel     : UILabel!
    @IBOutlet weak var deliveryAddressEditButton: UIButton!
    @IBOutlet weak var deliverydateTextField    : UITextField!
    @IBOutlet weak var deliveryDataButton       : UIButton!
    @IBOutlet weak var estimatedSubTotalLabel   : UILabel!
    @IBOutlet weak var exstimatedDeliveryFeeLabel: UILabel!
    @IBOutlet weak var vatPercentageLabel       : UILabel!
    @IBOutlet weak var estimatedTotalLabel      : UILabel!
    @IBOutlet weak var productTableViewHeight   : NSLayoutConstraint!
    @IBOutlet weak var supplierNotesView        : UIView!
    @IBOutlet weak var suppliernotesLabel       : UILabel!
    @IBOutlet weak var supllierNotesTitle       : UILabel!
    @IBOutlet weak var bckView                  : UIView!
    @IBOutlet weak var vwNotes                  : UIView!
    @IBOutlet weak var txtPopupNotes            : UITextField!
    @IBOutlet weak var lblNotesPopupTitle       : UILabel!
    @IBOutlet weak var btnSubmitPopupNotes      : UIButton!
    @IBOutlet weak var txtCustomSKU             : UITextField!
    @IBOutlet weak var txtCustomProductName     : UITextField!
    @IBOutlet weak var txtCustomProductPrice    : UITextField!
    @IBOutlet weak var txtCustomProductQty      : UITextField!
    @IBOutlet weak var txtCustomProductDesc     : UITextField!
    @IBOutlet weak var btnSubmitCustomProductOut: UIButton!
    @IBOutlet weak var customProductView        : UIView!
    @IBOutlet weak var chnageProductQuantityView: UIView!
    @IBOutlet weak var btnSubmitChangeProductQuantity: UIButton!
    @IBOutlet weak var txtChangeProductQuantity : UITextField!
    @IBOutlet weak var nodataLabel              : UILabel!
    @IBOutlet weak var nodataView               : UIView!
    @IBOutlet weak var tblDeliverySchedule: UITableView!
    @IBOutlet weak var popupDeliveryScheduleView: UIView!
    @IBOutlet weak var continueShoppingButtonButton: UIButton!
    @IBOutlet weak var minimumOrderLabel: UILabel!
    @IBOutlet weak var payNow: UIButton!
    @IBOutlet weak var paymentStatusBottomlabel: UILabel!
    @IBOutlet weak var dounloadbutton: UIButton!
    @IBOutlet weak var invoiceButton: UIButton!
    @IBOutlet weak var markAsReadbutton: UIButton!
    
    var id = String()
    var paymentStatus                  = ""
    var arrCartListResponse            = [CartListResponse]()
    var arrCartProductListResponse     = [Cart]()
    var cartID                         = String()
    var supplierID                     = String()
    var arrdeliverySchedule            = [DeliverySchedule]()
    var orderResponse                  : Order?
    var invoiceResponse                : InvoiceStatus?
    var arrProductsInfo                = [ProductsInfo]()
    var selectedPriceRangeID           = String()
    var selectedProductID              = String()
    var count                          = -1
    var seletectedCartIndex            = 0
    var arrLogs                        = [Log]()
    var allorderApiCalling             = true
    var isEditProduct                  = false
    var attrs = [
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 10) ?? UIFont.systemFont(ofSize: 19.0),
        NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "#EC187B"),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
    var addSpecialProductButtonString = NSMutableAttributedString(string:"")
    var addnotesButtonString          = NSMutableAttributedString(string:"")
    var changeQuantityTapped          = false
    var totalConsoldatedAmount        = 0.0
    var orderId                       = ""
    var supplierNumber                    = ""
    var userType: Int                 = USERDEFAULTS.getDataForKey(.user_type) as? Int ?? 0
    var buyerType: String             = USERDEFAULTS.getDataForKey(.buyerType) as? String ?? ""
    var billingAddress: [String: String] = [:]
    var shippingAddress: [String: String] = [:]
    var payTabsPaymentProfileID: String = ""
    var paymentsCallingCount = 0
    var isMarkAsReceived     = false
    var displayChangeQty    = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        registerXibs()
        UIElementsSetUp()
        wsOrderBuyerListView()
        textSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func UIElementsSetUp(){
        self.addSpecialProductButton.isHidden = true
        self.payNow.isHidden = false
        productsTableView.backgroundView?.backgroundColor = .clear
        productsTableView.backgroundColor                 = .clear
        bckView.isHidden                                   = true
        bckView.alpha = 0.6
        bckView.backgroundColor = .black
        vwNotes.isHidden                                  = true
        deliverydateTextField.isUserInteractionEnabled    = false
        self.productsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        productsTableView.layer.removeAllAnimations()
        productTableViewHeight.constant = self.productsTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.deliverydateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if  #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            self.deliverydateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.deliverydateTextField.resignFirstResponder()
        wsDeliveryDateAvailability()
    }
    
    func delegateSetup(){
        productsTableView.delegate   = self
        productsTableView.dataSource = self
        productsTableView.reloadData()
    }
    
    func textSetup(){
        addSpecialProductButtonString.append(NSMutableAttributedString(string:"Add Special Product", attributes:attrs))
        addSpecialProductButton.setAttributedTitle(addSpecialProductButtonString, for: .normal)
    }
    
    func registerXibs(){
        productsTableView.register(UINib.init(nibName: "OrderDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDetailsTableViewCell")
        self.tblDeliverySchedule.register(UINib.init(nibName: "DeliveryScheduleTblCell", bundle: nil), forCellReuseIdentifier: "DeliveryScheduleTblCell")
        self.tblDeliverySchedule.tableFooterView = UIView()
    }
    
    //This method is used for download the report
    @IBAction func downloadAction(_ sender: Any) {
        var getRequest = URLRequest(url: URL(string: "\(Constants.WebServiceURLs.DownloadInvoiceURL)\(orderId)")!)
        getRequest.httpMethod = "GET"
        getRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            getRequest.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
        }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        let downloadTask = urlSession.downloadTask(with: getRequest)
        
        downloadTask.resume()
    }
    //This function  used for open the LogHistory
    @IBAction func invoiceAction(_ sender: Any) {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "LogHistoryVC") as? LogHistoryVC
        controller?.arrLogs = self.arrLogs
        let sheetController = SheetViewController(controller: controller!, sizes: [SheetSize.fixed(CGFloat((100 + (118 * self.arrLogs.count))))])

        self.present(sheetController, animated: false, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deliveryAddressButton(_ sender: Any) {
        
    }
    
    @IBAction func deliveryDateButtonAction(_ sender: Any) {
        deliverydateTextField.becomeFirstResponder()
    }
    
    @IBAction func addSpecialProductAction(_ sender: Any) {
        self.bckView.isHidden                = false
        self.customProductView.isHidden     = false
        self.clearAndResignTextFields()
    }
    
    @IBAction func addnotesAction(_ sender: Any) {
        
    }
    
    @IBAction func continueShoppingBottombutton(_ sender: Any) {
        let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchText =  ""
        searchVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    
    @IBAction func btnSubmitPopupNotes(_ sender: Any) {
        print(cartID)
        if Validation().isEmpty(txtField: txtPopupNotes.text!) {
            showToast(message:Constants.AlertMessage.notes)
        } else if self.lblNotesPopupTitle.text == "Product Notes" {
            self.wsProductNotes(notes: self.txtPopupNotes.text ?? "")
            self.txtPopupNotes.resignFirstResponder()
        } else if self.lblNotesPopupTitle.text == "Supplier Notes" {
            self.txtPopupNotes.resignFirstResponder()
            self.wsSupplierNotes(notes: self.txtPopupNotes.text ?? "")
        } else if self.lblNotesPopupTitle.text == "Add Notes" {
            self.txtPopupNotes.resignFirstResponder()
            wsCompletedOrder()
        }else{
            self.txtPopupNotes.resignFirstResponder()
            self.wsDeliveryAddress(notes: self.txtPopupNotes.text ?? "")
        }
    }
    
    @IBAction func btnClosePopupNotesAct(_ sender: Any) {
        self.bckView.isHidden = true
        self.vwNotes.isHidden = true
        self.clearAndResignTextFields()
    }
    //This method used for validation purpose
    @IBAction func btnSubmitCustomProductPopupAct(_ sender: Any) {
        if Validation().isEmpty(txtField: txtCustomProductName.text!){
            showToast(message:Constants.AlertMessage.productName)
        } else if Validation().isEmpty(txtField: txtCustomSKU.text!){
            showToast(message:Constants.AlertMessage.sku)
        }
        else if Validation().isEmpty(txtField: txtCustomProductQty.text!) {
            showToast(message:Constants.AlertMessage.qty)
        } else if Validation().isEmpty(txtField: txtCustomProductDesc.text!) {
            showToast(message:Constants.AlertMessage.desc)
        } else {
            if isEditProduct == true {
                self.wsUpdateCustomProduct()
            } else {
                self.wsAddCustomProduct()
            }
        }
    }
    
    @IBAction func btnCloseCustomProductPopupAct(_ sender: Any) {
        self.bckView.isHidden                = true
        self.customProductView.isHidden     = true
        self.clearAndResignTextFields()
    }
    func clearAndResignTextFields(){
        self.txtChangeProductQuantity.text  = ""
        self.txtCustomProductName.text      = ""
        self.txtCustomSKU.text              = ""
        self.txtCustomProductPrice.text     = ""
        self.txtCustomProductQty.text       = ""
        self.txtCustomProductDesc.text      = ""
        self.txtCustomProductName.resignFirstResponder()
        self.txtCustomSKU.resignFirstResponder()
        self.txtCustomProductPrice.resignFirstResponder()
        self.txtCustomProductQty.resignFirstResponder()
        self.txtCustomProductDesc.resignFirstResponder()
        self.txtChangeProductQuantity.resignFirstResponder()
    }
    
    @IBAction func btnCloseChangeProductQuantityPopupAct(_ sender: Any) {
        self.bckView.isHidden = true
        self.chnageProductQuantityView.isHidden = true
        clearAndResignTextFields()
    }
    
    @IBAction func btnSubmitChangeProductQuantityPopupAct(_ sender: Any) {
        self.txtChangeProductQuantity.resignFirstResponder()
        guard let presentValue = Double(self.txtChangeProductQuantity.text ?? "") else { return }
        if presentValue == 0.0 {
            self.bckView.isHidden = true
            self.chnageProductQuantityView.isHidden = true
            self.showCustomAlert(message: "Please Enter proper value",isSuccessResponse: false,buttonTitle:  "Try Again")
            return
        }
        
        if Validation().isEmpty(txtField: txtChangeProductQuantity.text!){
            self.showCustomAlert(message:Constants.AlertMessage.qty)
        } else {
            self.bckView.isHidden = true
            self.chnageProductQuantityView.isHidden = true
            let cell: OrderDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: seletectedCartIndex, section: 0)) as? OrderDetailsTableViewCell)
            cell?.productCountLabel.text = String(self.txtChangeProductQuantity.text!)
            self.changeQuantityTapped = true
            self.wsUpdateProduct(qty: String(txtChangeProductQuantity.text ?? "0.0"), productID: self.arrProductsInfo[seletectedCartIndex].id , priceRangeID: self.arrProductsInfo[seletectedCartIndex].priceRangeID)
        }
    }
    
    @IBAction func deliveryPopUpClose(_ sender: Any) {
        self.bckView.isHidden = true
        self.popupDeliveryScheduleView.isHidden = true
    }
    
    @IBAction func deliveryInfoAction(_ sender: Any) {
        self.bckView.isHidden = false
        self.popupDeliveryScheduleView.isHidden = false
    }
    @IBAction func markAsReadAction(_ sender: Any) {
        self.bckView.isHidden = false
        self.vwNotes.isHidden = false
        self.lblNotesPopupTitle.text = "Add Notes"
    }
    
    @IBAction func btnPayNow(_ sender: Any) {
        if userType == 1, buyerType == "individual", self.arrCartListResponse.count > 0 {
            let cartItemDetails = self.arrCartProductListResponse[0]
            if let paymentInfo = cartItemDetails.totalPayableAmount, let payableAmount: Double = Double(paymentInfo.rawValue) , payableAmount > 0 {
                paymentChecking(payableAmount: totalConsoldatedAmount)
            } else {
                wsProcessCart()
            }
        }
    }
    func btnPayNowToggle() {
        for element in arrCartProductListResponse {
            if element.rejectMinOrderValue == "1" {
                if element.minOrderValue.doubleValue() > element.totalPayableAmount?.rawValue.doubleValue() ?? 0.0 {
                    self.payNow.isHidden = true
                    if element.id == self.id {
                        self.minimumOrderLabel.text = "Minimum value is \(element.minOrderValue.doubleValue())"
                        self.payNow.isHidden = true
                        self.minimumOrderLabel.isHidden = false
                        break
                    }
                }else{
                    self.payNow.isHidden = false
                    self.minimumOrderLabel.isHidden = true
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
    
}
//This function are used for paymentChecking
extension OrderDetailsViewController{
    func paymentChecking(payableAmount: Double){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            hideLoader()
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        showLoader()
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.pricingCheck
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
        }
        do{
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                hideLoader()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                }
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                }
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
        
        let billingDetails = PaymentSDKBillingDetails(name: self.billingAddress["name"],
                                                      email: self.billingAddress["email"],
                                                      phone: self.billingAddress["phone"],
                                                      addressLine: self.billingAddress["addresss"],
                                                      city: self.billingAddress["city"],
                                                      state: self.billingAddress["state"],
                                                      countryCode: self.billingAddress["countryCode"],
                                                      zip: self.billingAddress["zip"])
        
        let shippingDetails = PaymentSDKShippingDetails(name: self.shippingAddress["name"],
                                                        email: self.shippingAddress["email"],
                                                        phone: self.shippingAddress["phone"],
                                                        addressLine: self.shippingAddress["addresss"],
                                                        city: self.shippingAddress["city"],
                                                        state: self.shippingAddress["state"],
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
        sdkConfig.profileID = payTabsPaymentProfileID
        if payableAmount > 0, !self.payTabsPaymentProfileID.isEmpty {
            sdkConfig.profileID = self.payTabsPaymentProfileID
            PaymentManager.startCardPayment(on: self, configuration: sdkConfig, delegate: self)
        }
    }
    
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
                   //     self.view.makeToast("Error: Unable to create order")
                    }
                }
            }
        } else if let error = error {
           // self.view.makeToast(Constants.AlertMessage.error)
            print(error)
        }
    }
    //This methhod is used for invoking the payment traction
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
                        self.paymentsCallingCount = self.paymentsCallingCount + 1
                        if self.paymentsCallingCount == self.arrCartProductListResponse.count {
                            let alert = UIAlertController(title: "Message", message: responseMessage, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                                let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
                                dashboardvc?.selectedIndex = 1
                                Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
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
//This method is to create the table view
extension OrderDetailsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == productsTableView{
            return arrProductsInfo.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == productsTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell", for: indexPath)as? OrderDetailsTableViewCell
            cell?.productName.text      = arrProductsInfo[indexPath.row].productName
            cell?.productCostlabel.text = "AED  \(arrProductsInfo[indexPath.row].costPrice?.rawValue ?? "0")"
            cell?.prodctIDLabel.text     = arrProductsInfo[indexPath.row].productCode?.rawValue
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrProductsInfo[indexPath.row].productImage)")
            cell?.productImage.kf.indicatorType = .activity
            cell?.productImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: nil)
            cell?.productCountLabel.text = arrProductsInfo[indexPath.row].rQty?.rawValue
            if self.arrProductsInfo[indexPath.row].type?.rawValue == "2.0" {
                cell?.packagesNameLabel.text = "\(self.arrProductsInfo[indexPath.row].option?.rawValue ?? "")"
            } else {
                cell?.packagesNameLabel.text = "\(self.arrProductsInfo[indexPath.row].displaySkuName?.rawValue ?? "")"
            }
            cell?.plusButton.tag = indexPath.row
            cell?.plusButton.addTarget(self , action:#selector(btnAddClicked(sender:)), for: .touchUpInside)
            cell?.minusButton.tag = indexPath.row
            cell?.minusButton.addTarget(self , action:#selector(btnRemoveClicked), for: .touchUpInside)
            if displayChangeQty{
                cell?.plusMinusStackview.isHidden = false
                cell?.receivedQtyLabel.text = "Received Qty:"
            }else{
                cell?.plusMinusStackview.isHidden = true
                cell?.receivedQtyLabel.text = "Received Qty:\(arrProductsInfo[indexPath.row].rQty?.rawValue ?? "")"
            }
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
            cell?.productCountLabel.tag = indexPath.row
            cell?.productCountLabel.isUserInteractionEnabled = true
            cell?.productCountLabel.addGestureRecognizer(labelTap)
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryScheduleTblCell", for: indexPath as IndexPath) as? DeliveryScheduleTblCell
            cell?.lbldays.text = "\(arrdeliverySchedule[indexPath.row].days?.intValue ?? 0)"
            cell?.lblDelivery.text = arrdeliverySchedule[indexPath.row].deliver?.rawValue
            if indexPath.row % 2 == 0 {
                cell?.backgroundColor = .whiteEleven
            } else {
                cell?.backgroundColor = .white
            }
            return cell ?? UITableViewCell()
        }
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        seletectedCartIndex = sender.view?.tag ?? 0
        print(seletectedCartIndex)
        self.txtChangeProductQuantity.text      = arrProductsInfo[seletectedCartIndex].rQty?.rawValue
        self.bckView.isHidden                   = false
        self.chnageProductQuantityView.isHidden = false
    }
    
    @objc func deleteButton(sender:UIButton) {
        wsDeleteProduct(productID: self.arrProductsInfo[sender.tag].id, priceRangeID: self.arrProductsInfo[sender.tag].priceRangeID)
    }
    
    @objc func editbutton(sender:UIButton) {
        self.isEditProduct                          = true
        self.bckView.isHidden                        = false
        self.customProductView.isHidden             = false
        selectedProductID                           = self.arrProductsInfo[sender.tag].id
        selectedPriceRangeID                        = self.arrProductsInfo[sender.tag].priceRangeID
        self.txtCustomProductName.text              = self.arrProductsInfo[sender.tag].productName
        self.txtCustomSKU.text                      = self.arrProductsInfo[sender.tag].option?.rawValue
        self.txtCustomProductPrice.text             = "\(self.arrProductsInfo[sender.tag].pricePerUnit?.rawValue ?? "0")"
        self.txtCustomProductQty.text               = "\(self.arrProductsInfo[sender.tag].rQty?.intValue ?? 0)"
        self.txtCustomProductDesc.text              = self.arrProductsInfo[sender.tag].notes?.rawValue
    }
    @objc func btnRemoveClicked(sender:UIButton) {
        let cell: OrderDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0))as? OrderDetailsTableViewCell)
        guard let presentValue = Double((cell?.productCountLabel.text)!) else { return }
        if presentValue >= 1{
            let newValue:Double = presentValue - 1
            if newValue >= 1{
                cell?.productCountLabel.text = String(newValue)
                wsUpdateProduct(qty: String(newValue), productID: self.arrProductsInfo[sender.tag].id, priceRangeID: self.arrProductsInfo[sender.tag].priceRangeID)
            }
        }
    }
    
    @objc func btnAddClicked(sender:UIButton) {
        let cell: OrderDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0))as? OrderDetailsTableViewCell)
        guard let presentValue = Double((cell?.productCountLabel.text)!) else { return }
        let newValue = presentValue + 1
        cell?.productCountLabel.text = String(newValue)
        count = count + 1
        wsUpdateProduct(qty: String(newValue), productID: self.arrProductsInfo[sender.tag].id, priceRangeID: self.arrProductsInfo[sender.tag].priceRangeID)
        
    }
    @objc func btnOrderNotes(sender:UIButton) {
        
    }
}


extension OrderDetailsViewController{
    // MARK: - API call
    //This method is used for invoking the processCartURL
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
                                    
                                    self.navigationController?.popViewController(animated: true)
                                } else  {
                                    if let objPlacedOrderVC = mainStoryboard.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController {
                                        self.navigationController?.pushViewController(objPlacedOrderVC, animated: true)
                                    }
                                }
                            }))
                            self.present(alert, animated: true) {
                                DispatchQueue.main.async {
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
    //This methods is used for invoking the order view
    func wsOrderBuyerListView(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "\(allorderApiCalling ? "order_id":"draft_order_id")=\(orderId)"
        APICall().post(apiUrl: allorderApiCalling ? Constants.WebServiceURLs.OrderBuyerListViewURL : Constants.WebServiceURLs.PendingOrderListViewURL , requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                hideLoader()
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(PlacedOrderViewResponseModel.self, from: responseData as! Data)
                        if response.success == "1" {
                            self.arrLogs.removeAll()
                            self.orderResponse = response.data?.order
                            self.invoiceResponse = response.data?.invoiceStatus
                            self.arrProductsInfo = response.data?.order?.productsInfo ?? [ProductsInfo]()
                            self.arrLogs.append(contentsOf: response.data?.order!.logs ?? [])
                            if self.arrProductsInfo.count == 0 {
                                self.showCustomAlert(message: "No records found.",isSuccessResponse: false)
                                self.nodataLabel.isHidden = false
                                self.nodataView.isHidden = false
                                self.nodataLabel.text = "No records found."
                                return
                            }
                            let date = response.data?.order?.deliveryRequested.deliveryDate?.rawValue
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .medium
                            dateFormatter.dateFormat = "dd/MM/yyyy"
                            let StringDate = dateFormatter.date(from: date ?? "")
                            dateFormatter.dateFormat = "dd/MM/yyyy"
                            let dateString = dateFormatter.string(from: StringDate ?? Date())
                            self.deliverydateTextField.text = dateString
                            self.continueShoppingButtonButton.isHidden = true
                            if self.orderResponse?.paidStatus == 20 {
                                self.paymentStatus = "Paid"
                                self.paidLabel.text = "Paid"
                                self.paymentStatusBottomlabel.text = "Paid"
                                self.paidLabel.textColor = .white
                                self.paidLabel.backgroundColor = UIColor(hexFromString: "#36B152")
                                self.paidLabel.borderColor = UIColor(hexFromString: "#36B152")
                                self.paidLabel.borderWidth = 0
                            } else {
                                self.payNow.isHidden = false
                                if self.orderResponse?.supplierID == "5fe9bd17e01343382c2ada9e"  {
                                    self.paidLabel.text = self.orderResponse?.statusName.rawValue
                                    self.paymentStatus = "Pay Now"
                                    self.paidLabel.text = "Pay Now"
                                    self.paidLabel.textColor = .white
                                    self.paidLabel.backgroundColor = .gray
                                    self.paidLabel.borderColor = .gray
                                    self.paymentStatusBottomlabel.text = "Pay Now"
                                } else {
                                    self.paidLabel.text = self.orderResponse?.statusName.rawValue
                                    self.paymentStatus = "Not Paid"
                                    self.paidLabel.text = "Not Paid"
                                    self.paymentStatusBottomlabel.text = "Not Paid"
                                    self.paidLabel.backgroundColor = .red
                                    self.paidLabel.textColor = .white
                                    self.paidLabel.borderColor = .red
                                }
                            }
                            if self.orderResponse?.status?.intValue == 33 || self.orderResponse?.status?.intValue == 35{
                                self.payNow.isHidden = true
                                self.markAsReadbutton.isHidden = false
                                self.displayChangeQty = true
                            } else {
                                self.displayChangeQty = false
                                self.payNow.isHidden = true
                                self.markAsReadbutton.isHidden = true
                            }
                            self.amountLabel.text = self.orderResponse?.totalPayableAmount.rawValue
                            self.itemsCountLabel.text = ("\(self.arrProductsInfo.count)")
                            self.orderNumberLabel.text = "Order No: \(self.orderResponse?.uniqueName ?? "")"
                            self.emailSentLabel.text = self.orderResponse?.statusName.rawValue
                            self.outletNameLabel.text  = self.orderResponse?.supplierInfo.supplierName?.rawValue
                            self.addressNameLabel.text = self.orderResponse?.supplierInfo.supplierAddress?.rawValue
                            self.createdDateLabel.text = "Created On \(self.orderResponse?.createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy") ?? "")"
                            if response.data?.order?.notes?.rawValue == nil {
                                self.suppliernotesLabel.isHidden = true
                                self.addNotesButton.setTitle("Add Notes", for: .normal)
                            }else{
                                self.suppliernotesLabel.text = self.arrCartProductListResponse[self.seletectedCartIndex].notes?.rawValue
                                self.suppliernotesLabel.isHidden = false
                                self.addNotesButton.setTitle("Edit Notes", for: .normal)
                            }
                            DispatchQueue.main.async {
                                self.billingAddressLabel.text = self.orderResponse?.billingAddress
                                self.deliveryAddressLabel.text = self.orderResponse?.deliveryAddress
                                self.estimatedSubTotalLabel.text = "AED  \(self.orderResponse?.totalNetAmount.rawValue ?? "0")"
                                self.vatPercentageLabel.text = "AED \(self.orderResponse?.vatAmount.rawValue ?? "0")"
                                self.exstimatedDeliveryFeeLabel.text = "AED \(self.orderResponse?.vatAmount.rawValue ?? "0")"
                                self.estimatedTotalLabel.text = "AED \(self.orderResponse?.totalPayableAmount.rawValue ?? "0")"
                            }
                            if let profileId = self.orderResponse?.supplierInfo.supplierProfileID?.rawValue, profileId != ""  {
                                self.payTabsPaymentProfileID = profileId
                            } else {
                                self.payTabsPaymentProfileID = ""
                            }
                            self.delegateSetup()
                            self.nodataLabel.isHidden = true
                            self.nodataView.isHidden = true
                        }else{
                            self.showCustomAlert(message: response.message)
                            self.nodataLabel.isHidden = false
                            self.nodataView.isHidden = false
                            self.nodataLabel.text = response.message
                        }
                    } catch let err {
                        print("Session Err \(err)")
                        print("Session Error: ",err)
                        self.showCustomAlert(message: "No records found.",isSuccessResponse: false)
                        self.nodataLabel.isHidden = false
                        self.nodataView.isHidden = false
                        self.nodataLabel.text = "No records found."
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)          }
            }
        }
    }
    
    // mark as read
    func wsCompletedOrder(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "order_id=\(orderId)&notes=\(self.txtPopupNotes.text ?? "")"
        APICall().post(apiUrl: Constants.WebServiceURLs.OrderCompletedURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                hideLoader()
                if success{
                    self.bckView.isHidden = true
                    self.vwNotes.isHidden = true
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        DispatchQueue.main.async {
                            self.wsOrderBuyerListView()
                            
                        }                    }catch let err {
                            print("Session Error: ",err)
                        }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    func wsProductNotes(notes :String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(cartID)&notes=\(notes)&product_id=\(selectedProductID)&price_range_id=\(selectedPriceRangeID)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.cartProductNotesURL, requestPARAMS: postString, isTimeOut: false) {
            (success, responseData) in DispatchQueue.main.async {
                let processedResponse: JSON = JSON(responseData)
                if success, processedResponse != JSON.null {
                    self.showCustomAlert(message: processedResponse["message"].stringValue)
                    self.bckView.isHidden = true
                    self.vwNotes.isHidden = true
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoke the API carts supplier notes
    func wsSupplierNotes(notes :String) {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(cartID)&notes=\(notes)"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartSupplierNotesURL, requestPARAMS: postString, isTimeOut: false) {
            (success, responseData) in DispatchQueue.main.async {
                let processedResponse: JSON = JSON(responseData)
                if success, processedResponse != JSON.null {
                    self.showCustomAlert(message: processedResponse["message"].stringValue)
                    self.bckView.isHidden = true
                    self.vwNotes.isHidden = true
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This methos is used for upadting the delivery date
    func wsDeliveryDateAvailability(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "order_id=\(orderId)&delivery_date=\(deliverydateTextField.text ?? "")"
        APICall().post(apiUrl: Constants.WebServiceURLs.UpdateDeliveryDateURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.bckView.isHidden = true
                        self.vwNotes.isHidden = true
                        self.wsOrderBuyerListView()
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This methos is used for upadting the delivery address
    func wsDeliveryAddress(notes :String) {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(cartID)&delivery_address=\(notes)"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartDeliveryAddressURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                let processedResponse: JSON = JSON(responseData) ?? JSON()
                if success, processedResponse != JSON.null {
                  //  self.view.makeToast(processedResponse["message"].stringValue)
                    self.bckView.isHidden = true
                    self.vwNotes.isHidden = true
                    self.wsOrderBuyerListView()
                } else {
              //      self.view.makeToast(Constants.AlertMessage.error)
                }
            }
        }
    }
    //This methos is used for upadting the product quantity
    func wsUpdateProduct(qty : String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.changeQuantityTapped = false
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "order_id=\(orderId)&product_id=\(productID)&price_range_id=\(priceRangeID)&r_qty=\(qty)"
        var updatedarrCartListResponse = [UpdateProductCart]()
        APICall().post(apiUrl: Constants.WebServiceURLs.UpdateReceivedQtyURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        if dicResponseData.success == "1" {
                            self.wsOrderBuyerListView()
                        } else {
                            self.showCustomAlert(message: dicResponseData.message)
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This methos is used for deleting the product
    func wsDeleteProduct(productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "order_id=\(orderId)&product_id=\(productID)&price_range_id=\(priceRangeID)"
        APICall().post(apiUrl: Constants.WebServiceURLs.DeleteProductbySupplierURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.wsOrderBuyerListView()
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This methos is used for upadting custom product
    func wsUpdateCustomProduct(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let str = txtCustomProductPrice.text != "0" ? txtCustomProductPrice.text : "0"
        let postString = "cart_id=\(cartID)&name=\(txtCustomProductName.text ?? "")&description=\(txtCustomProductDesc.text ?? "")&option=\(txtCustomSKU.text ?? "")&quantity=\(txtCustomProductQty.text ?? "")&price=\(str ?? "0")&product_id=\(selectedProductID)&price_range_id=\(selectedPriceRangeID)"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartUpdateCustomProductURL, requestPARAMS: postString, isTimeOut: false) {
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UpdateProductCartModel.self, from: responseData as! Data)
                        self.isEditProduct = false
                        self.bckView.isHidden = true
                        self.customProductView.isHidden = true
                        self.showCustomAlert(message: dicResponseData.message)
                    } catch let err {
                        print("Session Error: ",err)
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This methos is used for Adding  the Custom product
    func wsAddCustomProduct() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let str = txtCustomProductPrice.text != "0" ? txtCustomProductPrice.text : "0"
        let postString = "cart_id=\(cartID)&name=\(txtCustomProductName.text ?? "")&description=\(txtCustomProductDesc.text ?? "")&option=\(txtCustomSKU.text ?? "")&quantity=\(txtCustomProductQty.text ?? "")&price=\(str ?? "0")"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartAddCustomProductURL, requestPARAMS: postString, isTimeOut: false) {
            (success, responseData) in DispatchQueue.main.async {
                let processedResponse: JSON = JSON(responseData)
                if success, processedResponse != JSON.null {
                    self.bckView.isHidden = true
                    self.customProductView.isHidden = true
                    self.showCustomAlert(message: processedResponse["message"].stringValue)
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
}
//This methos is used for download report location
extension OrderDetailsViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsUrl : URL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)!
        var destinationURL = documentsUrl.appendingPathComponent("\(self.orderResponse?.uniqueName ?? "")")
        destinationURL.appendPathExtension("pdf")
        try? FileManager.default.removeItem(at: destinationURL)
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            print("Success creating a file \(destinationURL) : \(destinationURL)")
            hideLoader()
            DispatchQueue.main.async {
                self.showToast(message: "Download successful")
            }
        } catch (let writeError) {
            print("Error creating a file \(destinationURL) : \(writeError)")
            hideLoader()
            DispatchQueue.main.async {
                self.showToast(message: "Error while downloading")
            }
        }
    }
}
