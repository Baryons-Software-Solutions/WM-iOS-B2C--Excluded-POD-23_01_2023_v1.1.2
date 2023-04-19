//
//  DashBoardViewController.swift
//  Created by chittiraju on 20/06/22.
//  Updated by Avinash on 11/03/23.
//

import UIKit
import Foundation
import MBCircularProgressBar

var outletID = ""
var mycartCount = 0
var selectedIndexPathAddress  = IndexPath(row: 0, section: 0)
class DashBoardViewController: UIViewController{
    @IBOutlet var backgroudView: UIView!
    @IBOutlet weak var welcomeToName                    : UILabel!
    @IBOutlet weak var searchTextField                  : UITextField!
    @IBOutlet weak var categoryCollectionView           : UICollectionView!
    @IBOutlet weak var dashBoardScrollView              : UIScrollView!
    @IBOutlet weak var suppliersLabel                   : UILabel!
    @IBOutlet weak var suppliersAllButton               : UIButton!
    @IBOutlet weak var favCollectionView          : UICollectionView!
    @IBOutlet weak var suppliersHeightConstraint        : NSLayoutConstraint!
    @IBOutlet weak var topViewAll: UIButton!
    @IBOutlet weak var supplierNearByLabel              : UILabel!
    @IBOutlet weak var supplierNearByViewAll            : UIButton!
    @IBOutlet weak var suppliersNearByListCollecionView : UICollectionView!
    @IBOutlet weak var txtLocation                      : UITextField!
    @IBOutlet weak var locationTapView                  : UIView!
    @IBOutlet weak var logoButton                       : UIButton!
    @IBOutlet weak var btnNotification                  : UIButton!
    @IBOutlet weak var dropDownButton                   : UIButton!
    @IBOutlet weak var topProdcutsLabel                 : UILabel!
    @IBOutlet weak var topProductsCollectionView        : UICollectionView!
    @IBOutlet weak var noDataView                       : UIView!
    @IBOutlet weak var ProductsCollectionView: UICollectionView!
    @IBOutlet weak var ProductHieght: NSLayoutConstraint!
    @IBOutlet weak var favStackView                     : UIStackView!
    @IBOutlet weak var suppliersNearByStackView         : UIStackView!
    @IBOutlet weak var topProductHeightConstriant       : NSLayoutConstraint!
    @IBOutlet weak var favCollectionheight              : NSLayoutConstraint!
    @IBOutlet weak var supplierNearByConstraint         : NSLayoutConstraint!
    @IBOutlet weak var addresspopUpView                 : UIView!
    @IBOutlet weak var popUpBgView                      : UIView!
    @IBOutlet weak var addressTableView                 : UITableView!
    @IBOutlet weak var addressTableViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var delievryStackView: UIStackView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var topProductsStackView: UIStackView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var gmailAddressPopUP: UIView!
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var GenralManger: UILabel!
    @IBOutlet weak var CompleteProfile: UIButton!
    @IBOutlet weak var ProfileCloseBtn: UIButton!
    @IBOutlet weak var PercentageTextField: UITextField!
    @IBOutlet weak var ImageTickMark: UIImageView!
    
    var pickerLocation           = UIPickerView()
    //uncomment when dahsboard up
    //    var arrOutletList            = [GetoutletLocation]()
    var arrDetailWarehouse = [WarehouseListResponse]()
    var arrOutletList             = [OutletListResponse]()
    var categoryList              = [GetCategoryList]()
    var arrSupplierList           = [GetMyfavouriteList]()
    var arrfavList                = [GetMyfavouriteList]()
    var topProductsArrList        = [GetMyfavouriteList]()
    //   var ProductsArrList           = [GetMyfavouriteList]()//GetTopProductList()
    var ProductsArrList           = [List]()
    var selectedCategoryIndex         : IndexPath?
    var categoryBackGroundColor         = ["#EBF5D4","#C6F2E8","#FFEFCD","#FFD8D8"]
    var offerBySuppliersBackGroundColor = ["#FFEE7B", "#CBEBAF"]
    var categoryButtonTapped            = false
    var ProductsMaxCellheight    : Int = 150
    var topProductsMaxCellheight : Int = 150
    var favMaxCellheight         : Int = 160
    var supplierMaxCellheight    : Int = 160
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topProductsStackView.isHidden = true
        if USERDEFAULTS.getDataForKey(.isLogin) as? String == "false" {
            favStackView.isHidden = true
            favCollectionView.isHidden = true
            suppliersLabel.isHidden = true
            suppliersAllButton.isHidden = true
            locationTapView.isHidden = true
            delievryStackView.isHidden = true
            mapBtn.isHidden = true
            gmailAddressPopUP.isHidden = true
            dropDownButton.isHidden = true
            popUpBgView.isHidden = true
            self.tabBarController?.tabBar.items![2].badgeValue = "0"
            uIInitialization()
            registerCollectionViewXibs()
            delegatesSetup()
            self.searchTextField.setLeftPaddingPoints(34)
            self.dashBoardScrollView.isHidden = true
            searchTextField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        }else{
            self.tabBarController?.tabBar.items![2].badgeValue = "0"
            btnContinue.cornerRadius = 10
            gmailAddressPopUP.cornerRadius = 10
            gmailAddressPopUP.isHidden = true
            uIInitialization()
            registerCollectionViewXibs()
            delegatesSetup()
            self.searchTextField.setLeftPaddingPoints(34)
            self.dashBoardScrollView.isHidden = true
            ProfileView.cornerRadius = 20
            searchTextField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
            CompleteProfile.cornerRadius = 10
            self.ImageTickMark.isHidden = true
            self.ProfileName.text = " \(USERDEFAULTS.getDataForKey(.user_first_name)) \(USERDEFAULTS.getDataForKey(.user_last_name))"
            print(self.PercentageTextField.text)
            self.PercentageTextField.text = "80" + "%"
            var weightage = 80
            print(weightage)
            if USERDEFAULTS.getDataForKey(.userPic) as! String != "" {
                weightage = weightage + 20
                print(weightage)
                USERDEFAULTS.setDataForKey(weightage, .weightage)
            }
            if (USERDEFAULTS.getDataForKey(.weightage)) as? Int ?? 1 >= 100{
                self.popUpBgView.isHidden = true
                self.ProfileView.isHidden = true
                self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
                self.tabBarController?.tabBar.alpha = 1
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
            }else{
                self.popUpBgView.isHidden = false
                self.ProfileView.isHidden = false
                self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
                self.tabBarController?.tabBar.alpha = 0.6
                self.tabBarController?.tabBar.isUserInteractionEnabled = false
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        searchTextField.resignFirstResponder()
        wsOutlet()
        categoryButtonTapped = false
    }
    
    @objc func donePickerCategory() {
        if txtLocation.text != "" {
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "false", my_suppliers: "true", sort_method:"asc", sort_by:"company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))" )
        }
        self.txtLocation.resignFirstResponder()
    }
    @objc func bgViewTapped(_ sender: UITapGestureRecognizer) {
        
    }
    @objc func showAddressView(_ sender: UITapGestureRecognizer) {
        self.addresspopUpView.isHidden = false
        self.popUpBgView.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
        self.tabBarController?.tabBar.alpha = 0.6
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
    }
    
    @objc func myTargetFunction() {
        print("It works!")
        let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchText = self.searchTextField.text ?? ""
        searchVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    func uIInitialization(){
        
        let bgviewTap = UITapGestureRecognizer(target: self, action: #selector(self.bgViewTapped(_:)))
        popUpBgView.isUserInteractionEnabled = true
        popUpBgView.addGestureRecognizer(bgviewTap)
        
        let locationviewTap = UITapGestureRecognizer(target: self, action: #selector(self.showAddressView(_:)))
        locationTapView.isUserInteractionEnabled = true
        locationTapView.addGestureRecognizer(locationviewTap)
        self.addresspopUpView.isHidden = true
        self.noDataView.isHidden            = true
        self.searchTextField.placeholder    = "What are you looking for?"
        self.welcomeToName.text =
        " \(USERDEFAULTS.getDataForKey(.user_first_name)) \(USERDEFAULTS.getDataForKey(.user_last_name))"
        supplierNearByLabel.text            = " Browse Suppliers"
        suppliersLabel.text                 = " My Favorites"
        topProdcutsLabel.text               = "Top Suppliers"
        addressTableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
    }
    
    func registerCollectionViewXibs(){
        categoryCollectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        favCollectionView.register(UINib.init(nibName: "SuppliersNearbyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuppliersNearbyCollectionViewCell")
        suppliersNearByListCollecionView.register(UINib.init(nibName: "SuppliersNearbyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuppliersNearbyCollectionViewCell")
        topProductsCollectionView.register(UINib.init(nibName: "ShopAgainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShopAgainCollectionViewCell")
        //Top products
        ProductsCollectionView.register(UINib.init(nibName: "TopProdutsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopProdutsCollectionViewCell")
    }
    
    func delegatesSetup(){
        searchTextField.delegate = self

    }
    
    @IBAction func suppliersNearViewAllAction(_ sender: Any) {
        globalCreateOrderAddress = 1
        let vc = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierViewController") as! SupplierViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ProfileCancelBtn(_ sender: Any) {
        self.popUpBgView.isHidden = true
        self.ProfileView.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    @IBAction func backNavigation(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func notificationNavigation(_ sender: Any) {
        let notificationVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    @IBAction func completeProfileButton(_ sender: Any) {
        if let MyProfileVC =
            mainStoryboard.instantiateViewController(withIdentifier: "MyProfileVC") as? MyProfileVC {
            MyProfileVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(MyProfileVC, animated: true)
        }
    }
    @IBAction func topProductsViewALL(_ sender: Any) {
        globalCreateOrderAddress = 1
        let vc = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierViewController") as! SupplierViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnContinue(_ sender: Any) {
        if let objAddWarehouseVC = mainStoryboard.instantiateViewController(withIdentifier: "AddOutletWarehouseVC") as? AddOutletWarehouseVC {
            objAddWarehouseVC.arrDetail = [self.arrOutletList[(sender as AnyObject).tag]]
            objAddWarehouseVC.titleName  = "Edit Address"
            objAddWarehouseVC.txtCountry?.placeholder = "United Arab Emirates"
            objAddWarehouseVC.countryName = self.topProductsArrList[(sender as AnyObject).tag].country
            self.navigationController?.pushViewController(objAddWarehouseVC, animated: true)
        }
    }
    
    
    @IBAction func suppliersViewAll(_ sender: Any) {
        if let FavouritesVC = mainStoryboard.instantiateViewController(withIdentifier: "FavouritesViewController") as?  FavouritesViewController{
            FavouritesVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(FavouritesVC, animated: true)
        }
    }
    
    @IBAction func dropDownAction(_ sender: Any) {
        txtLocation.becomeFirstResponder()
    }
}
// This method is used for pick the outlet list
extension DashBoardViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrOutletList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
 "\(self.arrOutletList[row].area ?? "")"
        return "\(self.arrOutletList[row].outletName) \(self.arrOutletList[row].area)"
  }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtLocation.text = "\(self.arrOutletList[row].outletName ?? "") (\(self.arrOutletList[row].area ?? ""))"
        txtLocation.selectedID = arrOutletList[row].id
        outletID = arrOutletList[row].id
    }
    
    func pickerViewSet(_ pickerViewName:UIPickerView, _ textField:UITextField, btnDoneSelector:Selector) {
        textField.inputView = pickerViewName
        pickerViewName.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let doneBtnAction = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDoneSelector)
        toolBar.setItems([doneBtnAction], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
}

// MARK: - API

extension DashBoardViewController {
    
    // This method is used for invoke the new home API
    func wsSuppliersListURL(OutletId: String,search: String,fav_suppliers: String,my_suppliers:String,sort_method: String, sort_by: String, app_type: String, platform: String, fcm_token_ios: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        var paramStr = ""
        paramStr = "start=0&end=10&page=1&sort_method=asc&keyword=&sort_by=company_name&outlet_id=\(OutletId)&my_suppliers=true&fav_suppliers=false&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.newHomeUrl, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(HomeScreenDataModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.categoryList = dicResponseData.getAllCategoryList
                            self.arrSupplierList = dicResponseData.suppliersGetList
                            self.arrfavList = dicResponseData.getMyfavouriteList
                            mycartCount = dicResponseData.mycartCount
                            self.topProductsArrList = dicResponseData.getTopsuppliersList
                            //   self.ProductsArrList = dicResponseData.getTopsuppliersList
                            self.ProductsArrList = dicResponseData.getTopProductList.topProLists
                            if mycartCount == 0{
                                self.tabBarController?.tabBar.items![2].badgeValue = nil
                            }else{
                                self.tabBarController?.tabBar.items![2].badgeValue = "\(mycartCount)"
                            }
                            DispatchQueue.main.async {
                                self.topConstraintsheightCalculation()
                                self.topConstraintsheightCalculation1()
                                self.favheightCalculation()
                                self.supplierheightCalculation()
                            }
                            [self.categoryCollectionView,  self.suppliersNearByListCollecionView, self.favCollectionView,self.topProductsCollectionView,self.ProductsCollectionView].forEach({ (collectionView) in
                                collectionView?.delegate = self
                                collectionView?.dataSource = self
                            })
                            
                            
                            DispatchQueue.main.async {
                                self.dashBoardScrollView.isHidden = false
                                self.suppliersNearByListCollecionView.collectionViewLayout.invalidateLayout()
                                self.favCollectionView.collectionViewLayout.invalidateLayout()
                                self.topProductsCollectionView.collectionViewLayout.invalidateLayout()
                                self.ProductsCollectionView.collectionViewLayout.invalidateLayout()
                                self.categoryCollectionView.reloadData()
                                self.suppliersNearByListCollecionView.reloadData()
                                self.topProductsCollectionView.reloadData()
                                self.ProductsCollectionView.reloadData()
                                self.favCollectionView.reloadData()
                                
                                if self.arrfavList.count == 0 {
                                    self.favStackView.isHidden =  true
                                }else{
                                    self.favStackView.isHidden =  false
                                }
                                
                            }
                        }
                    } catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    // This method is used for invoke the outletlist API
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
                            self.noDataView.isHidden = true
                            self.arrOutletList = dicResponseData.data!
                            self.txtLocation.text = "\(self.arrOutletList[selectedIndexPathAddress.row].outletName) (\(self.arrOutletList[selectedIndexPathAddress.row].area))"
                            self.txtLocation.selectedID = self.arrOutletList[selectedIndexPathAddress.row].id
                            outletID = self.arrOutletList[selectedIndexPathAddress.row].id
                            self.addressTableView.delegate = self
                            self.addressTableView.dataSource = self
                            self.addressTableView.reloadData()
                            //     self.outletCount = self.arrOutletList[selectedIndexPathAddress.row].
                            
                            if self.arrOutletList[selectedIndexPathAddress.row].address == "" {
                                self.popUpBgView.isHidden = false
                                self.gmailAddressPopUP.isHidden = false
                                self.tabBarController?.tabBar.backgroundColor = .white
                                self.tabBarController?.tabBar.alpha = 0.6
                                self.tabBarController?.tabBar.isUserInteractionEnabled = false
                            }else{
                                //   self.tabBarController?.tabBar.isHidden = false
                                self.gmailAddressPopUP.isHidden = true
                                self.popUpBgView.isHidden = true
                                self.tabBarController?.tabBar.backgroundColor = .white
                                self.tabBarController?.tabBar.alpha = 1
                                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                            }
                            
                            
                            if self.arrOutletList.count >= 10 {
                                self.addressTableViewHeightConstraint.constant = 500
                            }else{
                                self.addressTableViewHeightConstraint.constant = CGFloat(self.arrOutletList.count * 50)
                            }
                            
                            
                            self.wsSuppliersListURL(OutletId: self.arrOutletList[0].id, search: "", fav_suppliers: "false", my_suppliers: "true", sort_method:"asc", sort_by:"company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
                        } else {
                            if dicResponseData.success == "0"{
                                if USERDEFAULTS.getDataForKey(.isLogin) as? String == "false" {
                                    //   self.arrOutletList = dicResponseData.data?
                                    self.wsSuppliersListURL(OutletId: "", search: "", fav_suppliers: "false", my_suppliers: "true", sort_method:"asc", sort_by:"company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
                                }
                            }
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
//This method is used for create the collection cell
extension DashBoardViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return categoryList.count
        }else if collectionView == suppliersNearByListCollecionView{
            if arrSupplierList.count >= 6 {
                return 6
            }else{
                return arrSupplierList.count
            }
        }else if collectionView == favCollectionView{
            if arrfavList.count >= 6 {
                return 6
            }else{
                return arrfavList.count
            }
        }else if collectionView == topProductsCollectionView {
            
            if topProductsArrList.count >= 4{
                return 4
            }else{
                return topProductsArrList.count
            }
        }else if collectionView == ProductsCollectionView{
            
            if ProductsArrList.count >= 4{
                return 4
            }else{
                return ProductsArrList.count
            }
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell
            let currentColor = categoryBackGroundColor.indexes(of: categoryBackGroundColor[indexPath.row % 4])
            cell?.backGrundView.backgroundColor = hexStringToUIColor(hex: categoryBackGroundColor[currentColor[0]])
            cell?.categoryname.text       = self.categoryList[indexPath.row].categoryName
            if selectedCategoryIndex == indexPath {
                cell?.categoryname.isHighlighted = true
            }else{
                cell?.categoryname.isHighlighted = false
                
            }
            return cell ?? UICollectionViewCell()
        }else if collectionView == suppliersNearByListCollecionView {
            let cell = suppliersNearByListCollecionView.dequeueReusableCell(withReuseIdentifier: "SuppliersNearbyCollectionViewCell", for: indexPath) as? SuppliersNearbyCollectionViewCell
            
            cell?.productname.text  = self.arrSupplierList[indexPath.row].companyName
            let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.arrSupplierList[indexPath.row].profile)")
            cell?.productImage.kf.indicatorType = .activity
            cell?.productImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "HomePlaceHolder"),
                options: nil)
            
            return cell ?? UICollectionViewCell()
        }else if collectionView == self.favCollectionView{
            let cell = favCollectionView.dequeueReusableCell(withReuseIdentifier: "SuppliersNearbyCollectionViewCell", for: indexPath) as? SuppliersNearbyCollectionViewCell
            
            cell?.productname.text  = self.arrfavList[indexPath.row].companyName
            let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.arrfavList[indexPath.row].profile )")
            cell?.productImage.kf.indicatorType = .activity
            cell?.productImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "HomePlaceHolder"),
                options: nil)
            
            return cell ?? UICollectionViewCell()
        }else if collectionView == self.topProductsCollectionView{
            let cell = topProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "ShopAgainCollectionViewCell", for: indexPath) as? ShopAgainCollectionViewCell
            cell?.productNameLabel.text  = self.topProductsArrList[indexPath.row].companyName
            let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.topProductsArrList[indexPath.row].profile )")
            cell?.produtImageview.kf.indicatorType = .activity
            cell?.produtImageview.kf.setImage(
                with: url,
                placeholder: UIImage(named: "HomePlaceHolder"),
                options: nil)
            
            return cell ?? UICollectionViewCell()
        }else if collectionView == self.ProductsCollectionView{
            var selected = ""
            let cell = ProductsCollectionView.dequeueReusableCell(withReuseIdentifier: "TopProdutsCollectionViewCell", for: indexPath) as? TopProdutsCollectionViewCell
            cell?.productNamelabel.text = self.ProductsArrList[indexPath.row].productName
            cell?.lblProductImgName.text = self.ProductsArrList[indexPath.row].productImage
            //     cell?.lblPricemoq.text = "AED \(self.ProductsArrList[indexPath.row].pricingRange[0].listPrice)"
            let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.ProductsArrList[indexPath.row].productImage )")
            cell?.productImage.kf.indicatorType = .activity
            cell?.productImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "HomePlaceHolder"),
                options: nil)
            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == suppliersNearByListCollecionView{
            let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
            objItemDetailVC.supplierID = self.arrSupplierList[indexPath.row].id
            objItemDetailVC.strImage = self.arrSupplierList[indexPath.row].profile
            objItemDetailVC.strTitle = self.arrSupplierList[indexPath.row].companyName
            //   objItemDetailVC.ratings = Double(self.arrSupplierList[indexPath.row].ratings ?? 0)
            objItemDetailVC.strAddress = "\(self.arrSupplierList[indexPath.row].address), \(self.arrSupplierList[indexPath.row].city), \(self.arrSupplierList[indexPath.row].country)"
            self.navigationController?.pushViewController(objItemDetailVC, animated: true)
        }else if collectionView == topProductsCollectionView{
            let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
            objItemDetailVC.supplierID = self.topProductsArrList[indexPath.row].id
            objItemDetailVC.strImage = self.topProductsArrList[indexPath.row].profile
            objItemDetailVC.strTitle = self.topProductsArrList[indexPath.row].companyName
            //    objItemDetailVC.ratings = Double(self.topProductsArrList[indexPath.row].ratings ?? 0)
            objItemDetailVC.strAddress = "\(self.topProductsArrList[indexPath.row].address), \(self.topProductsArrList[indexPath.row].city), \(self.topProductsArrList[indexPath.row].country)"
            self.navigationController?.pushViewController(objItemDetailVC, animated: true)
        }else if collectionView == ProductsCollectionView{
            let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
            objItemDetailVC.supplierID = self.ProductsArrList[indexPath.row].id
            objItemDetailVC.strImage = self.ProductsArrList[indexPath.row].productImage
            objItemDetailVC.strTitle = self.ProductsArrList[indexPath.row].productName
            self.navigationController?.pushViewController(objItemDetailVC, animated: true)
        }else if collectionView == categoryCollectionView{
            selectedCategoryIndex = indexPath
            let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
            searchVC?.categoryId = self.categoryList[indexPath.row].categoryID
            searchVC?.didSlectTapped = true
            searchVC?.hidesBottomBarWhenPushed = true
            searchVC?.placeHolderText = self.categoryList[indexPath.row].categoryName
            self.navigationController?.pushViewController(searchVC!, animated: true)
        }
        else if collectionView == favCollectionView{
            let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
            objItemDetailVC.supplierID = self.arrfavList[indexPath.row].id
            objItemDetailVC.strImage = self.arrfavList[indexPath.row].profile
            objItemDetailVC.strTitle = self.arrfavList[indexPath.row].companyName
            objItemDetailVC.strAddress = "\(self.arrfavList[indexPath.row].address), \(self.arrfavList[indexPath.row].city), \(self.arrfavList[indexPath.row].country)"
            self.navigationController?.pushViewController(objItemDetailVC, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView{
            let text =  categoryList[indexPath.item].categoryName
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
            return CGSize(width: cellWidth, height: 40.0)
        }else if collectionView == suppliersNearByListCollecionView{
            return CGSize(width: Int(self.suppliersNearByListCollecionView.frame.width)/3 , height: supplierMaxCellheight)
        }else if collectionView == favCollectionView{
            return CGSize(width: Int(self.favCollectionView.frame.width)/3 , height: favMaxCellheight)
        }else if collectionView == topProductsCollectionView{
            return CGSize(width: Int(self.topProductsCollectionView.frame.width)/2 , height: topProductsMaxCellheight)
        }else if collectionView == ProductsCollectionView{
            return CGSize(width: Int(self.ProductsCollectionView.frame.width)/2 , height: ProductsMaxCellheight)
        }else {
            return CGSize(width: 200 ,height: 200)
        }
    }
    // This method is used for top products height calculation.
    func topConstraintsheightCalculation(){
        var maxHeight = 0
        if topProductsArrList.count >= 4{
            for i in 0...3{
                let text =  topProductsArrList[i].companyName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.topProductsCollectionView.frame.width/2)")
                print(Int(cellWidth)/Int(self.topProductsCollectionView.frame.width/2))
                if maxHeight <= Int(cellWidth)/Int(self.topProductsCollectionView.frame.width/2){
                    maxHeight = Int(cellWidth)/Int(self.topProductsCollectionView.frame.width/2)
                }else{
                    print("not maximum")
                }
            }
            print(maxHeight * 30)
            topProductsMaxCellheight = 150 + (maxHeight * 20)
            self.topProductHeightConstriant.constant = CGFloat(300 + (2 * (maxHeight * 20)))
        }else{
            for i in 0..<topProductsArrList.count{
                let text =  topProductsArrList[i].companyName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.topProductsCollectionView.frame.width/2)")
                print(Int(cellWidth)/Int(self.topProductsCollectionView.frame.width/2))
                if maxHeight <= Int(cellWidth)/Int(self.topProductsCollectionView.frame.width/2){
                    maxHeight = Int(cellWidth)/Int(self.topProductsCollectionView.frame.width/2)
                }else{
                    print("not maximum")
                }
            }
            
            print(maxHeight * 30)
            topProductsMaxCellheight = 150 + (maxHeight * 20)
            if topProductsArrList.count <= 2{
                self.topProductHeightConstriant.constant = CGFloat(150 + (maxHeight * 20))
            }else{
                self.topProductHeightConstriant.constant = CGFloat(300 + (2 * (maxHeight * 20)))
            }
        }
    }
    func topConstraintsheightCalculation1(){
        var maxHeight = 0
        if ProductsArrList.count >= 4{
            for i in 0...3{
                let text =  ProductsArrList[i].productName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.ProductsCollectionView.frame.width/2)")
                print(Int(cellWidth)/Int(self.ProductsCollectionView.frame.width/2))
                if maxHeight <= Int(cellWidth)/Int(self.ProductsCollectionView.frame.width/2){
                    maxHeight = Int(cellWidth)/Int(self.ProductsCollectionView.frame.width/2)
                }else{
                    print("not maximum")
                }
            }
            print(maxHeight * 30)
            ProductsMaxCellheight = 150 + (maxHeight * 20)
            self.ProductHieght.constant = CGFloat(300 + (2 * (maxHeight * 20)))
        }else{
            for i in 0..<ProductsArrList.count{
                let text =  ProductsArrList[i].productName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.ProductsCollectionView.frame.width/2)")
                print(Int(cellWidth)/Int(self.ProductsCollectionView.frame.width/2))
                if maxHeight <= Int(cellWidth)/Int(self.ProductsCollectionView.frame.width/2){
                    maxHeight = Int(cellWidth)/Int(self.ProductsCollectionView.frame.width/2)
                }else{
                    print("not maximum")
                }
            }
            
            print(maxHeight * 30)
            ProductsMaxCellheight = 150 + (maxHeight * 20)
            if ProductsArrList.count <= 2{
                self.ProductHieght.constant = CGFloat(150 + (maxHeight * 20))
            }else{
                self.ProductHieght.constant = CGFloat(300 + (2 * (maxHeight * 20)))
            }
        }
    }
    // This method is used for supplier height calculation
    func supplierheightCalculation(){
        var maxHeight = 0
        if arrSupplierList.count >= 6{
            for i in 0...6{
                let text =  arrSupplierList[i].companyName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.suppliersNearByListCollecionView.frame.width/3 )")
                print(Int(cellWidth)/Int(self.suppliersNearByListCollecionView.frame.width/3 ))
                if maxHeight <= Int(cellWidth)/Int(self.suppliersNearByListCollecionView.frame.width/3 ){
                    maxHeight = Int(cellWidth)/Int(self.suppliersNearByListCollecionView.frame.width/3 )
                }else{
                    print("not maximum")
                }
            }
            print(maxHeight * 30)
            supplierMaxCellheight = 160 + (maxHeight * 20)
            self.supplierNearByConstraint.constant = CGFloat(160 + (maxHeight * 20))
        }else{
            for i in 0..<arrSupplierList.count{
                let text =  arrSupplierList[i].companyName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.suppliersNearByListCollecionView.frame.width/3 )")
                print(Int(cellWidth)/Int(self.suppliersNearByListCollecionView.frame.width/3 ))
                if maxHeight <= Int(cellWidth)/Int(self.suppliersNearByListCollecionView.frame.width/3 ){
                    maxHeight = Int(cellWidth)/Int(self.suppliersNearByListCollecionView.frame.width/3 )
                }else{
                    print("not maximum")
                }
            }
            
            print(maxHeight * 30)
            supplierMaxCellheight = 160 + (maxHeight * 20)
            self.supplierNearByConstraint.constant = CGFloat(160 + (maxHeight * 20))
            
        }
    }
    // This method is used for fav products height calculation
    func favheightCalculation(){
        var maxHeight = 0
        if arrfavList.count >= 6{
            for i in 0..<arrfavList.count{
                let text =  arrfavList[i].companyName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.favCollectionView.frame.width/3 )")
                print(Int(cellWidth)/Int(self.favCollectionView.frame.width/3 ))
                if maxHeight <= Int(cellWidth)/Int(self.favCollectionView.frame.width/3 ){
                    maxHeight = Int(cellWidth)/Int(self.favCollectionView.frame.width/3 )
                }else{
                    print("not maximum")
                }
            }
            print(maxHeight * 30)
            favMaxCellheight = 160 + (maxHeight * 20)
            self.favCollectionheight.constant = CGFloat(160 + (maxHeight * 20))
        }else{
            for i in 0..<arrfavList.count{
                let text =  arrfavList[i].companyName
                let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
                print("each cell width\(cellWidth)")
                print("current Cell Width\(self.favCollectionView.frame.width/3 )")
                print(Int(cellWidth)/Int(self.favCollectionView.frame.width/3 ))
                if maxHeight <= Int(cellWidth)/Int(self.favCollectionView.frame.width/3 ){
                    maxHeight = Int(cellWidth)/Int(self.favCollectionView.frame.width/3 )
                }else{
                    print("not maximum")
                }
            }
            print(maxHeight * 30)
            favMaxCellheight = 160 + (maxHeight * 20)
            self.favCollectionheight.constant = CGFloat(160 + (maxHeight * 20))
        }
    }
}
extension DashBoardViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTextField {
            
        }
    }
}
//This method is used for create the table cell
extension DashBoardViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOutletList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as? AddressTableViewCell
        cell?.addressLabel.text = "\(self.arrOutletList[indexPath.row].outletName) (\(self.arrOutletList[indexPath.row].area))"
        cell?.selectButton.isUserInteractionEnabled = false
        if selectedIndexPathAddress == indexPath{
            cell?.selectButton.setImage(UIImage(named: "PinkRadio"), for: .normal)
        }else{
            cell?.selectButton.setImage(UIImage(named: "WhiteRadio"), for: .normal)
        }
        return cell ?? UITableViewCell()
    }
    
    
    @objc func addressSelected(sender:UIButton) {
        selectedIndexPathAddress = IndexPath(row: sender.tag, section: 0)
        txtLocation.selectedID = arrOutletList[sender.tag].id
        outletID = arrOutletList[sender.tag].id
        addressTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPathAddress = indexPath
        txtLocation.selectedID = arrOutletList[indexPath.row].id
        self.txtLocation.text = "\(self.arrOutletList[indexPath.row].outletName) (\(self.arrOutletList[indexPath.row].area))"
        outletID = arrOutletList[indexPath.row].id
        self.popUpBgView.isHidden = true
        self.addresspopUpView.isHidden = true
        addressTableView.reloadData()
        self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
// This method is used for padding purpose
extension UITextField{
    
    //MARK: Left padding
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
