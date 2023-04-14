//
//  SearchViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 30/06/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import FittedSheets

protocol getCartCount  {
    func getCartCount()
}
class SearchViewController: UIViewController, getCartCount {
    
    @IBOutlet weak var ProductToadd             : UIView!
    @IBOutlet weak var ProductUpdated           : UIView!
    @IBOutlet weak var WishlistDelete           : UIView!
    @IBOutlet weak var WishlistAdded            : UIView!
    @IBOutlet weak var lblWeAreSorry            : UILabel!
    @IBOutlet weak var ImgCart                  : UIImageView!
    @IBOutlet weak var filtericon               : UIButton!
    @IBOutlet weak var filterButton             : UIButton!
    @IBOutlet weak var searchTextField          : UITextField!
    @IBOutlet weak var notificationButton       : UIButton!
    @IBOutlet weak var backButton               : UIButton!
    @IBOutlet weak var filterCollectionView     : UICollectionView!
    @IBOutlet weak var resultsCollectionView    : UICollectionView!
    @IBOutlet weak var filterViewHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var selectedfilterView       : UIView!
    @IBOutlet weak var bgView                   : UIView!
    @IBOutlet weak var chnageProductQuantityView: UIView!
    @IBOutlet weak var btnSubmitChangeProductQuantity: UIButton!
    @IBOutlet weak var txtChangeProductQuantity : UITextField!
    @IBOutlet weak var nodataLabel              : UILabel!
    @IBOutlet weak var nodataView               : UIView!
    @IBOutlet weak var showResultsButton    : UIButton!
    @IBOutlet weak var clearAllButton       : UIButton!
    @IBOutlet weak var filtersAppliesLabel  : UILabel!
    @IBOutlet weak var filtersClosebutton   : UIButton!
    @IBOutlet weak var supplierDropDown     : UIButton!
    @IBOutlet weak var priceDropDwn         : UIButton!
    @IBOutlet weak var supplierStackview :  UIStackView!
    @IBOutlet weak var filterView           : UIView!
    @IBOutlet weak var supplierTitle        : UILabel!
    @IBOutlet weak var priceTitle           : UILabel!
    @IBOutlet weak var supplierListCollectionView: UICollectionView!
    @IBOutlet weak var suppierCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var brandDropDown                : UIButton!
    @IBOutlet weak var brandCollectionView          : UICollectionView!
    @IBOutlet weak var brandCollectionViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var priceCollectionView: UICollectionView!
    @IBOutlet weak var priceSubCOllectionViewheight: NSLayoutConstraint!
    @IBOutlet weak var reusltsViewtopConstraint: NSLayoutConstraint!
    @IBOutlet weak var supplierSeperatorLine: UILabel!
    
    var placeHolderText                  = ""
    var categoryButtoninDropdown         = true
    var subcategoryButtoninDropdown      = true
    var searchText                       = ""
    var selectedTopic                    = [String]()
    var filterproductListArray           = [FilterProduct]()
    var filterSupplierList               = [Datum]()
    var filterBrandList                  = [BrandFilter]()
    var pageMySupplierList               = 1
    var strSearch                        = ""
    var isBottomRefreshMySupplierList    = false
    var cartID                           = ""
    var selectedProductIndexPath         = 0
    var tappedRowCount                   = "0"
    var arrTempSupplierID                = NSMutableArray()
    var arrTempPrinceID                  = NSMutableArray()
    var arrTempBrandID                   = NSMutableArray()
    var supplierID                       = ""
    var arrItemDetailResponse            : ItemDetailResponse?
    var arrProductList                   = [Product]()
    var responseCountProductList         = 0
    var selectedRowCartId                = ""
    var selectedRowProductId             = ""
    var selectedRowPriceRangeId          = ""
    var strImage                         = ""
    var strTitle                         = ""
    var strAddress                       = ""
    var ratings                          = 0.0
    var didSlectTapped                   = false
    var brandheight:CGFloat              = 0
    var supplierHeight:CGFloat           = 0
    var priceheight:CGFloat              = 0
    var categoryId                       = ""
    var selectedIndexPath                :IndexPath?
    var clearAllOrShowButtonTapped       = false
    var filterlistLoaded                 = true
    lazy var isLoading                   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        ProductToadd.isHidden = true
        ProductUpdated.isHidden = true
        WishlistAdded.isHidden = true
        WishlistDelete.isHidden = true
        ImgCart.isHidden = true
        lblWeAreSorry.isHidden = true
        UIElementsSetUp()
        registerCollectionViewXibs()
        self.searchTextField.becomeFirstResponder()
        if didSlectTapped {
            self.wsProductListURL(page: 1, search: "", sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID, showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
    }
    func UIElementsSetUp(){
        self.searchTextField.placeholder    = "What are you looking for?"
        self.showFilter(bool: false)
        self.searchTextField.setLeftPaddingPoints(34)
        self.searchTextField.text = placeHolderText.count == 0 ? searchText : placeHolderText
        self.supplierStackview.isHidden = true
        self.supplierSeperatorLine.isHidden = true
        self.priceSubCOllectionViewheight.constant = 0
        self.suppierCollectionViewHeight.constant = 0
        self.brandCollectionViewConstraint.constant = 0
        priceCollectionView.isHidden = false
        bgView.isHidden                  = true
        filterView.isHidden              = true
        supplierTitle.text               = "Suppliers"
        filtersAppliesLabel.text  = "Sort & Filter"
        priceTitle.text            = "Price"
        bgView.backgroundColor           = .black
        bgView.alpha                     = 0.6
        searchTextField.delegate        = self
        self.searchTextField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.nodataView.isHidden    = true
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
    }
    
    func showFilter(bool:Bool){
        if  bool {
            selectedfilterView.isHidden        = false
            reusltsViewtopConstraint.constant = 50
            filterViewHeightConstriant.constant = 50
        } else{
            selectedfilterView.isHidden        = true
            reusltsViewtopConstraint.constant = 0
            filterViewHeightConstriant.constant = 0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if searchTextField.text?.count ?? 0 == 0{
            strSearch                    = ""
            pageMySupplierList           = 1
            isBottomRefreshMySupplierList = false
            performAction()
        }
    }
    func delegatesSetup(){
        [ resultsCollectionView].forEach({ (collectionView) in
            collectionView?.delegate = self
            collectionView?.dataSource = self
        })
    }
    func registerCollectionViewXibs(){
        filterCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        resultsCollectionView.register(UINib.init(nibName: "SupplierCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SupplierCollectionViewCell")
        resultsCollectionView.register(UINib.init(nibName: "LoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCollectionViewCell")
        supplierListCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        priceCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        brandCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
    }
    @IBAction func filterButtonAction(_ sender: Any) {
        bgView.isHidden = false
        filterView.isHidden   = false
        self.searchTextField.resignFirstResponder()
        brandCollectionView.reloadData()
        priceCollectionView.reloadData()
        supplierListCollectionView.reloadData()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.bgView.isHidden = true
        self.dismiss(animated:true)
    }
    @IBAction func BtnCountinueShopping(_ sender: Any) {
        self.bgView.isHidden = true
        self.dismiss(animated:true)
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
    @IBAction func supplierDropDownAction(_ sender: Any) {
        if supplierDropDown.isSelected{
            supplierDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            suppierCollectionViewHeight.constant = supplierHeight
        }else{
            supplierDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            suppierCollectionViewHeight.constant = 0
        }
        supplierDropDown.isSelected = !supplierDropDown.isSelected
    }
    @IBAction func BtnCountinueRemove(_ sender: Any) {
        
    }
    @IBAction func BtnCountinueSuccess(_ sender: Any) {
        
    }
    @IBAction func priceAction(_ sender: Any) {
        if priceDropDwn.isSelected{
            priceDropDwn.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            priceSubCOllectionViewheight.constant = priceheight
        }else{
            priceSubCOllectionViewheight.constant = 0.0
            priceDropDwn.setImage(UIImage(named: "menuUpArrow"), for: .normal)
        }
        priceDropDwn.isSelected = !priceDropDwn.isSelected
    }
    
    @IBAction func branddropDownAction(_ sender: Any) {
        if brandDropDown.isSelected{
            brandDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            brandCollectionViewConstraint.constant = brandheight
        }else{
            brandCollectionViewConstraint.constant = 0.0
            brandDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
        }
        brandDropDown.isSelected = !brandDropDown.isSelected
    }
    
    @IBAction func btnSubmitshowResults(_ sender: Any) {
        self.filterCollectionView.reloadData()
        self.bgView.isHidden = true
        self.filterView.isHidden = true
        clearAllOrShowButtonTapped = true
        if let row = selectedIndexPath?.row{
            slectedFilter(indexPath:row)
        }else{
            self.showCustomAlert(message: "Select filter", isSuccessResponse: false)
            
        }
    }
    
    func slectedFilter(indexPath: Int){
        if indexPath == 0 {
            self.wsProductListURL(page: 1, search: searchText, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 1 {
            self.wsProductListURL(page: 1, search: searchText, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 2 {
            self.wsProductListURL(page: 1, search: searchText, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 3 {
            self.wsProductListURL(page: 1, search: searchText, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 4 {
            self.wsProductListURL(page: 1, search: searchText, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 5 {
            self.wsProductListURL(page: 1, search: searchText, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
        
    }
    @IBAction func notificationNavigation(_ sender: Any) {
        let notificationVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    @IBAction func filterCloseView(_ sender: Any) {
        self.bgView.isHidden = true
        self.filterView.isHidden = true
        if clearAllOrShowButtonTapped == false{
            filtersAppliesLabel.text  = "Sort & Filter"
            self.selectedTopic.removeAll()
            self.arrTempSupplierID.removeAllObjects()
            self.arrTempPrinceID.removeAllObjects()
            self.arrTempBrandID.removeAllObjects()
            self.brandCollectionView.reloadData()
            self.supplierListCollectionView.reloadData()
            self.priceCollectionView.reloadData()
            self.filterCollectionView.reloadData()
        }
    }
    @IBAction func clearAllAction(_ sender: Any) {
        filtersAppliesLabel.text  = "Sort & Filter"
        self.selectedIndexPath  = nil
        self.bgView.isHidden = true
        self.filterView.isHidden = true
        selectedTopic.removeAll()
        filterCollectionView.reloadData()
        pageMySupplierList               = 1
        strSearch                        = ""
        searchTextField.text             = ""
        self.selectedTopic.removeAll()
        self.arrTempSupplierID.removeAllObjects()
        self.arrTempPrinceID.removeAllObjects()
        self.arrTempBrandID.removeAllObjects()
        self.brandCollectionView.reloadData()
        self.supplierListCollectionView.reloadData()
        self.priceCollectionView.reloadData()
        self.filterCollectionView.reloadData()
        self.wsProductListURL(page: 1, search: "", sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID, showloading: true, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
    }
    @IBAction func changeProductSubmitaction(_ sender: Any) {
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
            
            let cell: SupplierCollectionViewCell? = (self.resultsCollectionView.cellForItem(at: IndexPath(row: Int(self.tappedRowCount)!, section: 0)) as? SupplierCollectionViewCell)
            
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
    
    @IBAction func closeButton(_ sender: Any) {
        bgView.isHidden                    = true
        chnageProductQuantityView.isHidden = true
        selectedIndexPath = nil
    }
}

extension SearchViewController {
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
        self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID, showloading: true,platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
    }
    // This method is used for scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchTextField.resignFirstResponder()
        if let _ = scrollView as? UICollectionView {
            if scrollView as? UICollectionView  == resultsCollectionView{
                let offsetY = scrollView.contentOffset.y
                if offsetY >= self.resultsCollectionView.visibleSize.height{
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
    //This method is used for load more data
    func loadMoreFromBottom(){
        if !self.isLoading {
            self.isLoading = true
            pageMySupplierList = pageMySupplierList + 1
            self.resultsCollectionView.refreshControl?.showWithAnimation(onView: self.resultsCollectionView, animation: .bottom)
            self.wsProductListURL(page: pageMySupplierList, search: "", sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,showloading: false, platform: "mobile", app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
        
    }
}
//This method is used for create the collection cell
extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView{
            return selectedTopic.count
        }else if collectionView ==  resultsCollectionView{
            if section == 0 {
                return arrProductList.count
            }else{
                return 1
            }
        }else if collectionView == supplierListCollectionView{
            return filterSupplierList.count
        }else if collectionView ==  priceCollectionView{
            return filterproductListArray.count
        }else if collectionView ==  brandCollectionView{
            return filterBrandList.count
        }else{
            return 0
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView ==  resultsCollectionView{
            return arrProductList.count < responseCountProductList ? 2 : (arrProductList.count > 0 ? 1 :0)
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            cell.layer.cornerRadius         = 20
            cell.filteredLabel.text = selectedTopic[indexPath.item]
            return cell
        }else if collectionView ==  resultsCollectionView{
            if indexPath.section == 0{
                
                let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "SupplierCollectionViewCell", for: indexPath) as? SupplierCollectionViewCell
                if self.arrProductList.count == 0{
                    return UICollectionViewCell()
                }
                
                cell?.productName.text = self.arrProductList[indexPath.row].productName
                cell?.supplierNameLabel.text = "\(self.arrProductList[indexPath.row].supplierInfo.companyName )"
                
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
                    cell?.reviewView.rating = Double(self.arrProductList[indexPath.row].supplierInfo.ratings)
                }
                cell?.reviewView.isUserInteractionEnabled = false
                cell?.quantityLabel.text = "\(self.arrProductList[indexPath.row].pricingRange[0].displaySkuName)"
                
                if let id = self.arrProductList[indexPath.row].pricingRange[0].pricemoq {
                    cell?.addedQuantityLabel.text = "\(id.intValue ?? 0)"
                }
                
                if self.arrProductList[indexPath.row].wishListStatus == true{
                    cell?.heartButton.setImage(UIImage(named: "Icon feather-heart (1)"), for: .normal)
                } else {
                    cell?.heartButton.setImage(UIImage(named: "Icon feather-heart"), for: .normal)
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
                
                let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionViewCell", for: indexPath) as? LoadingCollectionViewCell
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
        }else  if collectionView == supplierListCollectionView{
            if filterSupplierList.count == 0 {
                return UICollectionViewCell()
            }
            let cell = supplierListCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            cell.filteredLabel.text = filterSupplierList[indexPath.item].companyName
            
            cell.bgView.borderWidth         = 1
            cell.layer.cornerRadius         = 10
            cell.filteredLabel.font         = UIFont.systemFont(ofSize: 14.0)
            if arrTempSupplierID.contains(self.filterSupplierList[indexPath.row].id){
                cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
            }else{
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
            }
            cell.filteredLabel.textColor = .black
            return cell
        }else if collectionView ==  priceCollectionView{
            if filterproductListArray.count == 0 {
                return UICollectionViewCell()
            }
            let cell = priceCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            cell.filteredLabel.text = filterproductListArray[indexPath.row].filterName
            
            cell.bgView.borderWidth         = 1
            cell.layer.cornerRadius         = 10
            cell.filteredLabel.font         = UIFont.systemFont(ofSize: 14.0)
            if arrTempPrinceID.contains(filterproductListArray[indexPath.row].id){
                if selectedIndexPath == indexPath{
                    cell.bgView.backgroundColor = hexStringToUIColor(hex: "#FFF5FA")
                    cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
                }else{
                    cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                    cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
                }
            }else{
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
            }
            cell.filteredLabel.textColor = .black
            return cell
        }else if  collectionView ==  brandCollectionView{
            if filterBrandList.count == 0 {
                return UICollectionViewCell()
            }
            let cell = brandCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            
            cell.filteredLabel.text = filterBrandList[indexPath.row].name
            
            cell.bgView.borderWidth         = 1
            cell.layer.cornerRadius         = 10
            cell.filteredLabel.font         = UIFont.systemFont(ofSize: 14.0)
            
            if arrTempBrandID.contains(filterBrandList[indexPath.row].name){
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#FFF5FA")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
            }else{
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
            }
            cell.filteredLabel.textColor = .black
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        
    }
    @objc func heartClicked(sender:UIButton) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            dashboardVC.modalPresentationStyle = .fullScreen
        }else{
            selectedProductIndexPath = sender.tag
            if self.arrProductList[sender.tag].wishListStatus == true{
                removeProductFromWishlist(productCode: arrProductList[sender.tag].productCode)
                showCustomAlert(message: "Product has been successfully deleted from your wishlist")
            } else {
                
                addProductToWishlist(userTypeId: arrProductList[sender.tag].userTypeID, productCode: arrProductList[sender.tag].productCode)
                showCustomAlert(message: "Product wishlist has been added successfully")
            }
        }
    }
    // This method is used for invoking the add wishlist API
    func addProductToWishlist(userTypeId:String,productCode:String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "supplier_id=\(userTypeId)&product_code=\(productCode)"
        APICall().post(apiUrl: Constants.WebServiceURLs.AddWishlistURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.arrProductList[self.selectedProductIndexPath].wishListStatus = true
                            let indexPath = IndexPath(item:self.selectedProductIndexPath, section: 0)
                            self.resultsCollectionView.reloadItems(at: [indexPath])
                            self.showCustomAlert(message: dicResponseData.message )
                        }
                        
                    } catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    // This method is used for remove the product from wishlist
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
                            self.resultsCollectionView.reloadItems(at: [indexPath])
                            self.showCustomAlert(message: dicResponseData.message)
                        }
                    } catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    @objc func btnAddClicked(sender:UIButton) {
        let cell: SupplierCollectionViewCell? = (self.resultsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? SupplierCollectionViewCell)
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
            wsAddToCart(product_id: self.arrProductList[sender.tag].id, pricing_range_id: self.arrProductList[sender.tag].pricingRange[0].id, quantity: cell?.addedQuantityLabel.text?.integerValue() ?? 1)
        }
        
    }
    
    func getCartCount() {
        self.arrProductList.removeAll()
        self.wsProductListURL(page: 1, search: self.strSearch, sort_method: "asc", sort_by: "product_name", CategotyId: self.arrTempSupplierID, SubCategoryId: self.arrTempPrinceID,  showloading: true, platform: "mobile",app_type: "b2c", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
    }
    
    @objc
    func btnPlusClicked(sender:UIButton) {
        let cell: SupplierCollectionViewCell? = (self.resultsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? SupplierCollectionViewCell)
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
        
        let cell: SupplierCollectionViewCell? = (self.resultsCollectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as? SupplierCollectionViewCell)
        
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
            
            self.tappedRowCount = String(tag)
            //Based on the selected row, getting the values below
            if self.arrProductList[tag].pricingRange[0].cartID?.rawValue != nil{
                self.cartID = self.arrProductList[tag].pricingRange[0].cartID?.rawValue ?? ""
            }
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
            let text = selectedTopic[indexPath.item]
            if text.count <= 4{
                return CGSize(width: 90, height: 40.0)
            }else{
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                return CGSize(width: cellWidth, height: 40.0)
            }
        }else if collectionView == self.resultsCollectionView{
            if indexPath.section == 0{
                return CGSize(width: self.resultsCollectionView.frame.width/2 , height: 286)
            }else{
                return CGSize(width: self.resultsCollectionView.frame.width , height: 60)
            }
        } else if collectionView == supplierListCollectionView{
            let text =  filterSupplierList[indexPath.item].companyName
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
            return CGSize(width: cellWidth, height: 40.0)
        }else if collectionView == priceCollectionView{
            let text =  self.filterproductListArray[indexPath.row].filterName
            if text.count <= 4{
                return CGSize(width: 90, height: 40.0)
            }else{
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                return CGSize(width: cellWidth, height: 40.0)
            }
            
        }else if collectionView ==  brandCollectionView{
            let text =  self.filterBrandList[indexPath.row].name
            
            if text.count <= 4{
                return CGSize(width: 90, height: 40.0)
            }else{
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                return CGSize(width: cellWidth, height: 40.0)
            }
            
        }else{
            return CGSize(width: 0 ,height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.resultsCollectionView{
            if arrProductList.count == 0 {
                return
            }
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
            vc.prdId                    = self.arrProductList[indexPath.row].id
            vc.outletID                 = outletID
            vc.defaultImageurl = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrProductList[indexPath.row].productImage )")
            self.navigationController?.pushViewController(vc, animated: true)
        }else  if collectionView == supplierListCollectionView{
            if filterSupplierList.count == 0 {
                return
            }
            let cell = supplierListCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            
            if !arrTempSupplierID.contains(self.filterSupplierList[indexPath.row].id){
                if selectedIndexPath != indexPath {
                    cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
                    cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
                    arrTempSupplierID.add(self.filterSupplierList[indexPath.row].id)
                    selectedTopic.append(self.filterSupplierList[indexPath.row].companyName)
                    selectedIndexPath = indexPath
                } else {
                    selectedIndexPath = nil
                    cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                    cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
                    arrTempSupplierID.remove(self.filterSupplierList[indexPath.row].id)
                    selectedTopic.remove(self.filterSupplierList[indexPath.row].companyName)
                }
                
            } else  {
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
                arrTempSupplierID.remove(self.filterSupplierList[indexPath.row].id)
                selectedTopic.remove(self.filterSupplierList[indexPath.row].companyName)
            }
            self.supplierListCollectionView.reloadData()
            
        }  else  if collectionView == priceCollectionView{
            let cell = priceCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            
            if !arrTempPrinceID.contains(self.filterproductListArray[indexPath.row].id) {
                self.arrTempPrinceID.removeAllObjects()
                self.selectedTopic.removeAll()
                arrTempPrinceID.add(self.filterproductListArray[indexPath.row].id)
                if selectedIndexPath != indexPath {
                    cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
                    cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
                    //     arrTempPrinceID.add(self.filterproductListArray[indexPath.row].id)
                    selectedTopic.append(self.filterproductListArray[indexPath.row].filterName)
                    selectedIndexPath = indexPath
                }else{
                    selectedIndexPath = nil
                    cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                    cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
                    arrTempPrinceID.remove(self.filterproductListArray[indexPath.row].id)
                    selectedTopic.remove(self.filterproductListArray[indexPath.row].filterName)
                }
                
            } else  {
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
                arrTempPrinceID.remove(self.filterproductListArray[indexPath.row].id)
                selectedTopic.remove(self.filterproductListArray[indexPath.row].filterName)
            }
            if selectedIndexPath != nil {
                self.filtersAppliesLabel.text = "1 Filter Applied"
            }else {
                self.filtersAppliesLabel.text = "No Filters Applied"
            }
            self.priceCollectionView.reloadData()
        }else if collectionView == brandCollectionView {
            let cell = brandCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            
            if !arrTempBrandID.contains(self.filterBrandList[indexPath.row].name) {
                cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
                arrTempBrandID.add(self.filterBrandList[indexPath.row].name)
                selectedTopic.append(self.filterBrandList[indexPath.row].name)
                
            } else  {
                cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
                cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
                arrTempBrandID.remove(self.filterBrandList[indexPath.row].name)
                selectedTopic.remove(self.filterBrandList[indexPath.row].name)
            }
            self.brandCollectionView.reloadData()
        }
        filtersAppliesLabel.text  = "Sort & Filter"
    }
}
extension SearchViewController{
    // This method is used for product list API
    func wsProductListURL(page: Int,search: String,sort_method: String, sort_by: String, CategotyId: NSMutableArray, SubCategoryId: NSMutableArray,showloading:Bool,platform: String, app_type: String , fcm_token_ios: String){
        ImgCart.isHidden = true
        lblWeAreSorry.isHidden = true
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.resultsCollectionView.isUserInteractionEnabled = true
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
            print(arrTempPrinceID)
            priceID.append(i as! String)
            print("priceeee\(priceID.joined(separator: ","))")
            priceIDArray = priceID.joined(separator: ",")
        }
        var params :[String: Any]?
        if showloading{
            showLoader()
        }
        params = ["start":0,"end":0,"page":page,"sort_method":"asc","keyword":search,"sort_by":"product_name","outlet_id":outletID,"category_id":categoryId,"subcategory_id":"","supplier_id":self.supplierID,"brand": brandIDArray,"status":1,"price": priceIDArray,"platform":"mobile","app_type":"b2c", "fcm_token_ios": "\(USERDEFAULTS.getDataForKey(.fcmToken))"]
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
                                    if self.isBottomRefreshMySupplierList == true {
                                        self.resultsCollectionView.refreshControl?.hideWithAnimation(hidden: true)
                                        self.arrProductList.append(contentsOf: dicResponseData.data.products)
                                    } else  {
                                        self.arrProductList = dicResponseData.data.products
                                    }
                                    self.isBottomRefreshMySupplierList = false
                                    if self.arrProductList.count > 0{
                                        self.responseCountProductList = dicResponseData.data.totalCount
                                        self.resultsCollectionView.isHidden = false
                                        self.ImgCart.isHidden = true
                                        self.lblWeAreSorry.isHidden = true
                                    } else {
                                        self.resultsCollectionView.isHidden = true
                                        self.ImgCart.isHidden = false
                                        self.lblWeAreSorry.isHidden = false
                                    }
                                    self.showFilter(bool: true)
                                    if self.filterlistLoaded{
                                        self.priceFilter()
                                        self.filterlistLoaded = false
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    
                                    if self.arrProductList.count == 0 {
                                        self.arrProductList = [Product]()
                                        self.resultsCollectionView.isHidden = true
                                        self.ImgCart.isHidden = false
                                        self.lblWeAreSorry.isHidden = false
                                        self.nodataView.isHidden = true
                                    }
                                    self.isBottomRefreshMySupplierList = false
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.resultsCollectionView.delegate = self
                                self.resultsCollectionView.dataSource = self
                                self.resultsCollectionView.reloadData()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.resultsCollectionView.isUserInteractionEnabled = true
                                }
                                
                            }
                        } catch let error as NSError {
                            print("Session Error: ",error)
                            DispatchQueue.main.async {
                                self.ImgCart.isHidden = false
                                self.lblWeAreSorry.isHidden = false
                                self.resultsCollectionView.isHidden = true
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
    
   //This method is used invoke the add to cart
    func wsAddToCart(product_id : String,pricing_range_id: String,quantity: Int){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
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
                        self.bgView.isHidden = false
                        self.ProductToadd.isHidden = false
                        self.cartID = dicResponseData.data.cartID
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
    // This method is used for update the products
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
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    // This method is used to delete the products
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
                        print("Session Error: ",err)
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
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    // This method is used for the filter supplier
    func supplierFilter(search: String, buyerID: String,page:Int){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            hideLoader()
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let params = "start=0&end=0&page=\(page)&sort_method=asc&keyword=\(search)&sort_by=company_name&buyer_id=\(buyerID)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.FilterSupplier, requestPARAMS: params, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(SupplierFilterModel.self, from: responseData as! Data)
                        self.filterSupplierList = dicResponseData.data
                        print(dicResponseData)
                        DispatchQueue.main.async {
                            self.supplierListCollectionView.delegate = self
                            self.supplierListCollectionView.dataSource = self
                            self.supplierListCollectionView.reloadData()
                            self.supplierListCollectionView.layoutIfNeeded()
                            self.supplierHeight = self.supplierListCollectionView.contentSize.height
                            self.suppierCollectionViewHeight.constant = self.supplierListCollectionView.contentSize.height
                        }
                        hideLoader()
                        //                        self.priceFilter()
                    }catch let err {
                        hideLoader()
                        print("Session Error: ",err)
                    }
                }
                else{
                    hideLoader()
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    
    func priceFilter(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            hideLoader()
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        showLoader()
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.FilterPricing
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + APICall().getTokenValue(), forHTTPHeaderField: "Authorization")
        }
        do{
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
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
                                    self.filterproductListArray = dicResponseData.data
                                    DispatchQueue.main.async {
                                        self.priceCollectionView.delegate = self
                                        self.priceCollectionView.dataSource = self
                                        self.priceCollectionView.reloadData()
                                        self.priceCollectionView.layoutIfNeeded()
                                        self.priceheight = self.priceCollectionView.contentSize.height
                                        self.priceSubCOllectionViewheight.constant = self.priceCollectionView.contentSize.height
                                        self.brandFilter()
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
    func brandFilter(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            hideLoader()
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.BrandList
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + APICall().getTokenValue(), forHTTPHeaderField: "Authorization")
        }
        
        do{
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                
                hideLoader()
                
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
                                let dicResponseData = try decoder.decode(FilterBrandModel.self, from: data )
                                
                                if dicResponseData.success == "1" {
                                    self.filterBrandList = dicResponseData.data
                                    DispatchQueue.main.async {
                                        self.brandCollectionView.delegate = self
                                        self.brandCollectionView.dataSource = self
                                        self.brandCollectionView.reloadData()
                                        self.brandCollectionView.layoutIfNeeded()
                                        
                                        self.brandDropDown.isSelected = true
                                        self.brandDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
                                        self.brandheight = self.brandCollectionView.contentSize.height
                                        
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
    
}
