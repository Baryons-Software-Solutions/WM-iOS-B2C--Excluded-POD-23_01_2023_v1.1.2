//
//  WishlistViewController.swift
//  Watermelon-iOS_GIT
//  Created by apple on 18/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.

import UIKit

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var subtotalText: UILabel!
    @IBOutlet weak var lblDiscounttext: UILabel!
    @IBOutlet weak var PinkView: UILabel!
    @IBOutlet weak var vwprice: UIView!
    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var lblexplore: UILabel!
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var imgWish: UIImageView!
    @IBOutlet weak var lblYourwishlist: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var WishlistTableView: UITableView!
    @IBOutlet weak var totalPriceText: UILabel!
    @IBOutlet weak var subTotalPriceText: UILabel!
    @IBOutlet weak var discountText: UILabel!
    @IBOutlet weak var BtnDelete: UIButton!
    @IBOutlet weak var BtnCancel: UIButton!
    @IBOutlet weak var vwSuccess: UIView!
    @IBOutlet weak var changeProductQtyView: UIView!
    @IBOutlet weak var BtnSubmitProductQty: UIButton!
    @IBOutlet weak var txtChangeProductQty: UITextField!
    @IBOutlet weak var ProductAddToCart: UIView!
    
    var selectedRowCartId              = ""
    var selectedRowProductId           = ""
    var selectedRowPriceRangeId        = ""
    var arrCartListResponse            = [CartListResponse]()
    var arrProductsInfo                = [ProductsInfo]()
    var arrCartProductListResponse     = [Cart]()
    var OutletId                       = ""
    var supplierId                     = ""
    var productCode                    = ""
    var data                           = ""
    var tappedRowCount                 = "0"
    var selectedIndex                  = 0
    var arrWishlistResponce            = [WishlistResponce]()
    var totalDiscountPrice             = 0.0
    var subtotalPrice                  = 0.0
    var totalPrice                     = 0.0
    var totalNumberOfItem              = 0
    var originalprice                  = 0
    var cartID                         = ""
    var cartId1                        = ""
    var categoryId                     = ""
    var arrTempSupplierID              = NSMutableArray()
    var arrTempPrinceID                = NSMutableArray()
    var arrTempBrandID                 = NSMutableArray()
    var supplierIDNumber                     = ""
    var arrItemDetailResponse          : ItemDetailResponse?
    var arrProductList                 = [Product]()
    var isBottomRefreshMySupplierList  = false
    var responseCountProductList       = 0
    var filterlistLoaded               = true
    var sessionError = "Session Error: "
    override func viewDidLoad() {
        super.viewDidLoad()
        wsWishlistGet()
        subtotalText.isHidden = true
        lblDiscounttext.isHidden = true
        PinkView.isHidden = true
        subTotalPriceText.isHidden = true
        discountText.isHidden = true
        vwprice.isHidden = true
        vwSuccess.isHidden = true
        lblexplore.isHidden = true
        btnWishlist.isHidden = true
        imgWish.isHidden = true
        lblYourwishlist.isHidden = true
        vwDelete.isHidden = true
        filterBGView.isHidden = true
        ProductAddToCart.isHidden = true
        lblYourwishlist.isHidden = true
        btnWishlist.cornerRadius = 10
        vwDelete.cornerRadius = 10
        BtnDelete.cornerRadius = 10
        BtnCancel.cornerRadius = 10
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        registerXibs()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func delegateSetup(){
        WishlistTableView.delegate   = self
        WishlistTableView.dataSource = self
    }
    func registerXibs(){
        self.WishlistTableView.register(UINib.init(nibName: "WishlistTblCell", bundle: nil), forCellReuseIdentifier: "WishlistTblCell")
        self.WishlistTableView.register(UINib.init(nibName: "WishlistContinueTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistContinueTableViewCell")
    }
    @IBAction func BtnCancel(_ sender: Any) {
        filterBGView.isHidden = true
        vwDelete.isHidden   = true
    }
    @IBAction func BtnAddPrroducts(_ sender: Any) {
        let SearchViewController = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        SearchViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func BtnDelete(_ sender: Any) {
        filterBGView.isHidden = true
        vwDelete.isHidden   = true
        removeProductFromWishlist(productCode: arrWishlistResponce[selectedIndex].productCode ?? "")
    }
    @IBAction func BtnClose(_ sender: Any) {
        print("")
    }
    @IBAction func BtnSubmitProductQty(_ sender: Any) {
        self.txtChangeProductQty.resignFirstResponder()
        guard let presentValue = Double(self.txtChangeProductQty.text ?? "") else { return }
        self.filterBGView.isHidden = true
        self.changeProductQtyView.isHidden = true
        if presentValue == 0.0 {
            self.showCustomAlert(message: "Quantity must not be less than zero",isSuccessResponse: false,buttonTitle:  "Try Again")
            return
        }
        if Validation().isEmpty(txtField: txtChangeProductQty.text!){
            self.showCustomAlert(message:Constants.AlertMessage.qty)
        } else {
            self.filterBGView.isHidden = true
            self.changeProductQtyView.isHidden = true
            let cell: WishlistTblCell? = (self.WishlistTableView.cellForRow(at: IndexPath(row:(sender as AnyObject).tag, section: 0)) as? WishlistTblCell)
            cell?.QuantityStackView.isHidden = false
            cell?.cartButton.isHidden = true
            cell?.AddQuantityLbl.text = String(self.txtChangeProductQty.text!)
            //calling the update product method
            wsUpdateProductQuantity(cartID: self.selectedRowCartId,
                                    qty: self.txtChangeProductQty.text!,
                                    productID: self.selectedRowProductId,
                                    priceRangeID: self.selectedRowPriceRangeId)
        }
    }
    @IBAction func BtnCloseProductQty(_ sender: Any) {
        filterBGView.isHidden = true
        changeProductQtyView.isHidden = true
    }
    @IBAction func BtnCountinueShopping(_ sender: Any) {
        self.filterBGView.isHidden = true
        self.dismiss(animated:true)
        self.ProductAddToCart.isHidden = true
    }
    @IBAction func BtnViewCart(_ sender: Any) {
        self.filterBGView.isHidden = true
        self.ProductAddToCart.isHidden = true
        if let navigationController = self.navigationController {
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.selectedIndex = 2
            navigationController.popToRootViewController(animated: true)
        }
    }
 
    //This method is used for Update the product quantity
    func wsUpdateProductQuantity(cartID: String,qty : String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(self.cartID)&product_id=\(productID)&price_range_id=\(priceRangeID)&qty=\(qty)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        
        //calling the api to update the quantity of the product
        APICall().post(apiUrl: Constants.WebServiceURLs.cartUpdateProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UpdateProductCartModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.filterBGView.isHidden = false
                        } else {
                            self.showCustomAlert(message: dicResponseData.message)
                        }
                    } catch let err {
                        print(self.sessionError,err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    // This method is used for the Update the product
    func wsUpdateProduct(cartID: String,qty : String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var selectedIndexpath = 0
        let postString = "cart_id=\(cartID)&product_id=\(productID)&price_range_id=\(priceRangeID)&qty=\(qty)"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartUpdateProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UpdateProductCartModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.filterBGView.isHidden = true
                            let selectedIndexpath = dicResponseData.data
                            print(selectedIndexpath)
                        } else {
                            self.showCustomAlert(message: dicResponseData.message)
                        }
                    }catch let err {
                        print(self.sessionError,err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    // This method is used fot the Delete the product
    func wsDeleteProduct(cartID: String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(cartID)&product_id=\(productID)&pricing_range_id=\(priceRangeID)"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartDeleteProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1"{
                            self.filterBGView.isHidden = true
                            self.showCustomAlert(message: "Product deleted from cart")
                        }else{
                            self.showCustomAlert(message: dicResponseData.message, isSuccessResponse: false)
                        }
                    }catch let err {
                        print(self.sessionError,err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for the addd to cart
    func wsAddToCart(product_id : String,pricing_range_id: String,quantity: Int, cart_id:String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "product_id=\(product_id)&pricing_range_id=\(pricing_range_id)&quantity=\(quantity)&outlet_id=\(outletID)&cart_id=\(cart_id)"
        APICall().post(apiUrl: Constants.WebServiceURLs.AddToCartURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(AddProductResponseModel.self, from: responseData as! Data)
                        self.filterBGView.isHidden = false
                        self.ProductAddToCart.isHidden = false
                        self.cartID = dicResponseData.data.cartID
                    }catch let err {
                        print(self.sessionError,err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
}
extension WishlistViewController{
    // This method are used for calling the api productListURL
    func wsProductListURL(page: Int,search: String,sort_method: String, sort_by: String, CategotyId: NSMutableArray, SubCategoryId: NSMutableArray,showloading:Bool,platform: String, app_type: String , fcm_token_ios: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.productListURL
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + APICall().getTokenValue(), forHTTPHeaderField: "Authorization")
            
        }
        var brandID = [String]()
        var brandIDArray = ""
        for i in self.arrTempBrandID{
            brandID.append(i as! String)
            brandIDArray = brandID.joined(separator: ",")
        }
        var supplierID = [String]()
        for i in self.arrTempSupplierID{
            supplierID.append(i as! String)
        }
        var priceID = [String]()
        var priceIDArray = ""
        for i in self.arrTempPrinceID{
            priceID.append(i as! String)
            print("priceeee\(priceID.joined(separator: ","))")
            priceIDArray = priceID.joined(separator: ",")
        }
        
        var params :[String: Any]?
        if showloading{
            showLoader()
        }
        params = ["start":0,"end":0,"page":page,"sort_method":"asc","keyword":search,"sort_by":"product_name","outlet_id":outletID,"category_id":categoryId,"subcategory_id":"","supplier_id":self.supplierIDNumber,"brand": brandIDArray,"status":1,"price": priceIDArray,"platform":"mobile","app_type":"b2c", "fcm_token_ios": "\(USERDEFAULTS.getDataForKey(.fcmToken))"]
        print("API :\(url)")
        print("params:\(params ?? [String: Any]())")
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                
                if showloading{
                    hideLoader()
                }
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        print ("productListURL response:::",jsonResponse)
                        let decoder = JSONDecoder()
                        do {
                            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                                print(convertedJsonIntoDict)
                            }
                            let dicResponseData = try decoder.decode(ItemDetailResponseModel.self, from: data )
                            let strStatus = dicResponseData.success
                            if strStatus == "1" {
                                DispatchQueue.main.async {
                                    self.filterBGView.isHidden = true
                                    self.arrItemDetailResponse = dicResponseData.data
                                    if self.isBottomRefreshMySupplierList == true {
                                        self.arrProductList.append(contentsOf: dicResponseData.data.products)
                                    } else  {
                                        self.arrProductList = dicResponseData.data.products
                                    }
                                    self.isBottomRefreshMySupplierList = false
                                    if self.arrProductList.count > 0{
                                        self.responseCountProductList = dicResponseData.data.totalCount
                                    } else {
                                    }
                                    if self.filterlistLoaded{
                                        self.filterlistLoaded = false
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    if self.arrProductList.count == 0 {
                                        self.arrProductList = [Product]()
                                    }
                                    self.isBottomRefreshMySupplierList = false
                                }
                            }
                            
                            DispatchQueue.main.async {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    print("")
                                }
                            }
                        } catch let error as NSError {
                            print(self.sessionError,error)
                            DispatchQueue.main.async {
                                print("")
                            }
                        }
                        
                    }catch _ {
                        print ("OOps not good JSON formatted response")
                    }
                }
            })
            task.resume()
        }catch _ {
            print ("Oops something happened buddy")
        }
        
    }
    //This method is used for invokre the wishlist API
    func wsWishlistGet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        self.arrWishlistResponce.removeAll()
        let postString = "start=0&end=10&page=1&sort_method=\(OutletId)&keyword=\(OutletId)&sort_by=\(OutletId)&status=1&outlet_id=\(OutletId)&supplier_id=\(supplierId)"
        APICall().post(apiUrl: Constants.WebServiceURLs.WishlistURL,requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(WishlistResponceModal.self, from: responseData as! Data)
                        // Success = true = 1 , unseccess = false = 0
                        if dicResponseData.success == "1" {
                            if let data = dicResponseData.data {
                                self.arrWishlistResponce = data
                                for element in data {
                                    self.totalNumberOfItem += 1
                                }
                            }
                            if self.arrWishlistResponce.count > 0 {
                                DispatchQueue.main.async {
                                    self.delegateSetup()
                                    self.WishlistTableView.isHidden = false
                                    self.lblexplore.isHidden = true
                                    self.btnWishlist.isHidden = true
                                    self.imgWish.isHidden = true
                                    self.lblYourwishlist.isHidden = true
                                    self.WishlistTableView.reloadData()
                                    self.subtotalText.text = "Subtotal(\(self.totalNumberOfItem) items)"
                                    self.subTotalPriceText.text = "AED \(self.subtotalPrice)"
                                    self.totalPriceText.text = "AED \(self.totalPrice)"
                                    self.discountText.text = "AED \(self.totalDiscountPrice)"
                                }
                            }else{
                                self.WishlistTableView.isHidden = true
                                self.lblexplore.isHidden = false
                                self.btnWishlist.isHidden = false
                                self.imgWish.isHidden = false
                                self.lblYourwishlist.isHidden = false
                                
                                self.subtotalText.isHidden = true
                                self.lblDiscounttext.isHidden = true
                                self.PinkView.isHidden = true
                                self.subTotalPriceText.isHidden = true
                                self.discountText.isHidden = true
                                self.vwprice.isHidden = true
                                self.WishlistTableView.reloadData()
                            }
                        } else {
                            self.WishlistTableView.isHidden = true
                            self.lblexplore.isHidden = false
                            self.btnWishlist.isHidden = false
                            self.imgWish.isHidden = false
                            self.lblYourwishlist.isHidden = false
                            self.subtotalText.isHidden = true
                            self.lblDiscounttext.isHidden = true
                            self.PinkView.isHidden = true
                            self.subTotalPriceText.isHidden = true
                            self.discountText.isHidden = true
                            self.vwprice.isHidden = true
                            self.WishlistTableView.reloadData()
                        }
                    } catch let err {
                        print(self.sessionError,err)
                        self.WishlistTableView.reloadData()
                        self.WishlistTableView.isHidden = true
                        self.lblexplore.isHidden = false
                        self.btnWishlist.isHidden = false
                        self.imgWish.isHidden = false
                        self.lblYourwishlist.isHidden = false
                        self.subtotalText.isHidden = true
                        self.lblDiscounttext.isHidden = true
                        self.PinkView.isHidden = true
                        self.subTotalPriceText.isHidden = true
                        self.discountText.isHidden = true
                        self.vwprice.isHidden = true
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: 0)
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
}
//This method is used for creating the table view cell
extension WishlistViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrWishlistResponce.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row  == self.arrWishlistResponce.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistContinueTableViewCell", for: indexPath as IndexPath) as? WishlistContinueTableViewCell
            cell?.continueButton.tag = indexPath.row
            cell?.continueButton.addTarget(self , action:#selector(continueButtonAction(sender:)), for: .touchUpInside)
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTblCell", for: indexPath)as? WishlistTblCell
            let wishlistData = arrWishlistResponce[indexPath.row]
            let data = arrWishlistResponce[indexPath.row].productDetail
            cell?.productCostLabel.text =  "AED " + "\(data.pricingRange[0].listPrice?.rawValue ?? "0")"
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
            cell?.productTitle.text = "\(data.productName)"
            cell?.SupplierName.text = "\(wishlistData.supplierCompanyName ?? "")"
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\((data.productImage) )")
            cell?.productImage.kf.indicatorType = .activity
            cell?.productImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "HomePlaceHolder"),
                options: nil)
            if self.arrWishlistResponce[indexPath.row].productDetail.pricingRange[0].quantityAlreadyInCart?.intValue ?? 0 >= 1 && self.arrWishlistResponce[indexPath.row].productDetail.pricingRange.count == 1{
                cell?.QuantityStackView.isHidden = false
                cell?.cartButton.isHidden = true
                cell?.AddQuantityLbl.text = "\(self.arrWishlistResponce[indexPath.row].productDetail.pricingRange[0].quantityAlreadyInCart?.rawValue ?? "")"
                
            }else  if self.arrWishlistResponce[indexPath.row].productDetail.pricingRange.count > 1{
                cell?.QuantityStackView.isHidden = false
                cell?.cartButton.isHidden = true
                cell?.AddQuantityLbl.text = "\(self.arrWishlistResponce[indexPath.row].productDetail.pricingRange[0].quantityAlreadyInCart?.rawValue ?? "")"
                
            } else {
                cell?.QuantityStackView.isHidden = true
                cell?.cartButton.isHidden = false
                cell?.AddQuantityLbl.text = "\(self.arrWishlistResponce[indexPath.row].productDetail.pricingRange[0].quantityAlreadyInCart?.rawValue ?? "")"
            }
            cell?.cartButton.tag = indexPath.row
            cell?.cartButton.addTarget(self , action:#selector(btnAddClicked(sender:)), for: .touchUpInside)
            
            cell?.PlusButton.tag = indexPath.row
            cell?.PlusButton.addTarget(self , action:#selector(btnPlusClicked(sender:)), for: .touchUpInside)
            
            cell?.MinusButton.tag = indexPath.row
            cell?.MinusButton.addTarget(self , action:#selector(btnMinusClicked), for: .touchUpInside)
            
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
            cell?.AddQuantityLbl.tag = indexPath.row
            cell?.AddQuantityLbl.isUserInteractionEnabled = true
            cell?.AddQuantityLbl.addGestureRecognizer(labelTap)
            return cell ?? UITableViewCell()
        }
    }
    @objc func btnAddClicked(sender:UIButton) {
        let cell: WishlistTblCell? = (self.WishlistTableView.cellForRow(at: IndexPath(row:sender.tag, section: 0)) as? WishlistTblCell)
        if self.arrWishlistResponce.count > 0, self.arrWishlistResponce[sender.tag].productDetail.pricingRange.count > 1{
//            let controller = mainStoryboard.instantiateViewController(withIdentifier: "AddItemVC") as? AddItemVC
//            controller?.outletID = outletID
        } else {
            cell?.QuantityStackView.isHidden = false
            cell?.cartButton.isHidden = true
            if arrWishlistResponce.count == 0{
                return
            }
            cell?.AddQuantityLbl.text = "\(self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].pricemoq?.intValue ?? 1)"
            wsAddToCart(product_id: self.arrWishlistResponce[sender.tag].productDetail.id, pricing_range_id: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].id, quantity: cell?.AddQuantityLbl.text?.integerValue() ?? 1,cart_id: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? "")
            print(self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? "")
        }
        
    }
    @objc
    func btnPlusClicked(sender:UIButton) {
        let cell: WishlistTblCell? = (self.WishlistTableView.cellForRow(at: IndexPath(row:sender.tag, section: 0)) as? WishlistTblCell)
        guard let presentValue = Double(cell?.AddQuantityLbl.text ?? "") else { return }
        let newValue = presentValue + 1
        cell?.QuantityStackView.isHidden = false
        cell?.cartButton.isHidden = true
        cell?.AddQuantityLbl.text = String(newValue)
        if self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue != nil{
            self.cartID = self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? ""
            
        }
        wsUpdateProduct(cartID: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? "", qty: (cell?.AddQuantityLbl.text!)!, productID: self.arrWishlistResponce[sender.tag].productDetail.id, priceRangeID: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].id)
        print(cartID)
        
    }
    
    
    @objc func btnMinusClicked(sender:UIButton) {
        let cell: WishlistTblCell? = (self.WishlistTableView.cellForRow(at: IndexPath(row:sender.tag, section: 0)) as? WishlistTblCell)
        guard let presentValue = Double((cell?.AddQuantityLbl.text)!) else { return }
        if self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue != nil{
            self.cartID = self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? ""
            
        }
        if presentValue >= 1{
            let newValue:Double = presentValue - 1
            if newValue >=
                Double(self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].pricemoq?.rawValue ?? "0.0")!.roundTo(places: 1){
                cell?.QuantityStackView.isHidden = false
                cell?.cartButton.isHidden = true
                cell?.AddQuantityLbl.text = String(newValue)
                wsUpdateProduct(cartID: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? "", qty: (cell?.AddQuantityLbl.text!)!, productID: self.arrWishlistResponce[sender.tag].productDetail.id, priceRangeID: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].id)
                
            } else {
                cell?.QuantityStackView.isHidden = true
                cell?.cartButton.isHidden = false
                wsDeleteProduct(cartID: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].cartID?.rawValue ?? "", productID: self.arrWishlistResponce[sender.tag].productDetail.id, priceRangeID: self.arrWishlistResponce[sender.tag].productDetail.pricingRange[0].id)
                print(cartID)
            }
            
        }
        
    }
    
    
    @objc func labelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        self.filterBGView.isHidden = false
        self.changeProductQtyView.isHidden = false
        //Below code will give the selected row count
        if let tag = gestureRecognizer.view?.tag {
            //print("tapped:::",tag)
            self.tappedRowCount = String(tag)
            //Based on the selected row, getting the values below
            if self.arrWishlistResponce[tag].productDetail.pricingRange[0].cartID?.rawValue != nil{
                self.cartID = self.arrWishlistResponce[tag].productDetail.pricingRange[0].cartID?.rawValue ?? ""
            }
            self.cartID = self.arrWishlistResponce[tag].productDetail.pricingRange[0].cartID?.rawValue ?? ""
            self.selectedRowCartId = self.arrWishlistResponce[tag].productDetail.pricingRange[0].cartID?.rawValue ?? ""
            self.selectedRowProductId = self.arrWishlistResponce[tag].productDetail.id
            self.selectedRowPriceRangeId = self.arrWishlistResponce[tag].productDetail.pricingRange[0].id
        }
        if gestureRecognizer.state == .ended {
            //Based on the below code will get tapped label value and assigning in the opened popup
            if let theLabel = (gestureRecognizer.view as? UILabel)?.text {
                //print("tapped value::",theLabel)
                self.txtChangeProductQty.text = theLabel
            }
        }
    }
    
    //This method is used for selecting the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrWishlistResponce.count == 0 {
            return
        }
        if indexPath.row  == self.arrWishlistResponce.count{
            return
        }
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        vc.prdId                    = self.arrWishlistResponce[indexPath.row].productDetail.id
        vc.outletID                 = outletID
        self.tabBarController?.tabBar.isHidden = true
        vc.defaultImageurl = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrWishlistResponce[indexPath.row].productImage ?? "" )")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func continueButtonAction(sender:UIButton) {
        let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchText = ""
        searchVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    @objc func btnDeleteClicked(sender:UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.filterBGView.isHidden = false
        self.vwDelete.isHidden   = false
        selectedIndex = indexPath.row
        print(self.productCode)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //This method is used for invoke  products from wishlists API
    func removeProductFromWishlist(productCode: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "product_code=\(productCode)"
        APICall().post(apiUrl: Constants.WebServiceURLs.RemoveWishlistURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.showCustomAlert(message: "Product has been successfully deleted from your wishlist")
                            self.wsWishlistGet()
                            self.WishlistTableView.reloadData()
                        }else{
                            self.showCustomAlert(message: dicResponseData.message,isSuccessResponse: false)
                        }
                        
                    } catch let err {
                        print(self.sessionError,err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for remove the products from wishlists
    func alertPresent(productCode: String) {
        self.removeProductFromWishlist(productCode: productCode)
        
    }
    
}

