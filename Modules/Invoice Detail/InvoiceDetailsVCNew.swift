//
//  InvoiceDetailsVCNew.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 29/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import PaymentSDK
import FittedSheets

class InvoiceDetailsVCNew: UIViewController, PaymentManagerDelegate {
    @IBOutlet weak var BtnBack: UIButton!
    @IBOutlet weak var tblInvoiceItem: UITableView!
  @IBOutlet weak var orderNo: UILabel!
  @IBOutlet weak var outletName: UILabel!
  @IBOutlet weak var totalAmount: UILabel!
  @IBOutlet weak var createdOn: UILabel!
  @IBOutlet weak var invoiceNo: UILabel!
  @IBOutlet weak var supplierName: UILabel!
  @IBOutlet weak var supplierAddress: UILabel!
  
  var invoiceId = ""
  private var arrProductsInfo = [ProductsInfo]()
  private var arrInvoice = [Invoice]()
  private var arrPayment = [PaymentHistory]()
  private var billingAddress = ""
  private var deliveryAddress = ""
  var payableAmount = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    tblInvoiceItem.delegate = self
    tblInvoiceItem.dataSource = self
    self.tblInvoiceItem.register(UINib.init(nibName: "InvoiceDetailTblCell", bundle: nil), forCellReuseIdentifier: "InvoiceDetailTblCell")
    self.tblInvoiceItem.register(UINib.init(nibName: "InvoiceFooterTblCell", bundle: nil), forCellReuseIdentifier: "InvoiceFooterTblCell")
    self.tabBarController?.tabBar.isHidden = true
    wsInvoicesView()
  }
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
  @IBAction func downloadInvoice(_ sender: UIButton) {
    let vc = mainStoryboard.instantiateViewController(withIdentifier: "DownloadInvoiceToLocalVC") as! DownloadInvoiceToLocalVC
    vc.invoiceId = invoiceId
    vc.modalPresentationStyle = .formSheet
    let sheetController = SheetViewController(controller: vc, sizes:[SheetSize.fixed(CGFloat(500))])
    self.present(sheetController, animated: true, completion: nil)
  }
}
//This method is used for create the Invoice table cell
extension InvoiceDetailsVCNew: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
      return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
        return self.arrProductsInfo.count
    case 1:
        return 1
    default:
        return 0
    }
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let objInvoiceDetailTblCell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailTblCell", for: indexPath as IndexPath) as? InvoiceDetailTblCell
      objInvoiceDetailTblCell?.lblProductName.text = self.arrProductsInfo[indexPath.row].productName
      objInvoiceDetailTblCell?.lblProductCode.text = "\(self.arrProductsInfo[indexPath.row].displaySkuName?.rawValue ?? "")"
      
      objInvoiceDetailTblCell?.lblPricePerUnit.text = "AED \(self.arrProductsInfo[indexPath.row].pricePerUnit?.rawValue ?? "0") (*\(self.arrProductsInfo[indexPath.row].qty?.intValue ?? 0))"
      objInvoiceDetailTblCell?.lblTotalProductPrice.text = "AED \(self.arrProductsInfo[indexPath.row].netPrice?.rawValue ?? "0")"
      
      let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\( (self.arrProductsInfo[indexPath.row].productImage))")
      objInvoiceDetailTblCell?.imgProduct.kf.indicatorType = .activity
      objInvoiceDetailTblCell?.imgProduct.kf.setImage(
        with: url,
        placeholder: UIImage(named: "ic_placeholder"),
        options: nil)
      objInvoiceDetailTblCell?.lblNotes.isHidden = false
      objInvoiceDetailTblCell?.lblNotes.text = self.arrProductsInfo[indexPath.row].notes?.rawValue ?? "---"
      return objInvoiceDetailTblCell ?? UITableViewCell()
    } else {
      if arrInvoice.count != 0 {
        let objInvoiceFooterTblCell = tableView.dequeueReusableCell(withIdentifier: "InvoiceFooterTblCell", for: indexPath as IndexPath) as? InvoiceFooterTblCell
        
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
          objInvoiceFooterTblCell?.btnPayNow.setTitle("Received Amount", for: .normal)
          objInvoiceFooterTblCell?.btnMarkAsPaidOut.isHidden = false
          objInvoiceFooterTblCell?.lblReceivedAmountTitle.text = "RECEIVED AMOUNT"
        } else {
          objInvoiceFooterTblCell?.btnPayNow.setTitle("Pay Now", for: .normal)
          objInvoiceFooterTblCell?.btnMarkAsPaidOut.isHidden = true
          objInvoiceFooterTblCell?.lblReceivedAmountTitle.text = "PAID AMOUNT"
        }
        print(arrInvoice)
        objInvoiceFooterTblCell?.lblOrderPrice.text = "AED \(self.arrInvoice[0].totalNetAmount?.rawValue ?? "0")"
        objInvoiceFooterTblCell?.lblVatPrice.text = "AED \(self.arrInvoice[0].vatAmount?.rawValue ?? "0")"
        objInvoiceFooterTblCell?.lblDeliveryFee.text = "AED \(self.arrInvoice[0].deliveryFee?.rawValue ?? "0")"
        objInvoiceFooterTblCell?.lblTotalPrice.text = "AED \(self.arrInvoice[0].totalPayableAmount?.rawValue ?? "0")"
   //     objInvoiceFooterTblCell?.lblBillingAddress.text = self.arrInvoice[0].billingAddress
  //      objInvoiceFooterTblCell?.lblDeliveryAddress.text = self.arrInvoice[0].deliveryAddress
        objInvoiceFooterTblCell?.lblVatTitle.text = "VAT(\(self.arrInvoice[0].vat.percentage?.rawValue ?? "0")%)"
        objInvoiceFooterTblCell?.lblRemainingAmount.text = "AED \(self.arrInvoice[0].pendingAmount?.rawValue ?? "0")"
        objInvoiceFooterTblCell?.lblPaidAmount.text = "AED \(self.arrInvoice[0].receivedAmount?.rawValue ?? "0")"
        objInvoiceFooterTblCell?.lblOrderStatus.text = self.arrInvoice[0].statusName
        
        if self.arrInvoice[0].status?.rawValue == "10.0" {
          objInvoiceFooterTblCell?.btnPayNow.isHidden = false
          
        } else {
          objInvoiceFooterTblCell?.btnPayNow.isHidden = true
          
        }
        if self.arrInvoice[0].status?.rawValue == "10.0" && String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
          objInvoiceFooterTblCell?.btnMarkAsPaidOut.isHidden = false
          
        } else {
          objInvoiceFooterTblCell?.btnMarkAsPaidOut.isHidden = true
          
        }
        if self.arrInvoice[0].logs?[0].notes?.rawValue != nil{
          objInvoiceFooterTblCell?.vwPaidNotes.isHidden = false
          objInvoiceFooterTblCell?.lblPaidNotes.text = self.arrInvoice[0].logs?[0].notes?.rawValue
        } else {
          objInvoiceFooterTblCell?.vwPaidNotes.isHidden = true
        }
        objInvoiceFooterTblCell?.btnPayNow.tag = indexPath.row
        objInvoiceFooterTblCell?.btnPayNow.addTarget(self , action:#selector(btnPayNowClicked(sender:)), for: .touchUpInside)
        
        objInvoiceFooterTblCell?.btnMarkAsPaidOut.tag = indexPath.row
        objInvoiceFooterTblCell?.btnMarkAsPaidOut.addTarget(self , action:#selector(btnMarkAsPaidClicked(sender:)), for: .touchUpInside)
        return objInvoiceFooterTblCell ?? InvoiceFooterTblCell()

      } else {
        return UITableViewCell()
      }
    }
  }
    
  @objc func btnPayNowClicked(sender:UIButton) {
      guard !billingAddress.isEmpty, !deliveryAddress.isEmpty, let totalPayAbleAmount = Double(payableAmount), totalPayAbleAmount > 0  else {
          return
      }
      
      let billingDetails = PaymentSDKBillingDetails(name: (USERDEFAULTS.getDataForKey(.user_first_name) as? String ?? "")+" "+(USERDEFAULTS.getDataForKey(.user_last_name) as? String ?? ""),
                                                    email: USERDEFAULTS.getDataForKey(.user_email) as? String,
                                                    phone: USERDEFAULTS.getDataForKey(.user_phone) as? String,
                                                    addressLine: billingAddress,
                                                    city: USERDEFAULTS.getDataForKey(.city) as? String ?? "Dubai",
                                                    state: USERDEFAULTS.getDataForKey(.state) as? String ?? "Dubai",
                                                    countryCode: "AE",
                                                    zip: USERDEFAULTS.getDataForKey(.pincode) as? String)
      
      let shippingDetails = PaymentSDKShippingDetails(name: (USERDEFAULTS.getDataForKey(.user_first_name) as? String ?? "")+" "+(USERDEFAULTS.getDataForKey(.user_last_name) as? String ?? ""),
                                                      email: USERDEFAULTS.getDataForKey(.user_email) as? String,
                                                      phone: USERDEFAULTS.getDataForKey(.user_phone) as? String,
                                                      addressLine: deliveryAddress,
                                                      city: USERDEFAULTS.getDataForKey(.city) as? String ?? "Dubai",
                                                      state: USERDEFAULTS.getDataForKey(.state) as? String ?? "Dubai",
                                                      countryCode: "AE",
                                                      zip: USERDEFAULTS.getDataForKey(.pincode) as? String)
      
      
      let sdkConfig = PayTabsService.getSDKConfiguration()
      sdkConfig.cartID = invoiceId
      sdkConfig.amount =  totalPayAbleAmount
      sdkConfig.cartDescription = invoiceId
      sdkConfig.billingDetails = billingDetails
      sdkConfig.shippingDetails = shippingDetails
      if totalPayAbleAmount > 0 {
          PaymentManager.startCardPayment(on: self, configuration: sdkConfig, delegate: self)
      }
  }
  @objc func btnMarkAsPaidClicked(sender:UIButton) {
//      self.vwBlur.isHidden = false
//      self.vwNotes.isHidden = false
  }
  
    //This method is used for invoke the pay now API
  func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {

      if let transactionDetails = transactionDetails {
          print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
          print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
          print("Token: " + (transactionDetails.token ?? ""))
          print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
          print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
          
          
          
          let para:NSMutableDictionary = NSMutableDictionary()
          para.setValue(transactionDetails.transactionReference, forKey: "transactionReference")
          para.setValue("Sale", forKey: "transactionType")
          para.setValue(self.arrInvoice[0].uniqueName, forKey: "cartId")
          para.setValue("cart description", forKey: "cartDescription")
          para.setValue("AED", forKey: "cartCurrency")
          para.setValue(Double(payableAmount), forKey: "cartAmount")
          para.setValue("Authorised", forKey: "payResponseReturn")
          
          let paymentResult:NSMutableDictionary = NSMutableDictionary()
          paymentResult.setValue(transactionDetails.paymentResult?.responseCode, forKey: "responseCode")
          paymentResult.setValue("Authorised", forKey: "responseMessage")
          paymentResult.setValue("A", forKey: "responseStatus")
          paymentResult.setValue(transactionDetails.paymentResult?.transactionTime , forKey: "transactionTime")
          
          para.setValue(paymentResult, forKey: "paymentResult")
          
          
          let paymentInfo:NSMutableDictionary = NSMutableDictionary()
          paymentInfo.setValue("Visa", forKey: "cardScheme")
          paymentInfo.setValue("Credit", forKey: "cardType")
          paymentInfo.setValue("4000 00## #### 0002", forKey: "paymentDescription")
          para.setValue(paymentInfo, forKey: "paymentInfo")
          para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "redirectUrl")
          para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "errorCode")
          para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "errorMsg")
          para.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "token")
          
          let billingDetails:NSMutableDictionary = NSMutableDictionary()
          billingDetails.setValue("Dubai", forKey: "city")
          billingDetails.setValue("AE", forKey: "countryCode")
          billingDetails.setValue(USERDEFAULTS.getDataForKey(.user_email), forKey: "email")
          billingDetails.setValue((USERDEFAULTS.getDataForKey(.user_first_name) as? String ?? "")+" "+(USERDEFAULTS.getDataForKey(.user_last_name) as? String ?? ""), forKey: "name")
          billingDetails.setValue(1234567890, forKey: "phone")
          billingDetails.setValue("Dubai", forKey: "state")
//          billingDetails.setValue(lblBillingAddress.text, forKey: "addressLine")
          billingDetails.setValue(USERDEFAULTS.getDataForKey(.pincode), forKey: "zip")
          para.setValue(billingDetails, forKey: "billingDetails")
          para.setValue(billingDetails, forKey: "shippingDetails")
          
          let paymentSDKDetails:NSMutableDictionary = NSMutableDictionary()
          paymentSDKDetails.setValue(para, forKey: "PaymentSdkTransactionDetails")
          
          
          
          var jsonData:Data = Data()
          if #available(iOS 13.0, *) {
              jsonData = try! JSONSerialization.data(withJSONObject: paymentSDKDetails, options: JSONSerialization.WritingOptions.withoutEscapingSlashes)
          } else {
              // Fallback on earlier versions
          }
          let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
          print(jsonString)
          
          
          guard case ConnectionCheck.isConnectedToNetwork() = true else {
              showToast(message: Constants.AlertMessage.NetworkConnection)
              
              return
          }
          
          APICall().post1(apiUrl: Constants.WebServiceURLs.PayNowURL, requestPARAMS: jsonString, isTimeOut: false){
              (success, responseData) in DispatchQueue.main.async {
                  if success{
                      
                      let decoder = JSONDecoder()
                      do {
                          
                          let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                          self.showToast(message: dicResponseData.message)
                          
//                          self.vwBlur.isHidden = true
//                          self.vwReceivePayment.isHidden = true
                          self.wsInvoicesView()
                      }catch let err {
                          print("Session Error: ",err)
                      }
                  }
                  else{
                      self.showToast(message: Constants.AlertMessage.error)
                  }
              }
          }
          
          
          
          
      } else if let error = error {
          // Handle errors
      }
  }
}
//This method is used for invoke the Invoice view API
extension InvoiceDetailsVCNew {
  func wsInvoicesView(){
      guard case ConnectionCheck.isConnectedToNetwork() = true else {
          showToast(message: Constants.AlertMessage.NetworkConnection)
          
          return
      }
      
      let postString = "invoice_id=\(invoiceId)"
      self.arrProductsInfo.removeAll()
      self.arrInvoice.removeAll()
      APICall().post(apiUrl: Constants.WebServiceURLs.InvoicesViewURL, requestPARAMS: postString, isTimeOut: false){
          (success, responseData) in DispatchQueue.main.async {
              if success{
                  
                  let decoder = JSONDecoder()
                  do {
                      
                      let dicResponseData = try decoder.decode(InvoiceDetailResponseModel.self, from: responseData as! Data)
                      
                    if let data = dicResponseData.data {
                      self.arrProductsInfo.append(contentsOf: data.invoice!.productsInfo)
                      self.arrInvoice.append(data.invoice!)
                      self.arrPayment = data.paymentHistory!
                      
                      DispatchQueue.main.async {
                        self.orderNo.text = self.arrInvoice[0].orderUniqueName
                //        self.outletName.text = self.arrInvoice[0].outletInfo.name
                        self.totalAmount.text = "AED \(self.arrInvoice[0].totalPayableAmount?.rawValue ?? "")"
                        self.createdOn.text = "Created On \(self.arrInvoice[0].createdAt.UTCToLocal(format: "d MMM yyyy"))"
                        self.invoiceNo.text = "Invoice No : \(self.arrInvoice[0].uniqueName)"
                        self.supplierName.text = self.arrInvoice[0].supplierInfo.supplierName?.rawValue
                        self.supplierAddress.text = "Outlet: \(self.arrInvoice[0].supplierInfo.supplierAddress?.rawValue ?? "")"
                      }
//                      if let billAddress = data.invoice?.billingAddress {
//                          self.billingAddress = billAddress
//                      }
//                      if let delvAddress = data.invoice?.deliveryAddress {
//                          self.deliveryAddress = delvAddress
//                      }
                      
                      if self.arrProductsInfo.count > 0 {
                        self.tblInvoiceItem.reloadData()
                      }
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
}
