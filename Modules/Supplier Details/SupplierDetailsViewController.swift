//
//  SupplierDetailsViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 15/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import Cosmos
import FittedSheets
import MessageUI

class SupplierDetailsViewController: UIViewController, getCartCount {
    
    @IBOutlet weak var ProductToadd             : UIView!
    @IBOutlet weak var WishlistDelete           : UIView!
    @IBOutlet weak var WishlistAdded            : UIView!
    @IBOutlet weak var supplierImage            : UIImageView!
    @IBOutlet weak var callButton               : UIButton!
    @IBOutlet weak var blockButton              : UIButton!
    @IBOutlet weak var locationButton           : UIButton!
    @IBOutlet weak var mailButton               : UIButton!
    @IBOutlet weak var heartButton              : UIButton!
    @IBOutlet weak var ratingsView              : CosmosView!
    @IBOutlet weak var supplierNameLbl          : UILabel!
    @IBOutlet weak var supplierAddressLabell    : UILabel!
    @IBOutlet weak var searchButton             : UIButton!
    @IBOutlet weak var filterButton             : UIButton!
    @IBOutlet weak var suppliersCollectionView: UICollectionView!
    @IBOutlet weak var menuView                 : UIView!
    @IBOutlet weak var searchTextField          : UITextField!
    @IBOutlet weak var submenuButton            : UIButton!
    @IBOutlet weak var bgView                   : UIView!
    @IBOutlet weak var chnageProductQuantityView: UIView!
    @IBOutlet weak var btnSubmitChangeProductQuantity: UIButton!
    @IBOutlet weak var txtChangeProductQuantity : UITextField!
    @IBOutlet weak var nodataLabel              : UILabel!
    @IBOutlet weak var nodataView               : UIView!
    @IBOutlet weak var mySupplierButton         : UIButton!
    @IBOutlet weak var ImageNoCart              : UIImageView!
    @IBOutlet weak var lblNoCart                : UILabel!
    @IBOutlet weak var filterCollectionView : UICollectionView!
    @IBOutlet weak var filterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterDropDown       : UIButton!
    @IBOutlet weak var filterView           : UIView!
    @IBOutlet weak var filtersSlectedLabel  : UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var catogaryDropDown: UIButton!
    
    var arrItemDetailResponse           : ItemDetailResponse?
    var arrProductList                  = [Product]()
    var categoryList                    = [CategoryInfo]()
    var supplierID                      = ""
    var strImage                        = ""
    var strTitle                        = ""
    var strAddress                      = ""
    var ratings                         = 0.0
    var userTypeId                      = ""
    var strSearch                       = ""
    var arrTempCategoryID               = NSMutableArray()
    var arrTempSubCategoryID            = NSMutableArray()
    var arrTempPrinceID                 = NSMutableArray()
    var responseCountProductList        = 0
    var isBottomRefreshMySupplierList   = false
    var cartID                          = ""
    var tappedRowCount                  = "0"
    var pageMySupplierList              = 1
    var selectedRowCartId               = ""
    var selectedRowProductId            = ""
    var selectedRowPriceRangeId         = ""
    var productID                       = ""
    var isWishlistAdd                   = false
    var reloadSupplierListApi           = false
    var selectedProductIndexPath        = 0
    var categoryHeight:CGFloat          = 0
    var subCategoryheight:CGFloat       = 0
    var filterHeight:CGFloat            = 0
    var filterArray = ["Price - (High to Low)","Price - (Low to High)","Popularity - (High to Low)", "Alphabetical (A to Z)", "Alphabetical (Z to A)"]
    var selectedIndexPath                :IndexPath?
    var selectedCategoryPath             :IndexPath?
    var clearAllOrShowButtonTapped       = false
    lazy var isLoading                   = false
    var lightPink = hexStringToUIColor(hex: "#FFF5FA")
    var darkPink = hexStringToUIColor(hex: "#EC187B")
    var lightBlue = hexStringToUIColor(hex: "#EDF5FF")
    var sessionError = "Session Error: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductToadd.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        ImageNoCart.isHidden       = true
        lblNoCart.isHidden       = true
        WishlistDelete.isHidden       = true
        WishlistAdded.isHidden       = true
        uIElementsSetup()
        textSetup()
        registerXibs()
        self.wsProductListURL(page: 1, search: "", sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true,app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if reloadSupplierListApi == true{
            self.wsProductListURL(page: 1, search: "", sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.filterCollectionView.layoutIfNeeded()
        self.filterHeight = self.filterCollectionView.contentSize.height
        self.filterHeightConstraint.constant = self.filterCollectionView.contentSize.height
    }
    func uIElementsSetup(){
        self.mySupplierButton.isHidden          = true
        self.ratingsView.isUserInteractionEnabled = true
        self.menuView.isHidden                  = true
        self.filterView.isHidden                = true
        self.bgView.isHidden                    = true
        self.bgView.alpha                       = 0.6
        self.bgView.backgroundColor             = .black
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(strImage)")
        self.supplierImage.kf.indicatorType      = .activity
        self.supplierImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "HomePlaceHolder"),
            options: nil)
        self.ratingsView.rating =  Double(self.ratings)
        self.searchTextField.delegate = self
        self.searchTextField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.catogaryDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if searchTextField.text?.count ?? 0 == 0{
            strSearch                    = ""
            pageMySupplierList           = 1
            isBottomRefreshMySupplierList = false
            performAction()
        }
    }
    
    func textSetup(){
        //        supplierAddressLabell.text  = "Opp. SP Wellington Grand PO Box No - 764524 \n Near by Dubai Mall"
        self.searchTextField.setLeftPaddingPoints(34)
        self.searchTextField.placeholder  = "Search"
        self.supplierNameLbl.text = strTitle
        self.supplierAddressLabell.text = strAddress
    }
    func registerXibs(){
        suppliersCollectionView.register(UINib.init(nibName: "SupplierCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SupplierCollectionViewCell")
        suppliersCollectionView.register(UINib.init(nibName: "LoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCollectionViewCell")
        filterCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        categoryCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        self.filterCollectionView.dataSource = self
        self.filterCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
    }
    
    func addshadowToButton(button:UIButton){
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true;
        button.layer.shadowColor = UIColor(hexFromString: "#E1EFFC").cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.shadowRadius = 6.0
        button.layer.masksToBounds = false
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        filterView.isHidden = false
        self.searchTextField.resignFirstResponder()
        bgView.isHidden     = false
        self.categoryCollectionView.reloadData()
        let outletHeight = categoryCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.categoryHeightConstraint.constant = outletHeight > 240 ? outletHeight + 15 : outletHeight + 10
        self.categoryCollectionView.layoutIfNeeded()
        self.categoryCollectionView.reloadData()
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        print("")
        
    }
    @IBAction func mailAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["amazon@watermelon.com"])
            mail.setMessageBody("Test", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Cannot send email")
        }
    }
    @IBAction func stopButtonAction(_ sender: Any) {
        wsAddToBlock()
    }
    @IBAction func changeQtyCloseAction(_ sender: Any) {
        bgView.isHidden                    = true
        chnageProductQuantityView.isHidden = true
    }
    @IBAction func callAction(_ sender: Any) {
        if let phoneCallURL = URL(string: "telprompt://\(self.arrProductList[0].supplierInfo.phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    @IBAction func BtnCountinueShopping(_ sender: Any) {
        self.bgView.isHidden = true
        self.ProductToadd.isHidden = true
    }
    @IBAction func BtnViewCart(_ sender: Any) {
        self.bgView.isHidden = true
        self.ProductToadd.isHidden = true
        if let navigationController = self.navigationController {
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.selectedIndex = 2
            navigationController.popToRootViewController(animated: true)
        }
    }
    @IBAction func favouriteAction(_ sender: Any) {
        if USERDEFAULTS.getDataForKey(.isLogin) as! String == "false" {
            let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            dashboardVC.modalPresentationStyle = .fullScreen
        }else{
            wsRemoveFavSupplier()
        }
    }
    
    @IBAction func mysupplierAction(_ sender: Any) {
        addMySupplier()
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        if submenuButton.isSelected{
            menuView.isHidden = true
        }else{
            menuView.isHidden = false
        }
        submenuButton.isSelected = !submenuButton.isSelected
    }
    @IBAction func filterDropDownAction(_ sender: Any) {
        if filterDropDown.isSelected{
            filterDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            filterHeightConstraint.constant = filterHeight
        }else{
            filterDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            filterHeightConstraint.constant = 0
        }
        filterDropDown.isSelected = !filterDropDown.isSelected
        
    }
    @IBAction func categoryDropDown(_ sender: Any) {
        if catogaryDropDown.isSelected{
            catogaryDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            categoryCollectionView.isHidden = false
        }else{
            catogaryDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            categoryCollectionView.isHidden = true
        }
        catogaryDropDown.isSelected = !catogaryDropDown.isSelected
    }
    
    @IBAction func clearAllAction(_ sender: Any) {
        self.arrItemDetailResponse = nil
        self.clearAllOrShowButtonTapped = true
        self.selectedIndexPath  = nil
        self.selectedCategoryPath = nil
        self.filterCollectionView.reloadData()
        self.arrProductList.removeAll()
        self.arrTempCategoryID.removeAllObjects()
        self.strSearch                  = ""
        self.bgView.isHidden            = true
        self.filterView.isHidden        = true
        self.subCategoryheight         = 0.0
        self.ImageNoCart.isHidden       = true
        self.lblNoCart.isHidden         = true
    }
    
    @IBAction func showResultAction(_ sender: Any) {
        clearAllOrShowButtonTapped = true
        if let row = selectedIndexPath?.row{
            bgView.isHidden = true
            filterView.isHidden = true
            selectedFilter(indexPath:row)
        }else if let row = selectedCategoryPath?.row{
            bgView.isHidden = true
            filterView.isHidden = true
            selectedCategoryFilter(indexPath:row)
        }else{
        }
    }
    
    @IBAction func filtersCloseAction(_ sender: Any) {
        filterView.isHidden = true
        bgView.isHidden     = true
        self.arrTempCategoryID.removeAllObjects()
        if !clearAllOrShowButtonTapped{
            selectedIndexPath = nil
            self.filterCollectionView.reloadData()
            self.categoryCollectionView.reloadData()
        }
    }
    @IBAction func btnSubmitChangeProductQuantityPopupAct(_ sender: Any) {
        self.txtChangeProductQuantity.resignFirstResponder()
        guard let presentValue = Double(self.txtChangeProductQuantity.text ?? "") else { return }
        self.bgView.isHidden = true
        self.chnageProductQuantityView.isHidden = true
        if presentValue == 0.0 {
            self.showCustomAlert(message: "Quantity must not be less than zero",isSuccessResponse: false,buttonTitle:  "Try Again")
            return
        }
        if Validation().isEmpty(txtField: txtChangeProductQuantity.text!){
            self.showCustomAlert(message:Constants.AlertMessage.qty)
        } else {
            self.bgView.isHidden = true
            self.chnageProductQuantityView.isHidden = true
            let cell: SupplierCollectionViewCell? = (self.suppliersCollectionView.cellForItem(at: IndexPath(row: Int(self.tappedRowCount)!, section: 0)) as? SupplierCollectionViewCell)
            cell?.quantityStackView.isHidden = false
            cell?.cartbutton.isHidden = true
            cell?.addedQuantityLabel.text = String(self.txtChangeProductQuantity.text!)
            //calling the update product method
            wsUpdateProductQuantity(cartID: self.selectedRowCartId,
                                    qty: self.txtChangeProductQuantity.text!,
                                    productID: self.selectedRowProductId,
                                    priceRangeID: self.selectedRowPriceRangeId)
        }
    }
}
//This method is used for textfield retun
extension SupplierDetailsViewController {
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.count ?? 0 >= 1{
            performAction()
            searchTextField.resignFirstResponder()
        }
        return true
    }
    
    func performAction() {
        pageMySupplierList = 1
        self.arrProductList.removeAll()
        isBottomRefreshMySupplierList   = false
        strSearch = searchTextField.text ?? ""
        self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
    }
    //This method is used for scroll in supplier collection view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            if scrollView as? UICollectionView == self.suppliersCollectionView {
                let offsetY = scrollView.contentOffset.y
                if offsetY > self.suppliersCollectionView.visibleSize.height{
                    let contentHeight = scrollView.contentSize.height
                    if (offsetY > contentHeight - scrollView.frame.height * 4) && !isBottomRefreshMySupplierList  {
                        if responseCountProductList > self.arrProductList.count {
                            isBottomRefreshMySupplierList = true
                            loadMoreFromBottom()
                        }
                    }
                }
            }
        }
    }
    func loadMoreFromBottom(){
        if !self.isLoading {
            self.isLoading = true
            pageMySupplierList = pageMySupplierList + 1
            self.suppliersCollectionView.refreshControl?.showWithAnimation(onView: self.suppliersCollectionView, animation: .bottom)
            self.wsProductListURL(page: pageMySupplierList, search: "", sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: false, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
        }
    }
}
//This method is used for create the collection view cell
extension SupplierDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView{
            return filterArray.count
        }else if collectionView == categoryCollectionView{
            return categoryList.count
        }else {
            if section == 0 {
                return arrProductList.count
            }else{
                return 1
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView ==  suppliersCollectionView{
            return arrProductList.count < responseCountProductList ? 2 : (arrProductList.count > 0 ? 1 :0)
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView{
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            cell.layer.cornerRadius         = 20
            cell.filteredLabel.text = filterArray[indexPath.item]
            if selectedIndexPath == indexPath{
                cell.bgView.borderWidth = 1
                cell.bgView.backgroundColor =  lightPink
                cell.bgView.borderColor     = darkPink
            }else{
                cell.bgView.borderWidth = 1
                cell.bgView.backgroundColor = lightBlue
                cell.bgView.borderColor     = lightBlue
            }
            return cell
        }else if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as? FilterCollectionViewCell
            cell?.layer.cornerRadius         = 20
            print(categoryList)
            cell?.filteredLabel.text = self.categoryList[indexPath.row].categoryName
            if selectedCategoryPath == indexPath{
                arrTempCategoryID.contains(categoryList[indexPath.row].id)
                cell?.bgView.borderWidth = 1
                cell?.bgView.backgroundColor =  lightPink
                cell?.bgView.borderColor     =  darkPink
            }else{
                cell?.bgView.borderWidth = 1
                cell?.bgView.backgroundColor = lightBlue
                cell?.bgView.borderColor     = lightBlue
            }
            return cell ?? UICollectionViewCell()
        }else{
            if indexPath.section == 0{
                let cell = suppliersCollectionView.dequeueReusableCell(withReuseIdentifier: "SupplierCollectionViewCell", for: indexPath) as? SupplierCollectionViewCell
                if self.arrProductList.count == 0{
                    return UICollectionViewCell()
                }
                
                cell?.productName.text = self.arrProductList[indexPath.row].productName
                cell?.supplierNameLabel.text = "\(self.arrProductList[indexPath.row].supplierInfo.companyName )"
                cell?.reviewView.isUserInteractionEnabled = false
                let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrProductList[indexPath.row].productImage )")
                cell?.productImageView.kf.indicatorType = .activity
                cell?.productImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "HomePlaceHolder"),
                    options: nil)
                
                if  self.arrProductList[indexPath.row].pricingRange[0].discountPercentange == 0.0 {
                    cell?.greenBgImageView.isHidden = true
                    cell?.discountPercetagelabel.isHidden = true
                }else{
                    cell?.greenBgImageView.isHidden = false
                    cell?.discountPercetagelabel.isHidden = false
                    cell?.discountPercetagelabel.text =  "\(Int(self.arrProductList[indexPath.row].pricingRange[0].discountPercentange))%"
                }
                cell?.productpriceLabel.text = "AED \(self.arrProductList[indexPath.row].pricingRange[0].ref?.rawValue ?? "")"
                
                if self.arrProductList[indexPath.row].pricingRange.count > 0{
                    cell?.reviewView.rating = Double(self.arrProductList[indexPath.row].supplierInfo.ratings) ?? 0.0
                }
                
                cell?.quantityLabel.text = "\(self.arrProductList[indexPath.row].pricingRange[0].displaySkuName)"
                
                if self.arrProductList[indexPath.row].wishListStatus == true{
                    cell?.heartButton.setImage(UIImage(named: "Icon feather-heart (1)"), for: .normal)
                } else {
                    cell?.heartButton.setImage(UIImage(named: "Icon feather-heart"), for: .normal)
                }
                
                if let id = self.arrProductList[indexPath.row].pricingRange[0].pricemoq {
                    cell?.addedQuantityLabel.text = "\(id.intValue ?? 0)"
                }
                
                if self.arrProductList[indexPath.row].pricingRange[0].quantityAlreadyInCart?.intValue != 0 && self.arrProductList[indexPath.row].pricingRange.count == 1{
                    cell?.quantityStackView.isHidden = false
                    cell?.cartbutton.isHidden = true
                    cell?.addedQuantityLabel.text = "\(self.arrProductList[indexPath.row].pricingRange[0].quantityAlreadyInCart?.rawValue ?? "")"
                    
                }else  if self.arrProductList[indexPath.row].pricingRange.count > 1{
                    cell?.quantityStackView.isHidden = true
                    cell?.cartbutton.isHidden = true
                    cell?.productpriceLabel.isHidden = true
                    cell?.quantityLabel.text = ""
                    
                } else {
                    cell?.quantityStackView.isHidden = true
                    cell?.cartbutton.isHidden = false
                    cell?.productpriceLabel.isHidden = false
                    cell?.quantityLabel.isHidden = false
                }
                cell?.heartButton.tag = indexPath.row
                cell?.heartButton.addTarget(self , action:#selector(heartClicked(sender:)), for: .touchUpInside)
                
                cell?.cartbutton.tag = indexPath.row
                cell?.cartbutton.addTarget(self , action:#selector(btnAddClicked(sender:)), for: .touchUpInside)
                
                cell?.plusButton.tag = indexPath.row
                cell?.plusButton.addTarget(self , action:#selector(btnPlusClicked(sender:)), for: .touchUpInside)
                
                cell?.minusButton.tag = indexPath.row
                cell?.minusButton.addTarget(self , action:#selector(btnMinusClicked), for: .touchUpInside)
                
                let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
                cell?.addedQuantityLabel.tag = indexPath.row
                cell?.addedQuantityLabel.isUserInteractionEnabled = true
                cell?.addedQuantityLabel.addGestureRecognizer(labelTap)
                
                return cell ?? SupplierCollectionViewCell()
            }else{
                let cell = suppliersCollectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionViewCell", for: indexPath) as? LoadingCollectionViewCell
                if self.arrProductList.count == 0{
                    return UICollectionViewCell()
                }
                
                cell?.activityLoading.startAnimating()
                if arrProductList.count == self.responseCountProductList {
                    cell?.activityLoading.isHidden = true
                }else{
                    cell?.activityLoading.isHidden = false
                }
                return cell ?? LoadingCollectionViewCell()
            }
        }
    }
    @objc func heartClicked(sender:UIButton) {
        if USERDEFAULTS.getDataForKey(.isLogin) as! String == "false" {
            let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            dashboardVC.modalPresentationStyle = .fullScreen
            
        }else{
            selectedProductIndexPath = sender.tag
            if self.arrProductList[sender.tag].wishListStatus == true{
                removeProductFromWishlist(productCode: arrProductList[sender.tag].productCode)
            } else {
                addProductToWishlist(supplierId: arrProductList[sender.tag].pricingRange[0].supplierId, productCode:arrProductList[sender.tag].productCode, priceRangeID: arrProductList[sender.tag].pricingRange[0].id)
            }
        }
    }
    @objc func btnAddClicked(sender:UIButton) {
        let cell: SupplierCollectionViewCell? = (self.suppliersCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? SupplierCollectionViewCell)
        if self.arrProductList.count > 0, self.arrProductList[sender.tag].pricingRange.count > 1{
//            let controller = mainStoryboard.instantiateViewController(withIdentifier: "AddItemVC") as? AddItemVC
//            controller?.arrPayment = self.arrProductList[sender.tag]
//            controller?.outletID = outletID
//            controller?.strSelectedID = supplierID
//            controller?.strImage = strImage
//            controller?.strTitle = strTitle
//            controller?.ratings = ratings
//            controller?.strAddress = strAddress
//            let sheetController = SheetViewController(controller: controller!, sizes: [SheetSize.fixed(CGFloat((163 + (45 *
//                                                                                                                       self.arrProductList[sender.tag].pricingRange.count))))])
//            
//            controller?.delegategetCartCount = self
//            self.present(sheetController, animated: false, completion: nil)
        } else {
            cell?.quantityStackView.isHidden = false
            cell?.cartbutton.isHidden = true
            if arrProductList.count == 0{
                return
            }
            cell?.addedQuantityLabel.text = "\(self.arrProductList[sender.tag].pricingRange[0].pricemoq?.intValue ?? 1)"
            wsAddToCart(product_id: self.arrProductList[sender.tag].id, pricing_range_id: self.arrProductList[sender.tag].pricingRange[0].id, quantity: cell?.addedQuantityLabel.text?.integerValue() ?? 1, platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
    }
    
    func getCartCount() {
        self.arrProductList.removeAll()
        self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
    }
    @objc
    func btnPlusClicked(sender:UIButton) {
        let cell: SupplierCollectionViewCell? = (self.suppliersCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? SupplierCollectionViewCell)
        guard let presentValue = Double(cell?.addedQuantityLabel.text ?? "") else { return }
        let newValue = presentValue + 1
        cell?.quantityStackView.isHidden = false
        cell?.cartbutton.isHidden = true
        cell?.addedQuantityLabel.text = String(newValue)
        if self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue != nil{
            self.cartID = self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue ?? ""
        }
        wsUpdateProduct(cartID: self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue ?? "", qty: (cell?.addedQuantityLabel.text!)!, productID: self.arrProductList[sender.tag].id, priceRangeID: self.arrProductList[sender.tag].pricingRange[0].id)
    }
    @objc func btnMinusClicked(sender:UIButton) {
        let cell: SupplierCollectionViewCell? = (self.suppliersCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? SupplierCollectionViewCell)
        guard let presentValue = Double((cell?.addedQuantityLabel.text)!) else { return }
        if self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue != nil{
            self.cartID = self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue ?? ""
        }
        if presentValue >= 1{
            let newValue:Double = presentValue - 1
            if newValue >=
                Double(self.arrProductList[sender.tag].pricingRange[0].pricemoq?.rawValue ?? "0.0")!.roundTo(places: 1){
                cell?.quantityStackView.isHidden = false
                cell?.cartbutton.isHidden = true
                cell?.addedQuantityLabel.text = String(newValue)
                wsUpdateProduct(cartID: self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue ?? "", qty: (cell?.addedQuantityLabel.text!)!, productID: self.arrProductList[sender.tag].id, priceRangeID: self.arrProductList[sender.tag].pricingRange[0].id)
            } else {
                cell?.quantityStackView.isHidden = true
                cell?.cartbutton.isHidden = false
                wsDeleteProduct(cartID: self.arrProductList[sender.tag].pricingRange[0].cartID?.rawValue ?? "", productID: self.arrProductList[sender.tag].id, priceRangeID: self.arrProductList[sender.tag].pricingRange[0].id)
            }
        }
    }
    @objc func labelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        self.bgView.isHidden = false
        self.chnageProductQuantityView.isHidden = false
        //Below code will give the selected row count
        if let tag = gestureRecognizer.view?.tag {
            //print("tapped:::",tag)
            self.tappedRowCount = String(tag)
            //Based on the selected row, getting the values below
            if self.arrProductList[tag].pricingRange[0].cartID?.rawValue != nil{
                self.cartID = self.arrProductList[tag].pricingRange[0].cartID?.rawValue ?? ""
            }
            //self.cartID = self.arrProductList[tag].pricingRange[0].cartID?.rawValue ?? ""
            self.selectedRowCartId = self.arrProductList[tag].pricingRange[0].cartID?.rawValue ?? ""
            self.selectedRowProductId = self.arrProductList[tag].id
            self.selectedRowPriceRangeId = self.arrProductList[tag].pricingRange[0].id
        }
        if gestureRecognizer.state == .ended {
            //Based on the below code will get tapped label value and assigning in the opened popup
            if let theLabel = (gestureRecognizer.view as? UILabel)?.text {
                //print("tapped value::",theLabel)
                self.txtChangeProductQuantity.text = theLabel
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView{
            let text = filterArray[indexPath.item]
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 30.0
            return CGSize(width: cellWidth , height: 40.0)
        }else if collectionView == categoryCollectionView{
            let text = categoryList[indexPath.row].categoryName
            let cellWidth = (text?.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width ?? 1) + 50.0
            return CGSize(width: cellWidth, height: 38.0)
        }else{
            if indexPath.section == 0{
                return CGSize(width: self.suppliersCollectionView.frame.width/2 , height: 286)
            }else{
                return CGSize(width: self.suppliersCollectionView.frame.width , height: 60)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView{
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            if selectedIndexPath != indexPath {
                cell.bgView.borderWidth = 1
                cell.bgView.backgroundColor =  lightPink
                cell.bgView.borderColor     = darkPink
                selectedIndexPath = indexPath
            } else  {
                selectedIndexPath = nil
                cell.bgView.borderWidth = 1
                cell.bgView.backgroundColor = lightBlue
                cell.bgView.borderColor     = lightBlue
            }
            self.filterCollectionView.reloadData()
        }else if collectionView == categoryCollectionView{
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            if selectedCategoryPath != indexPath {
                cell.bgView.borderWidth = 1
                cell.bgView.backgroundColor =  lightPink
                cell.bgView.borderColor     = darkPink
                arrTempCategoryID.add(self.categoryList[indexPath.row].id)
                selectedCategoryPath = indexPath
            } else  {
                selectedCategoryPath = nil
                cell.bgView.borderWidth = 1
                cell.bgView.backgroundColor = lightBlue
                cell.bgView.borderColor     = lightBlue
                arrTempCategoryID.remove(self.categoryList[indexPath.row].id)
            }
            self.categoryCollectionView.reloadData()
        } else {
            if arrProductList.count == 0 {
                return
            }
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
            vc.prdId = self.arrProductList[indexPath.row].id
            vc.outletID = outletID
            reloadSupplierListApi = true
            vc.defaultImageurl = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrProductList[indexPath.row].productImage )")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension SupplierDetailsViewController {
    func selectedCategoryFilter (indexPath: Int){
        strSearch                    = ""
        pageMySupplierList              = 1
        responseCountProductList        = 0
        arrItemDetailResponse = nil
        arrProductList.removeAll()
        isBottomRefreshMySupplierList   = false
        
        self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "desc", sort_by: "", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
        
    }
    func selectedFilter(indexPath: Int){
        strSearch                    = ""
        pageMySupplierList              = 1
        responseCountProductList        = 0
        arrItemDetailResponse = nil
        arrProductList.removeAll()
        isBottomRefreshMySupplierList   = false
        
        if indexPath == 0 {
            //            Price High to low
            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "desc", sort_by: "", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "7")
        }else if indexPath == 1{
            //            "Rating - (Low to High)"
            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "6")
        }else if indexPath == 2 {
            //           Rating - (High to Low)
            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "desc", sort_by: "popularity", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "7")
        }else if indexPath == 3{
            //            "Rating - (Low to High)"
            
            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc" , sort_by: "popularity", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID,showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "6")
        }else if indexPath == 4{
            // "Alphabetical (A to Z)"
            
            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID,showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
        }else if indexPath == 5{
            //          "Alphabetical (z to S)"
            
            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "desc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true,app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
        }
    }
    //This fuction is used for invoking the product list API
    func wsProductListURL(page: Int,search: String,sort_method: String, sort_by: String, CategotyId: NSMutableArray, SubCategoryId: NSMutableArray,showloading:Bool, app_type: String, platform: String, fcm_token_ios: String, price: String){
        //    self.nodataLabel.isHidden = true
        ImageNoCart.isHidden       = true
        lblNoCart.isHidden       = true
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.suppliersCollectionView.isUserInteractionEnabled = true
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.productListURL
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
        }
        var arrID = [String]()
        for i in self.arrTempCategoryID{
            arrID.append(i as! String)
            print(arrTempCategoryID)
        }
        var arrSubCategoryId = [String]()
        for i in self.arrTempSubCategoryID{
            arrSubCategoryId.append(i as! String)
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
        params = ["start":0,"end":0,"page":page,"sort_method":sort_method,"keyword":search,"sort_by":sort_by,"outlet_id":outletID,"category_id":arrID,"subcategory_id":arrSubCategoryId,"supplier_id":self.supplierID,"brand": "","status":1,"price": price,"platform":"mobile", "app_type":"b2c",  "fcm_token_ios": "\(USERDEFAULTS.getDataForKey(.fcmToken))"]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                if showloading{
                    hideLoader()
                }
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    //print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                self.isLoading = false
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
                                    self.nodataView.isHidden = true
                                    self.arrItemDetailResponse = dicResponseData.data
                                    self.categoryList = dicResponseData.data.supplierCategoryList
                                    print(self.arrItemDetailResponse)
                                    print(self.categoryList)
                                    self.ratings = self.arrItemDetailResponse?.supplierInfo?.ratings ?? 0.0
                                    self.ratingsView.rating =  Double(self.ratings)
                                    self.ratingsView.didFinishTouchingCosmos = { rating in
                                        if let objRatingsVC = mainStoryboard.instantiateViewController(withIdentifier: "RatingsVC") as? RatingsVC {
                                            objRatingsVC.strSupplierName = self.strTitle
                                            objRatingsVC.strSupplierAddress = self.strAddress
                                            objRatingsVC.strImage = self.strImage
                                            objRatingsVC.supplierId = self.supplierID
                                            objRatingsVC.rating = self.arrItemDetailResponse?.supplierInfo?.ratings ?? 0.0
                                            self.navigationController?.pushViewController(objRatingsVC, animated: true)
                                        }
                                    }
                                    if self.arrItemDetailResponse?.supplierInfo?.isFavorite.boolValue == true{
                                        self.heartButton.setImage(UIImage(named: "Icon feather-heart (1)"), for: .normal)
                                    } else {
                                        self.heartButton.setImage(UIImage(named: "Icon feather-heart"), for: .normal)
                                    }
                                    
                                    if self.isBottomRefreshMySupplierList == true {
                                        self.suppliersCollectionView.refreshControl?.hideWithAnimation(hidden: true)
                                        self.arrProductList.append(contentsOf: dicResponseData.data.products)
                                    } else  {
                                        self.arrProductList = dicResponseData.data.products
                                    }
                                    self.isBottomRefreshMySupplierList = false
                                    if self.arrProductList.count > 0{
                                        self.responseCountProductList = dicResponseData.data.totalCount
                                        
                                        self.suppliersCollectionView.isHidden = false
                                        self.ImageNoCart.isHidden       = true
                                        self.lblNoCart.isHidden       = true
                                    } else {
                                        self.suppliersCollectionView.isHidden = true
                                        self.ImageNoCart.isHidden       = false
                                        self.lblNoCart.isHidden       = false
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    
                                    if self.arrProductList.count == 0 {
                                        self.arrProductList = [Product]()
                                        self.suppliersCollectionView.isHidden = true
                                        self.ImageNoCart.isHidden       = false
                                        self.lblNoCart.isHidden       = false
                                        self.nodataView.isHidden = true
                                    }
                                    self.isBottomRefreshMySupplierList = false
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.suppliersCollectionView.delegate = self
                                self.suppliersCollectionView.dataSource = self
                                self.suppliersCollectionView.reloadData()
                                self.categoryCollectionView.delegate = self
                                self.categoryCollectionView.dataSource = self
                                self.categoryCollectionView.reloadData()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.suppliersCollectionView.isUserInteractionEnabled = true
                                }
                            }
                        } catch let error as NSError {
                            print(self.sessionError,error)
                            DispatchQueue.main.async {
                                self.ImageNoCart.isHidden       = false
                                self.lblNoCart.isHidden       = false
                                self.suppliersCollectionView.isHidden = true
                                self.nodataView.isHidden = true
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
    //This method is used for adding to cart
    func wsAddToCart(product_id : String,pricing_range_id: String,quantity: Int, platform: String, fcm_token_ios: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            outletID = ""
        }
        let postString = "product_id=\(product_id)&pricing_range_id=\(pricing_range_id)&quantity=\(quantity)&outlet_id=\(outletID)&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        print(postString)
        APICall().post(apiUrl: Constants.WebServiceURLs.AddToCartURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(AddProductResponseModel.self, from: responseData as! Data)
                        self.bgView.isHidden = false
                        self.ProductToadd.isHidden = false
                        self.cartID = dicResponseData.data.cartID
                        //  self.showCustomAlert(message: dicResponseData.message)
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
    
    // remove individual fav
    func removeProductFromWishlist(productCode:String){
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
                            self.arrProductList[self.selectedProductIndexPath].wishListStatus = false
                            let indexPath = IndexPath(item:self.selectedProductIndexPath, section: 0)
                            self.suppliersCollectionView.reloadItems(at: [indexPath])
                            self.showCustomAlert(message: dicResponseData.message)
                        }else{
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
    //individual wishlist
    func addProductToWishlist(supplierId: String,productCode: String,priceRangeID:String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "supplier_id=\(supplierId)&product_code=\(productCode)&price_range_id=\(priceRangeID)"
        print(param)
        APICall().post(apiUrl: Constants.WebServiceURLs.AddWishlistURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.isWishlistAdd = true
                            self.arrProductList[self.selectedProductIndexPath].wishListStatus = true
                            let indexPath = IndexPath(item:self.selectedProductIndexPath, section: 0)
                            self.suppliersCollectionView.reloadItems(at: [indexPath])
                            self.showCustomAlert(message: dicResponseData.message)
                        }else{
                            self.showToast(message: dicResponseData.message)
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
    //This function is used for add to favorite
    func wsRemoveFavSupplier(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "user_type=1&user_id=\(USERDEFAULTS.getDataForKey(.user_type_id))&fav_id=\(supplierID)"
        APICall().post(apiUrl: Constants.WebServiceURLs.addToFavouriteSupplierURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ChangeStatusResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        if dicResponseData.success == "1"{
                            self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempCategoryID, SubCategoryId: self.arrTempSubCategoryID, showloading: true, app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))", price: "")
                        }else{
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
    //This function is used for add to my supplier
    func addMySupplier(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let postString = "supplier_id=\(supplierID)&buyer_id=\(Constants.WebServiceParameter.paramBuyerId)&user_type=1&platform:web)"
        APICall().post(apiUrl: Constants.WebServiceURLs.addSupplierBuyURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ChangeStatusResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
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
    //This function is used for block the supplier list
    func wsAddToBlock(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.addToBlockSupplierURL
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
        }
        showLoader()
        var params :[String: Any]?
        params = ["supplier_id" : supplierID]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                hideLoader()
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    //print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        print ("data = \(jsonResponse)")
                        let decoder = JSONDecoder()
                        do {
                            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                                print(convertedJsonIntoDict)
                            }
                            let dictResponse = try decoder.decode(ChangeStatusResponseModel.self, from: data )
                            
                            DispatchQueue.main.async {
                                self.showCustomAlert(message: dictResponse.message)
                                //  self.showToast(message: dictResponse.message)
                            }
                            
                        } catch let error as NSError {
                            print(error.localizedDescription)
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
    //This function is used for update the product
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
                        if dicResponseData.success == "1" {
                            self.bgView.isHidden = false
                            self.ProductToadd.isHidden = false
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
    //This function is used for delete the product
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
                        if dicResponseData.success == "1"{
                            self.showCustomAlert(message: "Product delected")
                            self.bgView.isHidden = true
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
    
    //Below method will call to update quantity of the product
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
                            self.bgView.isHidden = false
                            self.ProductToadd.isHidden = false
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
}
