//
//  MyCartDetailsViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 31/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON
import PaymentSDK

class MyCartDetailsViewController: UIViewController ,PaymentManagerDelegate{
    
    @IBOutlet weak var backbutton               : UIButton!
    @IBOutlet weak var screenTitleLabel         : UILabel!
    @IBOutlet weak var supplierImage            : UIImageView!
    @IBOutlet weak var outletNameLabel          : UILabel!
    @IBOutlet weak var supplierNameLabel        : UILabel!
    @IBOutlet weak var totalNumberCountLabel    : UILabel!
    @IBOutlet weak var outletNumberCountLabel   : UILabel!
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
    @IBOutlet weak var cutOffTaleView           : UITableView!
    @IBOutlet weak var selectButton             : UIButton!
    @IBOutlet weak var daysViewHeightConstriant : NSLayoutConstraint!
    @IBOutlet weak var bckView                  : UIView!
    @IBOutlet weak var vwNotes                  : UIView!
    @IBOutlet weak var txtPopupNotes            : UITextField!
    @IBOutlet weak var lblNotesPopupTitle       : UILabel!
    @IBOutlet weak var btnSubmitPopupNotes      : UIButton!
    @IBOutlet weak var supplierNotesView        : UIView!
    @IBOutlet weak var suppliernotesLabel       : UILabel!
    @IBOutlet weak var supllierNotesTitle       : UILabel!
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
    @IBOutlet weak var tblDeliverySchedule      : UITableView!
    @IBOutlet weak var popupDeliveryScheduleView: UIView!
    @IBOutlet weak var continueShoppingButtonButton: UIButton!
    @IBOutlet weak var minimumOrderLabel        : UILabel!
    @IBOutlet weak var payNow                   : UIButton!
    @IBOutlet weak var addresspopUpView         : UIView!
    @IBOutlet weak var addressTableView         : UITableView!
    @IBOutlet weak var addressTableViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var deliveryAddressView      : UIView!
    @IBOutlet weak var noteAndBillingHeight     : NSLayoutConstraint!
    @IBOutlet weak var billingAddressView       : UIView!
    @IBOutlet weak var deliveryDateView         : UIView!
    @IBOutlet weak var deliveryHeight: NSLayoutConstraint!
    @IBOutlet weak var noteAndBillingStack: UIStackView!
    @IBOutlet weak var AddSpecialProduct: UIButton!
    @IBOutlet weak var specialProductHeight: NSLayoutConstraint!
    @IBOutlet weak var deliveryDateHeight: NSLayoutConstraint!
    @IBOutlet weak var ButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var estimateTable: UIView!
    @IBOutlet weak var SupplierNoteHeight: NSLayoutConstraint!
    @IBOutlet weak var BillingNoteHeight: NSLayoutConstraint!
    @IBOutlet weak var delivarydatetop: NSLayoutConstraint!
    @IBOutlet weak var deliveryAddressTop: NSLayoutConstraint!
    @IBOutlet weak var estimateTableTop: NSLayoutConstraint!
    
    var selectedIndexPathAddress       = IndexPath(row: 0, section: 0)
    var arrSupplierList                = [GetMyfavouriteList]()
    var id                             = String()
    var arrCartListResponse            = [CartListResponse]()
    var arrProductsInfo                = [ProductsInfo]()
    var arrCartProductListResponse     = [Cart]()
    var cartID                         = String()
    var supplierID                     = String()
    var arrdeliverySchedule            = [DeliverySchedule]()
    var singleCartProduct              : Cart?
    var selectedPriceRangeID           = String()
    var selectedProductID              = String()
    var count                          = -1
    var seletectedCartIndex            = 0
    var weekendDates                   = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var isEditProduct                       = false
    var attrs = [
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 10) ?? UIFont.systemFont(ofSize: 19.0),
        NSAttributedString.Key.foregroundColor : UIColor(hexFromString: "#EC187B"),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
    var addSpecialProductButtonString       = NSMutableAttributedString(string:"")
    var addnotesButtonString                = NSMutableAttributedString(string:"")
    var changeQuantityTapped                = false
    var totalConsoldatedAmount              = 0.0
    var userType: Int                       = USERDEFAULTS.getDataForKey(.user_type) as? Int ?? 0
    var buyerType: String                   = USERDEFAULTS.getDataForKey(.buyerType) as? String ?? ""
    var billingAddress: [String: String]    = [:]
    var shippingAddress: [String: String]   = [:]
    var payTabsPaymentProfileID: String     = ""
    var paymentsCallingCount                = 0
    var arrOutletList                       = [OutletListResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            self.tabBarController?.tabBar.isHidden = true
            noteAndBillingHeight.constant = 0
            deliveryHeight.constant = 0
            deliveryDateHeight.constant = 0
            specialProductHeight.constant = 0
            ButtonHeight.constant = 0
            SupplierNoteHeight.constant = 0
            BillingNoteHeight.constant = 0
            delivarydatetop.constant = 0
            deliveryAddressTop.constant = 0
            estimateTableTop.constant = 0
            supplierNotesView.isHidden = true
            deliveryAddressView.isHidden = true
            billingAddressView.isHidden = true
            deliveryDateView.isHidden = true
            noteAndBillingStack.isHidden = true
            bckView.isHidden   = true
            registerXibs()
            UIElementsSetUp()
            wsCartGet()
            textSetup()
        }else{
            self.tabBarController?.tabBar.isHidden = true
            bckView.isHidden   = true
            registerXibs()
            UIElementsSetUp()
            wsCartGet()
            textSetup()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func UIElementsSetUp(){
        let bgviewTap = UITapGestureRecognizer(target: self, action: #selector(self.bgViewTapped(_:)))
        bckView.isUserInteractionEnabled = true
        bckView.addGestureRecognizer(bgviewTap)
        let supplierLabel = UITapGestureRecognizer(target: self, action: #selector(self.showAddressView(_:)))
        supplierNameLabel.isUserInteractionEnabled = true
        supplierNameLabel.addGestureRecognizer(supplierLabel)
        self.addresspopUpView.isHidden = true
        self.addSpecialProductButton.isHidden = true
        self.payNow.isHidden = false
        self.minimumOrderLabel.isHidden = true
        productsTableView.backgroundView?.backgroundColor = .clear
        productsTableView.backgroundColor                 = .clear
        bckView.isHidden                                   = true
        bckView.alpha = 0.6
        bckView.backgroundColor = .black
        vwNotes.isHidden                                  = true
        daysViewHeightConstriant.constant                 = 0
        deliverydateTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.productsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        productsTableView.layer.removeAllAnimations()
        productTableViewHeight.constant = self.productsTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    @objc func bgViewTapped(_ sender: UITapGestureRecognizer) {
        self.addresspopUpView.isHidden = true
        self.bckView.isHidden = true
    }
    @objc func showAddressView(_ sender: UITapGestureRecognizer) {
        let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
        objItemDetailVC.supplierID = supplierID
        print(supplierID)
        objItemDetailVC.strImage = (self.arrCartProductListResponse[seletectedCartIndex].supplierInfo.profile?.rawValue ?? "")
        objItemDetailVC.strTitle = (self.arrCartProductListResponse[seletectedCartIndex].supplierInfo.supplierName?.rawValue ?? "")
        objItemDetailVC.strAddress = "\(self.arrCartProductListResponse[seletectedCartIndex].supplierInfo.supplierAddress?.rawValue ?? "")\(self.arrCartProductListResponse[seletectedCartIndex].supplierInfo.city?.rawValue ?? ""),\(self.arrCartProductListResponse[seletectedCartIndex].supplierInfo.country?.rawValue ?? "")"
        self.navigationController?.pushViewController(objItemDetailVC, animated: true)
    }
    @objc func doneButtonPressed() {
        if let  datePicker = self.deliverydateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd-MM-yyyy"
            if  #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            self.deliverydateTextField.text = dateFormatter.string(from: datePicker.date)
            print(deliverydateTextField.text)
        }
        self.deliverydateTextField.resignFirstResponder()
        wsDeliveryDateAvailability()
    }
    func delegateSetup(){
        productsTableView.delegate   = self
        productsTableView.dataSource = self
        productsTableView.reloadData()
        tblDeliverySchedule.delegate   = self
        tblDeliverySchedule.dataSource = self
        tblDeliverySchedule.reloadData()
    }
    func textSetup(){
        addSpecialProductButtonString.append(NSMutableAttributedString(string:"Add Special Product", attributes:attrs))
        addSpecialProductButton.setAttributedTitle(addSpecialProductButtonString, for: .normal)
    }
    func registerXibs(){
        productsTableView.register(UINib.init(nibName: "CartDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CartDetailsTableViewCell")
        cutOffTaleView.register(UINib.init(nibName: "CutOffTableViewCell", bundle: nil), forCellReuseIdentifier: "CutOffTableViewCell")
        addressTableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        self.tblDeliverySchedule.tableFooterView = UIView()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deliveryAddressButton(_ sender: Any) {
        wsOutlet()
        self.bckView.isHidden = false
        self.addresspopUpView.isHidden = false
    }
    
    @IBAction func deliveryDateButtonAction(_ sender: Any) {
        deliverydateTextField.becomeFirstResponder()
    }
    
    @IBAction func selectAllAction(_ sender: Any) {
    }
    
    @IBAction func addSpecialProductAction(_ sender: Any) {
        self.bckView.isHidden                = false
        self.customProductView.isHidden     = false
        self.clearAndResignTextFields()
    }
    
    @IBAction func addnotesAction(_ sender: Any) {
        self.bckView.isHidden = false
        self.vwNotes.isHidden = false
        self.lblNotesPopupTitle.text = "Supplier Notes"
        if self.arrCartProductListResponse[seletectedCartIndex].notes?.rawValue != nil {
            self.txtPopupNotes.text = self.arrCartProductListResponse[seletectedCartIndex].notes?.rawValue
        } else {
            self.txtPopupNotes.text = ""
        }
    }
    
    @IBAction func continueShoppingBottombutton(_ sender: Any) {
        let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchText =  ""
        searchVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    
    @IBAction func btnSubmitPopupNotes(_ sender: Any) {
        print(cartID)
        if self.lblNotesPopupTitle.text == "Product Notes" {
            self.wsProductNotes(notes: self.txtPopupNotes.text ?? "")
            self.txtPopupNotes.resignFirstResponder()
        } else if self.lblNotesPopupTitle.text == "Supplier Notes" {
            self.txtPopupNotes.resignFirstResponder()
            self.wsSupplierNotes(notes: self.txtPopupNotes.text ?? "")
        } else {
            self.txtPopupNotes.resignFirstResponder()
            self.wsDeliveryAddress(notes: self.txtPopupNotes.text ?? "")
        }
    }
    
    @IBAction func btnClosePopupNotesAct(_ sender: Any) {
        self.bckView.isHidden = true
        self.vwNotes.isHidden = true
        self.clearAndResignTextFields()
    }
    //This method is used for vallidations purpose
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
            let cell: CartDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: seletectedCartIndex, section: 0))as? CartDetailsTableViewCell)
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
    
    @IBAction func btnPayNow(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            dashboardVC.modalPresentationStyle = .fullScreen
        }else{
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
//This method is used for payment checking
extension MyCartDetailsViewController {
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
        //Error showing in my cart Billing InvalidPhoneNumber
        var billingPhoneNumber = "9090909090"
        if ((self.billingAddress["phone"]) == nil || (self.billingAddress["phone"]) == "") {
            billingPhoneNumber = /*self.billingAddress["phone"] ??*/ "9090909090"
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
        sdkConfig.profileID = payTabsPaymentProfileID
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
            //below commented code for payment status
            //      if (transactionDetails.paymentResult?.responseStatus == "A") {
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
                     //   self.view.makeToast("Error: Unable to create order")
                    }
                    
                }
            }
            //         }
            //            else if (transactionDetails.paymentResult?.responseStatus == "D") {
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
            self.showCustomAlert(message:Constants.AlertMessage.error, isSuccessResponse: false)
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
                        self.paymentsCallingCount = self.paymentsCallingCount + 1
                        if self.paymentsCallingCount == self.arrCartProductListResponse.count {
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
    //This method is used for invoking the outlets API
    func wsOutlet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        
        let paramStr = "\(Constants.WebServiceParameter.paramBuyerId)=\(USERDEFAULTS.getDataForKey(.user_type_id))"
        APICall().post(apiUrl: Constants.WebServiceURLs.outletListURL, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(OutletListResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.arrOutletList = dicResponseData.data!
                            self.addressTableView.delegate = self
                            self.addressTableView.dataSource = self
                            self.addressTableView.reloadData()
                            
                            if self.arrOutletList.count >= 10 {
                                self.addressTableViewHeightConstraint.constant = 500
                            }else{
                                self.addressTableViewHeightConstraint.constant = CGFloat(self.arrOutletList.count * 60)
                                self.deliveryAddressLabel.text = "\(self.arrOutletList[self.selectedIndexPathAddress.row].outletName) \(self.arrOutletList[self.selectedIndexPathAddress.row].address) \(self.arrOutletList[self.selectedIndexPathAddress.row].area)\(self.arrOutletList[self.selectedIndexPathAddress.row].country)"
                            }
                        } else {
                            self.showToast(message: dicResponseData.message)
                        }
                        
                    }catch let err {
                        print("Session Error: ",err)
                    }
                } else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
        
    }
}


// MARK: -table view delegate functions
//This method is used for create the table cell
extension MyCartDetailsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cutOffTaleView{
            return 7
        }else if tableView == productsTableView{
            return arrProductsInfo.count
        }else if tableView == addressTableView{
            return arrOutletList.count
        } else{
            return self.arrCartProductListResponse[seletectedCartIndex].deliverySchedule?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == cutOffTaleView{
            return 60
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == productsTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartDetailsTableViewCell", for: indexPath)as? CartDetailsTableViewCell
            cell?.productName.text      = arrProductsInfo[indexPath.row].productName
            cell?.productCostlabel.text = "AED  \(arrProductsInfo[indexPath.row].costPrice?.rawValue ?? "0")"
            cell?.prodctIDLabel.text     = arrProductsInfo[indexPath.row].productCode?.rawValue
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrProductsInfo[indexPath.row].productImage)")
            cell?.productImage.kf.indicatorType = .activity
            cell?.productImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: nil)
            cell?.productCountLabel.text = arrProductsInfo[indexPath.row].qty?.rawValue
            if self.arrProductsInfo[indexPath.row].notes?.rawValue == nil {
                cell?.notesLabel.isHidden = true
                cell?.addNotestitle(title: "Edit")
                cell?.notesLabel.text  = ""
            }else{
                cell?.notesLabel.isHidden = false
                cell?.notesLabel.text     = self.arrProductsInfo[indexPath.row].notes?.rawValue
                cell?.addNotestitle(title: "Edit Notes")
            }
            if self.arrProductsInfo[indexPath.row].type?.rawValue == "2.0" {
                cell?.packagesNameLabel.text = "\(self.arrProductsInfo[indexPath.row].option?.rawValue ?? "")"
                cell?.editButton.isHidden = false
                
            } else {
                cell?.packagesNameLabel.text = "\(self.arrProductsInfo[indexPath.row].displaySkuName?.rawValue ?? "")"
                cell?.editButton.isHidden = true
                
            }
            cell?.addNotesButton.tag = indexPath.row
            cell?.addNotesButton.addTarget(self , action:#selector(btnOrderNotes), for: .touchUpInside)
            cell?.plusButton.tag = indexPath.row
            cell?.plusButton.addTarget(self , action:#selector(btnAddClicked(sender:)), for: .touchUpInside)
            cell?.minusButton.tag = indexPath.row
            cell?.minusButton.addTarget(self , action:#selector(btnRemoveClicked), for: .touchUpInside)
            cell?.editButton.tag = indexPath.row
            cell?.editButton.addTarget(self , action:#selector(editbutton), for: .touchUpInside)
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self , action:#selector(deleteButton), for: .touchUpInside)
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
            cell?.productCountLabel.tag = indexPath.row
            cell?.productCountLabel.isUserInteractionEnabled = true
            cell?.productCountLabel.addGestureRecognizer(labelTap)
            return cell ?? UITableViewCell()
        }else if tableView == cutOffTaleView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CutOffTableViewCell", for: indexPath)as? CutOffTableViewCell
            cell?.dayLabel.text     = weekendDates[indexPath.row]
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as? AddressTableViewCell
            cell?.addressLabel.text = "\(self.arrOutletList[indexPath.row].outletName) \(self.arrOutletList[indexPath.row].address) \(self.arrOutletList[indexPath.row].area) \(self.arrOutletList[indexPath.row].country)"
            cell?.selectButton.isUserInteractionEnabled = false
            if selectedIndexPathAddress == indexPath{
                cell?.selectButton.setImage(UIImage(named: "PinkRadio"), for: .normal)
            }else{
                cell?.selectButton.setImage(UIImage(named: "WhiteRadio"), for: .normal)
            }
            cell?.selectButton.tag = indexPath.row
            cell?.selectButton.addTarget(self , action:#selector(addressSelected(sender:)), for: .touchUpInside)
            return cell ?? UITableViewCell()
        }
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        seletectedCartIndex = sender.view?.tag ?? 0
        print(seletectedCartIndex)
        let cell: CartDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: self.seletectedCartIndex, section: 0))as? CartDetailsTableViewCell)
        self.txtChangeProductQuantity.text      = cell?.productCountLabel.text/*arrProductsInfo[seletectedCartIndex].qty?.rawValue*/
        self.bckView.isHidden                    = false
        self.chnageProductQuantityView.isHidden = false
    }
    
    @objc func deleteButton(sender:UIButton) {
        wsDeleteProduct(productID: self.arrProductsInfo[sender.tag].id, priceRangeID: self.arrProductsInfo[sender.tag].priceRangeID)
        showCustomAlert(message: "Product removed from cart")
    }
    @objc func addressSelected(sender:UIButton) {
        selectedIndexPathAddress = IndexPath(row: sender.tag, section: 0)
        outletID = arrOutletList[sender.tag].id
        addressTableView.reloadData()
    }
    
    @objc func editbutton(sender:UIButton) {
        self.isEditProduct                          = true
        self.bckView.isHidden                       = false
        self.customProductView.isHidden             = false
        selectedProductID                           = self.arrProductsInfo[sender.tag].id
        selectedPriceRangeID                        = self.arrProductsInfo[sender.tag].priceRangeID
        self.txtCustomProductName.text              = self.arrProductsInfo[sender.tag].productName
        self.txtCustomSKU.text                      = self.arrProductsInfo[sender.tag].option?.rawValue
        self.txtCustomProductPrice.text             = "\(self.arrProductsInfo[sender.tag].pricePerUnit?.rawValue ?? "0")"
        self.txtCustomProductQty.text               = "\(self.arrProductsInfo[sender.tag].qty?.intValue ?? 0)"
        self.txtCustomProductDesc.text              = self.arrProductsInfo[sender.tag].notes?.rawValue
    }
    @objc func btnRemoveClicked(sender:UIButton) {
        let cell: CartDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0))as? CartDetailsTableViewCell)
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
        let cell: CartDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0))as? CartDetailsTableViewCell)
        guard let presentValue = Double((cell?.productCountLabel.text)!) else { return }
        let newValue = presentValue + 1
        cell?.productCountLabel.text = String(newValue)
        count = count + 1
        wsUpdateProduct(qty: String(newValue), productID: self.arrProductsInfo[sender.tag].id, priceRangeID: self.arrProductsInfo[sender.tag].priceRangeID)
    }
    @objc func btnOrderNotes(sender:UIButton) {
        self.bckView.isHidden = false
        self.vwNotes.isHidden = false
        self.lblNotesPopupTitle.text = "Product Notes"
        self.txtPopupNotes.text = self.arrProductsInfo[sender.tag].notes?.rawValue
        selectedProductID = self.arrProductsInfo[sender.tag].id
        selectedPriceRangeID = self.arrProductsInfo[sender.tag].priceRangeID
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wsOutlet()
        selectedIndexPathAddress = indexPath
        self.bckView.isHidden = true
        self.addresspopUpView.isHidden = true
        addressTableView.reloadData()
    }
}


extension MyCartDetailsViewController{
    // MARK: - API call
    //This method is used for invoking process cart API
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
                                    self.wsCartGet()
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
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    //This method is used for Cart get API
    func wsCartGet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        print("get cart\(Constants.WebServiceURLs.cartListURL)")
        self.clearAndResignTextFields()
        self.arrCartListResponse.removeAll()
        APICall().get(apiUrl: Constants.WebServiceURLs.cartListURL){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(CartListResponseModel.self, from: responseData as! Data)
                        //success = true = 1 , unsuccess = false =0
                        if dicResponseData.success == "1" {
                            if let data = dicResponseData.data {
                                self.arrCartListResponse = [data]
                            }
                            if self.arrCartListResponse.count > 0 {
                                self.totalConsoldatedAmount = dicResponseData.data?.consolidatedPayableAmount ?? 0.0
                                self.arrCartProductListResponse = self.arrCartListResponse.first?.cart ?? [Cart]()
                                let singleDict = self.arrCartProductListResponse.firstIndex { single in
                                    return single.supplierID == self.supplierID
                                  
                                }
                                self.seletectedCartIndex = singleDict ?? 0
                                self.arrProductsInfo = self.arrCartProductListResponse[singleDict ?? 0].productsInfo ?? [ProductsInfo]()
                                self.arrdeliverySchedule = self.arrCartProductListResponse[singleDict ?? 0].deliverySchedule ?? [DeliverySchedule]()
                                
                                if self.arrProductsInfo.count == 0 {
                                    self.showCustomAlert(message: "No records found.",isSuccessResponse: false)
                                    self.nodataLabel.isHidden = false
                                    self.nodataView.isHidden = false
                                    self.nodataLabel.text = "No records found."
                                    return
                                }
                                self.totalNumberCountLabel.text = dicResponseData.data?.totalProductCount?.rawValue
                                self.id = self.arrCartProductListResponse[self.seletectedCartIndex ?? 0].id
                                self.supplierNameLabel.text = self.arrCartProductListResponse[singleDict ?? 0].supplierInfo.companyName?.rawValue
                                self.outletNameLabel.text = "Address \( self.arrCartProductListResponse[singleDict ?? 0].supplierInfo.supplierAddress?.rawValue ?? "")"
                                self.totalNumberCountLabel.text = "\(self.arrProductsInfo.count)"
                                self.amountLabel.text = "AED \( self.arrCartProductListResponse[singleDict ?? 0].totalPayableAmount?.rawValue ?? "")"
                                self.createdDateLabel.text = "Created On \(self.arrCartProductListResponse[singleDict ?? 0 ].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMMM-yyyy"))"
                                let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrCartProductListResponse[singleDict ?? 0].supplierInfo.profile?.rawValue ?? "")")
                                self.supplierImage.kf.indicatorType = .activity
                                self.supplierImage.kf.setImage(
                                    with: url,
                                    placeholder: UIImage(named: "ic_placeholder"),
                                    options: nil)
                                self.outletNumberCountLabel.text =  self.arrCartProductListResponse[singleDict ?? 0].buyerCompanyName ?? ""
                                self.billingAddressLabel.text = self.arrCartProductListResponse[singleDict ?? 0].billingAddress
                                self.deliveryAddressLabel.text = self.arrCartProductListResponse[singleDict ?? 0].deliveryAddress
                                let date = self.arrCartProductListResponse[singleDict ?? 0].deliveryRequested?.deliveryDate?.rawValue
                                print(date)
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateStyle = .medium
                                dateFormatter.dateFormat = "dd/MM/yyyy"
                                let StringDate = dateFormatter.date(from: date ?? "")
                                print(StringDate)
                                dateFormatter.dateFormat = "dd/MM/yyyy"
                                let dateString = dateFormatter.string(from: StringDate ?? Date())
                                print(dateString)
                                self.deliverydateTextField.text = (dateString)
                                if self.arrCartProductListResponse[singleDict ?? 0].notes?.rawValue == nil {
                                    self.suppliernotesLabel.isHidden = true
                                    self.addNotesButton.setTitle("Edit", for: .normal)
                                }else{
                                    self.suppliernotesLabel.text = self.arrCartProductListResponse[self.seletectedCartIndex].notes?.rawValue
                                    self.suppliernotesLabel.isHidden = false
                                    self.addNotesButton.setTitle("Edit Notes", for: .normal)
                                }
                                self.cartID =  self.arrCartProductListResponse[singleDict ?? 0].id
                                self.estimatedSubTotalLabel.text = "AED  \(self.arrCartProductListResponse[singleDict ?? 0].totalNetAmount?.rawValue ?? "0")"
                                self.vatPercentageLabel.text = "AED \(self.arrCartProductListResponse[singleDict ?? 0].vatAmount?.rawValue ?? "0")"
                                self.exstimatedDeliveryFeeLabel.text = "AED \(self.arrCartProductListResponse[singleDict ?? 0].deliveryFee?.rawValue ?? "0")"
                                self.estimatedTotalLabel.text = "AED \(self.arrCartProductListResponse[singleDict ?? 0].totalPayableAmount?.rawValue ?? "0")"
                                if let profileId = self.arrCartProductListResponse[0].supplierInfo.supplierProfileID?.rawValue, profileId != ""  {
                                    self.payTabsPaymentProfileID = profileId
                                } else {
                                    self.payTabsPaymentProfileID = ""
                                }
                                self.delegateSetup()
                                self.nodataLabel.isHidden = true
                                self.nodataView.isHidden = true
                            } else {
                                self.nodataLabel.isHidden = false
                                self.nodataView.isHidden = false
                                self.nodataLabel.text = dicResponseData.message
                            }
                            self.btnPayNowToggle()
                        } else {
                            self.showCustomAlert(message: dicResponseData.message)
                            self.nodataLabel.isHidden = false
                            self.nodataView.isHidden = false
                            self.nodataLabel.text = dicResponseData.message
                        }
                    } catch let err {
                        print("Session Error: ",err)
                        self.showCustomAlert(message: "No records found.",isSuccessResponse: false)
                        self.nodataLabel.isHidden = false
                        self.nodataView.isHidden = false
                        self.nodataLabel.text = "No records found."
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoking the  cart products note API
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
                    print(self.showCustomAlert(message: processedResponse["message"].stringValue))
                    self.bckView.isHidden = true
                    self.vwNotes.isHidden = true
                    self.wsCartGet()
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoking the supplier note API
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
                    self.wsCartGet()
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoking the delivery date API
    func wsDeliveryDateAvailability(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(cartID)&delivery_date=\(deliverydateTextField.text ?? "")"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartDeliveryDateAvailabilityURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.bckView.isHidden = true
                        self.vwNotes.isHidden = true
                        self.wsCartGet()
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
    //This method is used for invoking the Dellivery address API
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
                 //   self.view.makeToast(processedResponse["message"].stringValue)
                    self.bckView.isHidden = true
                    self.vwNotes.isHidden = true
                    self.wsCartGet()
                } else {
              //      self.view.makeToast(Constants.AlertMessage.error)
                }
            }
        }
    }
    //This methos is used for upadte the product
    func wsUpdateProduct(qty : String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.changeQuantityTapped = false
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(cartID)&product_id=\(productID)&price_range_id=\(priceRangeID)&qty=\(qty)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        var updatedarrCartListResponse = [UpdateProductCart]()
        APICall().post(apiUrl: Constants.WebServiceURLs.cartUpdateProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UpdateProductCartModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        if dicResponseData.success == "1" {
                            self.totalConsoldatedAmount = dicResponseData.data?.consolidatedPayableAmount ?? 0.0
                            self.count = -1
                            if let data = dicResponseData.data {
                                updatedarrCartListResponse = [data]
                                self.amountLabel.text = "AED \(updatedarrCartListResponse.first?.updatedCart?.totalPayableAmount?.rawValue ?? "")"
                                if let id = updatedarrCartListResponse.first?.updatedCart?.totalNetAmount{
                                    self.estimatedSubTotalLabel.text  = "AED \(id.rawValue)"
                                }
                                if let id = updatedarrCartListResponse.first?.updatedCart?.vatAmount{
                                    self.vatPercentageLabel.text = "AED \(id.rawValue)"
                                }
                                if let id = updatedarrCartListResponse.first?.updatedCart?.deliveryFee{
                                    self.exstimatedDeliveryFeeLabel.text = "AED \(id.rawValue)"
                                }
                                let cell: CartDetailsTableViewCell? = (self.productsTableView.cellForRow(at: IndexPath(row: self.seletectedCartIndex, section: 0))as? CartDetailsTableViewCell)
                                cell?.productCostlabel.text =   self.estimatedSubTotalLabel.text/*"AED\(id.rawValue)"*/
                                self.txtChangeProductQuantity.text =  cell?.productCountLabel.text
                                if let id = updatedarrCartListResponse.first?.updatedCart?.totalPayableAmount{
                                    self.estimatedTotalLabel.text = "AED \(id.rawValue)"
                                }
                                if self.changeQuantityTapped{
                                    self.wsCartGet()
                                    self.changeQuantityTapped = false
                                }
                            }
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
    //This methos is used for delete the product
    func wsDeleteProduct(productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        
        let postString = "cart_id=\(cartID)&product_id=\(productID)&pricing_range_id=\(priceRangeID)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartDeleteProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        print(dicResponseData.message)
                        self.wsCartGet()
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
    //This methos is used for upadte custom product
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
                        self.wsCartGet()
                    } catch let err {
                        print("Session Error: ",err)
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This methos is used for add custom product 
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
                    self.wsCartGet()
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
}
