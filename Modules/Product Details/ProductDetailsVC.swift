//
//  ProductDetailsVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 21/05/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class ProductDetailsVC: UIViewController {
    @IBOutlet weak var productCollection    : UICollectionView!
    @IBOutlet weak var qtyCollection        : UICollectionView!
    @IBOutlet weak var productName          : UILabel!
    @IBOutlet weak var supplierName         : UILabel!
    @IBOutlet weak var desc                 : UILabel!
    @IBOutlet weak var quantityNo           : UILabel!
    @IBOutlet weak var wishlistImage        : UIButton!
    @IBOutlet weak var totalPriceTOCartLabel: UILabel!
    @IBOutlet weak var ratingImage          : CosmosView!
    @IBOutlet weak var addMinusStackView    : UIStackView!
    @IBOutlet weak var addQuantityView      : UIView!
    @IBOutlet weak var addButton            : UIButton!
    @IBOutlet weak var changeQtyBgView      : UIView!
    @IBOutlet weak var changeQuantityPopUP  : UIView!
    @IBOutlet weak var changeQtyTextField   : UITextField!
    @IBOutlet weak var closeButtonOutlet    : UIButton!
    @IBOutlet weak var submitButtonOutlet   : UIButton!
    @IBOutlet weak var ProductAddCart: UIView!
    @IBOutlet weak var sellerNameButton     : UIButton!
    @IBOutlet weak var sellerRatingsButton  : UIButton!
    @IBOutlet weak var replacementPolicyLabel: UILabel!
    @IBOutlet weak var similarProductsCollectionView: UICollectionView!
    @IBOutlet weak var ratingsView           : UIView!
    @IBOutlet weak var ratingsBgView         : UIView!
    @IBOutlet weak var assuredImageView      : UIImageView!
    @IBOutlet weak var pageController        : UIPageControl!
    @IBOutlet weak var supplierImageView     : UIImageView!
    @IBOutlet weak var viewAllButton         : UIButton!
    @IBOutlet weak var addCartView: UIView!
    
    var arrProductsInfo                = [ProductsInfo]()
    var arrCartListResponse            = [CartListResponse]()
    var supplierID                     = ""
    var arrCartProductListResponse     = [Cart]()
    var seletectedCartIndex            = 0
    var arrSupplierList                = [SupplierListResponse]()
    var arrSupplierList1               = [GetMyfavouriteList]()
    var totalPrice:Double              = 0.0
    var prdId                          = ""
    var userTypeId                     = ""
    var productCode                    = ""
    var cartID                         = ""
    var outletID                       = ""
    var selectedSizePosition           = 0
    var isWishlistAdd                  = false
    var arrProductList                 = [Product]()
    var productDetails                 :ProductDetailsResponseModel?
    var selectedQuantityIndex          = 0
    var quantitrySelected              = 1.0
    var defaultImageurl                : URL?
    var similarProductDetailsDic       = [SimilarProduct]()
    var selectedIndexPathAddress       = 0
    var sessionError = "Session Error: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingImage.rating = 0
        ProductAddCart.isHidden = true
        addMinusStackView.isHidden = false
        addQuantityView.isHidden = true
        qtyCollection.delegate = self
        qtyCollection.dataSource = self
        similarProductsCollectionView.delegate = self
        similarProductsCollectionView.dataSource = self
        similarProductsCollectionView.register(UINib.init(nibName: "ShopAgainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShopAgainCollectionViewCell")
        qtyCollection.register(ProductQuantityCell.nib(), forCellWithReuseIdentifier: ProductQuantityCell.identifier)
        productCollection.register(ProductImageCell.nib(), forCellWithReuseIdentifier: ProductImageCell.identifier)
        addButton.setTitle("Add +", for: .normal)
        addButton.setBackgroundColor(color: .white, forState: .normal)
        addButton.setTitleColor(.forestGreen, for: .normal)
        self.arrProductList.removeAll()
        self.ratingsBgView.isHidden = true
        self.ratingsView.isHidden = true
        ratingsBgView.backgroundColor = .white
        self.pageController.numberOfPages = 0
        changeQtySetup()
        tapGestureSetup()
        handlingPageControllerDisplay(index: 0)
        replacementPolicyLabel.text = "3 Days Replacement Policy"
        self.sellerNameButton.setTitle("Name", for: .normal)
    }
    override func viewDidAppear(_ animated: Bool) {
        qtyCollection.delegate = self
        qtyCollection.dataSource = self
        getProductDetails(proudctId: prdId)
        print(prdId)
    }
    func changeQtySetup(){
        self.changeQuantityPopUP.isHidden = true
        self.changeQtyTextField.delegate = self
        self.changeQtyBgView.alpha  = 0.7
        self.changeQtyBgView.backgroundColor = .black
    }
    
    func handlingPageControllerDisplay(index: Int){
        self.pageController.currentPage = index
    }
    
    func tapGestureSetup(){
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.quantityNo.isUserInteractionEnabled = true
        self.quantityNo.addGestureRecognizer(labelTap)
        
        let productColletionTap = UITapGestureRecognizer(target: self, action: #selector(self.CollectionTapped(_:)))
        self.productCollection.isUserInteractionEnabled = true
        self.productCollection.addGestureRecognizer(productColletionTap)
        
        let ratingsView = UITapGestureRecognizer(target: self, action: #selector(self.ratingsViewTapped(_:)))
        self.ratingsBgView.isUserInteractionEnabled = true
        self.ratingsBgView.addGestureRecognizer(ratingsView)
    }
    @objc func CollectionTapped(_ sender: UITapGestureRecognizer){
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProductImageViewController") as! ProductImageViewController
        vc.prdId                    = prdId
        print(prdId)
        
        let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.productDetails?.data?.product?.product_image ?? "")")
        vc.ImageView?.kf.indicatorType = .activity
        vc.ImageView?.kf.setImage(
            with: defaultImageurl,
            placeholder: UIImage(named: "HomePlaceHolder"),
            options: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        self.changeQtyBgView.isHidden = false
        self.changeQuantityPopUP.isHidden = false
        if self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart == 0.0 {
            self.changeQtyTextField.text = "1.0"
        }else{
            self.changeQtyTextField.text = String(self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart ?? 1)
        }
    }
    
    @objc func ratingsViewTapped(_ sender: UITapGestureRecognizer) {
        self.ratingsBgView.isHidden = true
        self.ratingsView.isHidden = true
    }
    
    @IBAction func addtoCartACTION(_ sender: Any) {
        
        if self.cartID != "" {
            wsUpdateProduct(cartID: self.cartID, qty: (self.quantityNo.text ?? ""), productID: self.productDetails?.data?.product?._id ?? "", priceRangeID: self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].id ?? "")
        }else{
            wsAddToCart(product_id: self.productDetails?.data?.product?._id ?? "", pricing_range_id: self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].id ?? "",
                        quantity: self.quantityNo.text?.doubleValue() ?? 1.0)
        }
    }
    @IBAction func BtnCountinueShopping(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func BtnViewCart(_ sender: Any) {
        if let navigationController = self.navigationController {
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.selectedIndex = 2
            navigationController.popToRootViewController(animated: true)
        }
    }
    @IBAction func submitButtonAction(_ sender: Any) {
        self.changeQtyTextField.resignFirstResponder()
        guard let presentValue = Double(self.changeQtyTextField.text ?? "") else { return }
        self.changeQtyBgView.isHidden = true
        self.changeQuantityPopUP.isHidden = true
        
        if presentValue == 0.0 {
            self.showCustomAlert(message: "Please Enter proper value",isSuccessResponse: false,buttonTitle:  "Try Again")
            return
        }
        self.quantityNo.text = String(presentValue)
        quantitrySelected = presentValue
        self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart = Double(presentValue)
        if self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id != ""{
            self.cartID = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id ?? ""
        }
        
        let priceValue = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].ref!
        let quatity = (self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart ?? 0.0)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.changeQtyBgView.isHidden = true
        self.changeQuantityPopUP.isHidden = true
        self.changeQtyTextField.text = ""
    }
    
    //onclick of back image arrow
    @IBAction func backTapped(_ sender: UIButton){
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    //on click of wishlist, calling the add or remove wishist based on the product view details wishlist data
    @IBAction func wishlistTapped(_ sender: UIButton){
        if(!isWishlistAdd) {
            self.addProductToWishlist()
        } else {
            self.removeProductFromWishlist()
        }
    }
    
    @IBAction func viewAllAction(_ sender: Any) {
        globalCreateOrderAddress = 1
        let vc = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addQtyButtonClicked(_ sender: UIButton) {
        self.addMinusStackView.isHidden = false
        self.addQuantityView.isHidden = true
        self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart = Double(1.0)
        let quantity = (Double(self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].pricemoq?.intValue ?? 1))
        let cost = Double((self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].ref)!)
        self.quantityNo.text = "\(quantity)"
        self.getTotalPrice(priceRange: (self.productDetails?.data?.product?.pricing_range)!)
        self.totalPriceTOCartLabel.text = "AED " + "\(String(format: "%.1f", totalPrice))"
        wsAddToCart(product_id: self.productDetails?.data?.product?._id ?? "", pricing_range_id: self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].id ?? "",
                    quantity: self.quantityNo.text?.doubleValue() ?? 1.0)
    }
    
    //onclick of add button
    @IBAction func btnAddClicked(_ sender: UIButton){
        self.quantityNo.text = "\(String(describing: self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].pricemoq))"
        wsAddToCart(product_id: self.productDetails?.data?.product?._id ?? "", pricing_range_id: self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].id ?? "",
                    quantity: self.quantityNo.text?.doubleValue() ?? 1.0)
    }
    
    //onclick of minus image icon
    @IBAction func btnMinusClicked(_ sender: UIButton){
        guard let presentValue = Double((self.quantityNo.text)!) else { return }
        
        if self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id  != "" {
            self.cartID = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id ?? ""
        }
        if presentValue >= 1{
            let newValue:Double = presentValue - 1
            if newValue >=
                Double(self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].pricemoq?.rawValue ?? "0.0")!.roundTo(places: 2){
                self.quantityNo.text = String(format: "%.1f", newValue)
                quantitrySelected = newValue
                self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart = Double(String(format: "%.1f", newValue) )
                
                if self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id != ""{
                    self.cartID = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id ?? ""
                }
            } else {
                quantitrySelected = 1.0
                self.addMinusStackView.isHidden = false
            }
            
        }else{
            quantitrySelected = 1.0
            self.addMinusStackView.isHidden = false
        }
    }
    
    //onclick of plus image icon
    @IBAction func btnPlusClicked(_ sender: UIButton){
        guard let presentValue = Double(self.quantityNo.text ?? "") else { return }
        let newValue = presentValue + 1
        self.quantityNo.text = String(format: "%.1f", newValue)
        quantitrySelected = newValue
        self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart = Double(String(format: "%.1f", newValue) )
        
        let priceValue = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].ref!
        let quatity = (self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart ?? 0.0)
        if self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id != ""{
            self.cartID = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].cart_id ?? ""
        }
    }
    
    //button seller name
    @IBAction func BtnSellerNameButton(_ sender: Any) {
        let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
        objItemDetailVC.supplierID = self.productDetails?.data?.product?.supplier_info?._id ?? ""
        objItemDetailVC.strImage = self.productDetails?.data?.product?.supplier_info?.profile ?? ""
        objItemDetailVC.strTitle = self.productDetails?.data?.product?.supplier_info?.company_name ?? ""
        objItemDetailVC.strAddress =
        "\(self.productDetails?.data?.product?.supplier_info?.address ?? "")\(self.productDetails?.data?.product?.supplier_info?.city ?? "")\(self.productDetails?.data?.product?.supplier_info?.country ?? "")"
        self.navigationController?.pushViewController(objItemDetailVC, animated: true)
    }
    @IBAction func sellerNameAction(_ sender: Any) {
        print("")
        
    }
    @IBAction func shareAction(_ sender: Any) {
        showShareActivity(msg:self.productDetails?.data?.product?.product_name ?? "", image: nil, url: nil, sourceRect: nil)
    }
}

extension ProductDetailsVC{
    func topViewController()-> UIViewController{
        var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }
        return topViewController
    }
    
    func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect:CGRect?){
        var objectsToShare = [AnyObject]()
        if let url = url {
            objectsToShare = [url as AnyObject]
        }
        if let image = image {
            objectsToShare = [image as AnyObject]
        }
        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        
        topViewController().present(activityVC, animated: true, completion: nil)
    }
}
// This method is used for create the collection cell
extension ProductDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.productDetails == nil {
            return 0
        } else {
            if collectionView == productCollection {
                if self.productDetails?.data?.product?.gallery_images?.count == 0{
                    return 1
                }else{
                    return self.productDetails?.data?.product?.gallery_images?.count ?? 0
                }
            } else if collectionView == qtyCollection {
                return self.productDetails?.data?.product?.pricing_range?.count ?? 0
            } else if collectionView == similarProductsCollectionView{
                if similarProductDetailsDic.count >= 6 {
                    return 6
                }else{
                    return similarProductDetailsDic.count
                }
            }else{
                return 0
            }
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerIndex = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width/2 ), y: scrollView.frame.height/2)
        if let indexPath = self.productCollection.indexPathForItem(at: centerIndex){
            self.handlingPageControllerDisplay(index: indexPath.item)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCell.identifier, for: indexPath) as! ProductImageCell
            
            if self.productDetails?.data?.product?.gallery_images?.count == 0{
                cell.productImage.kf.indicatorType = .activity
                cell.productImage.kf.setImage(
                    with: defaultImageurl,
                    placeholder: UIImage(named: "ic_placeholder"),
                    options: nil)
            }else{
                guard let imageUrl = productDetails?.data?.product?.gallery_images?[indexPath.row].image else {
                    return UICollectionViewCell()
                }
                let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(imageUrl)")
                cell.productImage.kf.indicatorType = .activity
                cell.productImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "ic_placeholder"),
                    options: nil)
            }
            return cell
        } else if collectionView == qtyCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductQuantityCell.identifier, for: indexPath) as! ProductQuantityCell
            let data = self.productDetails?.data?.product?.pricing_range?[indexPath.row]
            cell.priceLabel.text = "AED \(data?.ref ?? "0.0")"
            cell.qtyLabel.text = "\(data?.pricemoq?.intValue ?? 0) \(data?.priceunit ?? "Kg")"
            if selectedSizePosition == indexPath.row{
                cell.contentsView.borderColor = .red
                cell.contentsView.backgroundColor = .veryLightRed
                cell.contentsView.borderWidth = 1
                if self.productDetails?.data?.product?.pricing_range?[indexPath.row].quantity_already_in_cart ?? 0 > 0{
                    self.addMinusStackView.isHidden = false
                    self.addQuantityView.isHidden = true
                }else{
                    self.addMinusStackView.isHidden = false
                    self.addQuantityView.isHidden = false
                }
            }else{
                cell.contentsView.borderColor = .clear
                cell.contentsView.borderWidth = 1
                cell.contentsView.backgroundColor = .veryLightBlue
            }
            return cell
        }else if collectionView == similarProductsCollectionView{
            let cell = similarProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "ShopAgainCollectionViewCell", for: indexPath) as? ShopAgainCollectionViewCell
            cell?.productNameLabel.text  =  self.similarProductDetailsDic[indexPath.row].productName
            
            let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.similarProductDetailsDic[indexPath.row].productImage)")
            cell?.produtImageview.kf.indicatorType = .activity
            cell?.produtImageview.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: nil)
            cell?.productNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            cell?.backgroundView?.backgroundColor = .clear
            cell?.bgview.backgroundColor = .clear
            
            cell?.imageBackGroundView.backgroundColor  = .white
            return cell ?? UICollectionViewCell()
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productCollection {
            return CGSize(width: productCollection.frame.width, height: productCollection.frame.height)
        }else if collectionView == similarProductsCollectionView{
            return CGSize(width: self.similarProductsCollectionView.frame.width/3 , height: self.similarProductsCollectionView.frame.height)
        }else {
            return CGSize(width: qtyCollection.frame.width / 2, height: 65)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == qtyCollection{
            seletectedCartIndex = indexPath.row
            selectedSizePosition = indexPath.row
            quantitrySelected = Double(self.productDetails?.data?.product?.pricing_range?[indexPath.row].quantity_already_in_cart ?? 1)
            qtyCollection.reloadData()
            self.quantityNo.text = String(Double(String(format: "%.1f", self.productDetails?.data?.product?.pricing_range?[indexPath.row].quantity_already_in_cart ?? 1)) ?? 0.0)
            let priceValue = self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].ref!
            let quatity = (self.productDetails?.data?.product?.pricing_range?[selectedSizePosition].quantity_already_in_cart ?? 0.0)
        }else if collectionView == similarProductsCollectionView{
            prdId  = self.similarProductDetailsDic[indexPath.row].id
            getProductDetails(proudctId: self.similarProductDetailsDic[indexPath.row].id)
        }
        
    }
    
}
//MARK: API CALL
extension ProductDetailsVC {
    
    func getTotalPrice(priceRange: [PricingRangez]) {
        var price = 0.0
        for i in priceRange {
            price += (Double(i.ref ?? "0.0")! * (i.quantity_already_in_cart ?? 0.0) )
        }
        self.totalPrice = price
    }
    //This method is used for invoke the product details API
    func getProductDetails(proudctId: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "product_id=\(proudctId)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.ProductDetailsURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ProductDetailsResponseModel.self, from: responseData as! Data)
                        self.productDetails = dicResponseData
                        self.productName.text = self.productDetails?.data?.product?.product_name ?? ""
                        self.supplierName.text = self.productDetails?.data?.product?.supplier_info?.company_name ?? ""
                        self.sellerNameButton.setTitle(self.productDetails?.data?.product?.supplier_info?.company_name ?? "", for: .normal)
                        self.sellerRatingsButton.setTitle(String(Double(self.productDetails?.data?.supplierInfo?.ratings ?? 0) ), for: .normal)
                        self.desc.text = self.productDetails?.data?.product?.long_desc ?? ""
                        self.userTypeId = self.productDetails?.data?.product?.user_type_id ?? ""
                        self.productCode = self.productDetails?.data?.product?.product_code ?? ""
                        self.defaultImageurl = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.productDetails?.data?.product?.product_image ?? "")")
                        self.ratingImage.rating = Double(self.productDetails?.data?.supplierInfo?.ratings ?? 0)
                        self.cartID = self.productDetails?.data?.product?.pricing_range?[0].cart_id ?? ""
                        if((self.productDetails?.data?.product?.pricing_range?[0].quantity_already_in_cart)! > 0) {
                            self.quantityNo.text = String(Double(String(format: "%.1f", self.productDetails?.data?.product?.pricing_range?[0].quantity_already_in_cart ?? 1)) ?? 0.0)
                        }
                        self.quantitrySelected = Double(self.productDetails?.data?.product?.pricing_range?[0].quantity_already_in_cart ?? 0)
                        
                        let priceValue = self.productDetails?.data?.product?.pricing_range?[0].ref!
                        let quatity = (self.productDetails?.data?.product?.pricing_range?[0].quantity_already_in_cart ?? 0.0)
                        
                        self.getTotalPrice(priceRange: (self.productDetails?.data?.product?.pricing_range)!)
                        self.totalPriceTOCartLabel.text = "AED " + "\(String(format: "%.1f", self.totalPrice))"
                        //need to check the wishlist data coming as null or array
                        if (self.productDetails?.data?.wishlist != nil) {
                            self.isWishlistAdd = true
                            self.wishlistImage.setImage(UIImage(named: "Icon feather-heart (1)"), for: .normal)
                        } else {
                            self.isWishlistAdd = false
                            self.wishlistImage.setImage(UIImage(named: "Icon feather-heart"), for: .normal)
                        }
                        self.similarProductDetailsDic = self.productDetails?.similarProducts ?? [SimilarProduct]()
                        DispatchQueue.main.async {
                            self.qtyCollection.reloadData()
                            self.productCollection.delegate = self
                            self.productCollection.dataSource = self
                            self.productCollection.reloadData()
                            self.similarProductsCollectionView.reloadData()
                            
                            if self.productDetails?.data?.product?.gallery_images?.count ?? 0 >= 1{
                                self.pageController.isHidden = false
                                self.pageController.numberOfPages =   self.productDetails?.data?.product?.gallery_images?.count ?? 0
                            }else{
                                self.pageController.isHidden = true
                            }
                            
                        }
                        
                    }catch let err {
                        print(self.sessionError,err)
                        self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false,buttonTitle: "Try again")
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoke the add wishlist API
    func addProductToWishlist(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "supplier_id=\(self.userTypeId)&product_code=\(self.productCode)"
        APICall().post(apiUrl: Constants.WebServiceURLs.AddWishlistURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.isWishlistAdd = true
                            self.wishlistImage.setImage(UIImage(named: "Icon feather-heart (1)"), for: .normal)
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
    //This method is used for invoke the remove wishlist API
    func removeProductFromWishlist(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "product_code=\(self.productCode)"
        APICall().post(apiUrl: Constants.WebServiceURLs.RemoveWishlistURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.isWishlistAdd = false
                            self.wishlistImage.setImage(UIImage(named: "Icon feather-heart"), for: .normal)
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
    //This method is used for invoke the add to cart API
    func wsAddToCart(product_id : String,pricing_range_id: String,quantity: Double){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            // showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            outletID = ""
        }
        let postString = "product_id=\(product_id)&pricing_range_id=\(pricing_range_id)&quantity=\(quantity)&outlet_id=\(outletID)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.AddToCartURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(AddProductResponseModel.self, from: responseData as! Data)
                        self.cartID = dicResponseData.data.cartID
                        self.changeQtyBgView.isHidden = false
                        self.ProductAddCart.isHidden = false
                        
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
    //This method is used for invoke the cart list API
    func wsCartGet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        self.arrCartListResponse.removeAll()
        APICall().get(apiUrl: Constants.WebServiceURLs.cartListURL){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(CartListResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            if let data = dicResponseData.data {
                                self.arrCartListResponse = [data]
                            }
                            if let data = dicResponseData.data {
                                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: [data][0].totalProductCount?.intValue)
                                self.arrCartListResponse = [data]
                            }
                            if self.arrCartListResponse.count > 0 {
                                //       self.totalConsoldatedAmount = dicResponseData.data?.consolidatedPayableAmount ?? 0.0
                                self.arrCartProductListResponse = self.arrCartListResponse.first?.cart ?? [Cart]()
                                let singleDict = self.arrCartProductListResponse.firstIndex { single in
                                    return single.supplierID == self.supplierID
                                }
                                self.seletectedCartIndex = singleDict ?? 0
                                self.arrProductsInfo = self.arrCartProductListResponse[singleDict ?? 0].productsInfo ?? [ProductsInfo]()
                                //         self.arrdeliverySchedule = self.arrCartProductListResponse[singleDict ?? 0].deliverySchedule ?? [DeliverySchedule]()
                                if self.arrProductsInfo.count == 0 {
                                    self.showCustomAlert(message: "No records found.",isSuccessResponse: false)
                                    return
                                }
                                let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrCartProductListResponse[singleDict ?? 0].supplierInfo.supplierProfile?.rawValue ?? "")")
                                
                                let date = self.arrCartProductListResponse[singleDict ?? 0].deliveryRequested?.deliveryDate?.rawValue
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateStyle = .medium
                                dateFormatter.dateFormat = "dd/MM/yyyy"
                                let StringDate = dateFormatter.date(from: date ?? "")
                                dateFormatter.dateFormat = "dd/MM/yyyy"
                                let dateString = dateFormatter.string(from: StringDate ?? Date())
                                if self.arrCartProductListResponse[singleDict ?? 0].notes?.rawValue == nil {
                                    print("")
                                }
                                self.cartID =  self.arrCartProductListResponse[singleDict ?? 0].id
                                if let profileId = self.arrCartProductListResponse[0].supplierInfo.supplierProfileID?.rawValue, profileId != ""  {
                                    //                         self.payTabsPaymentProfileID = profileId
                                }
                            }
                            //                    self.btnPayNowToggle()
                        } else {
                            self.showCustomAlert(message: dicResponseData.message)
                            
                        }
                    }catch let err {
                        print(self.sessionError,err)
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: 0)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for invoke the update product API
    func wsUpdateProduct(cartID: String,qty : String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(self.cartID)&product_id=\(productID)&price_range_id=\(priceRangeID)&qty=\(qty)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartUpdateProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UpdateProductCartModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1"{
                            
                            let dictionary =  dicResponseData.data?.updatedCart?.productsInfo
                            
                            let cost = dictionary?.filter({ i in
                                i.id == productID
                            })
                            let price  = (Double(cost?[0].qty?.rawValue ?? "1.0" ) ?? 1.0) * (Double(cost?[0].pricePerUnit?.rawValue ??  "1.0") ?? 1.0)
                            self.totalPriceTOCartLabel.text = "AED " + "\(String(format: "%.1f", price))"
                            self.changeQtyBgView.isHidden = false
                            self.ProductAddCart.isHidden = false
                            
                        }else{
                            self.showCustomAlert(message: dicResponseData.message,isSuccessResponse: false)
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
    //This method is used for invoke the delete product API
    func wsDeleteProduct(cartID: String, productID :String, priceRangeID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "cart_id=\(self.cartID)&product_id=\(productID)&pricing_range_id=\(priceRangeID)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.cartDeleteProductURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.wsCartGet()
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
extension ProductDetailsVC{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text != nil else { return true }
        if (textField.text?.isEmpty ?? true) && (string == ".") {
            return false
        }
        if (textField.text?.contains(".") ?? false) && string == "." {
            return false
        }
        
        if string.isEmpty {
            return true
        }
        let allowedCharacters = "0123456789."
        if !allowedCharacters.contains(string) {
            return false
        }
        
        let price = textField.text ?? ""
        if price.contains(".") {
            let paise = (price.components(separatedBy: ".").last ?? "") + string
            return paise.count <= 1
        } else {
            let rupee = (price.components(separatedBy: ".").first ?? price) + string
            
            let ruppeint = Int(price.components(separatedBy: ".").first ?? string) ?? 0
            if ruppeint <= 10 {
                return true
            }
            return rupee.count <= 10
        }
    }
}

extension String{
    //MARK: Restrict characters
    func restrictChars(_ allowChar: String)-> Bool{
        return CharacterSet(charactersIn: allowChar).isSuperset(of: CharacterSet(charactersIn: self))
    }
    
}
