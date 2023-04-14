//
//  PlacedOrderViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 07/09/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This class used for fucture 
import UIKit

class PlacedOrderViewController: UIViewController {
  var orderId = ""
  var orderResponse: Order?
  var invoiceResponse: InvoiceStatus?
  var objPlaceOrderFooterTblCell: PlaceOrderFooterTblCell?
var arrProductsInfo                = [ProductsInfo]()

  @IBOutlet weak var placeOrderTableView: UITableView!
  @IBOutlet weak var noOfItems: UILabel!
  @IBOutlet weak var emailStatus: UILabel!
  @IBOutlet weak var amount: UILabel!
  @IBOutlet weak var orderedOn: UILabel!
@IBOutlet weak var productsTableView        : UITableView!
    @IBOutlet weak var billingAddressLabel      : UILabel!
    @IBOutlet weak var deliveryAddressLabel     : UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBarController?.tabBar.isHidden = true
    productsTableView.delegate   = self
    productsTableView.dataSource = self
    productsTableView.reloadData()
     registerXibs()
//    placeOrderTableView.delegate = self
//    placeOrderTableView.register(CartProductListTblCell.nib(), forCellReuseIdentifier: CartProductListTblCell.identifier)
//    placeOrderTableView.register(PlaceOrderFooterTblCell.nib(), forCellReuseIdentifier: PlaceOrderFooterTblCell.identifier)
    wsOrderBuyerListView()
  }
    func registerXibs(){
        productsTableView.register(UINib.init(nibName: "PlacedOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlacedOrderTableViewCell")
    }
  @IBAction func backTapped(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
extension PlacedOrderViewController {
  func wsOrderBuyerListView(){
    guard case ConnectionCheck.isConnectedToNetwork() = true else {
      showToast(message: Constants.AlertMessage.NetworkConnection)
      
      return
    }
    
    let postString = "order_id=\(orderId)"
    APICall().post(apiUrl: Constants.WebServiceURLs.OrderBuyerListViewURL, requestPARAMS: postString, isTimeOut: false){
      (success, responseData) in DispatchQueue.main.async {
        hideLoader()
        if success{
          let decoder = JSONDecoder()
          do {
            let response = try decoder.decode(PlacedOrderViewResponseModel.self, from: responseData as! Data)
            self.orderResponse = response.data?.order
            self.invoiceResponse = response.data?.invoiceStatus
            DispatchQueue.main.async {
      //        self.noOfItems.text = "\(self.orderResponse?.number ?? 0)"
      //        self.emailStatus.text = "\(self.orderResponse?.status?.rawValue ?? "")"
      //        self.amount.text = "AED \(self.orderResponse?.totalNetAmount.rawValue ?? "")"
      //        self.placeOrderTableView.reloadData()
                self.billingAddressLabel.text = self.orderResponse?.billingAddress
    self.deliveryAddressLabel.text = self.orderResponse? .deliveryAddress
            }
          } catch let err {
            print("Session Err \(err)")
          }
        } else {
          self.showToast(message: Constants.AlertMessage.error)
        }
      }
    }
  }
}
extension PlacedOrderViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacedOrderTableViewCell", for: indexPath)as? PlacedOrderTableViewCell
        cell?.productName.text      = arrProductsInfo[indexPath.row].productName
        cell?.productCostlabel.text = "AED  \(arrProductsInfo[indexPath.row].pricePerUnit?.rawValue ?? "0")"
        
        cell?.prodctIDLabel.text     = arrProductsInfo[indexPath.row].productCode?.rawValue

        cell?.productImage.kf.indicatorType = .activity

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
return 1
    }
}
