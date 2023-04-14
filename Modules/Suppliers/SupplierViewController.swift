//
//  SupplierViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 16/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class SupplierViewController: UIViewController {
    
    @IBOutlet weak var WishlistDelete: UIView!
    @IBOutlet weak var WishlistAdded: UIView!
    @IBOutlet weak var backButton           : UIButton!
    @IBOutlet weak var suppliersTableView   : UITableView!
    @IBOutlet weak var searchTextField      : UITextField!
    @IBOutlet weak var nodataAvailable      : UILabel!
    @IBOutlet weak var filterCollectionView : UICollectionView!
    @IBOutlet weak var filterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgView               : UIView!
    @IBOutlet weak var filterDropDown       : UIButton!
    @IBOutlet weak var filterView           : UIView!
    @IBOutlet weak var CartImg: UIImageView!
    @IBOutlet weak var filtersSlectedLabel  : UILabel!
    @IBOutlet weak var lblAddSome: UILabel!
    @IBOutlet weak var lblNoSupplier: UILabel!
    
    var pageMySupplierList                   = 1
    var isBottomRefreshMySupplierList        = false
    var arrSupplierID: [String]              = []
    var arrSupplierList                      = [SupplierListResponse]()
    var responseCountMySupplierList          = 0
    var searchedText                         =  ""
    var filterHeight:CGFloat               = 0
    var placeholder  = "Search"
    var filterArray = ["Rating - (High to Low)","Rating - (Low to High)","Alphabetical (A to Z)", "Alphabetical (Z to A)"]
    var selectedIndexPath                   :IndexPath?
    var clearAllOrShowButtonTapped                = false
    var isLoading  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        WishlistDelete.isHidden = true
        WishlistAdded.isHidden = true
        UIElementsSetUp()
        registerXibs()
        apiCall()
        self.searchTextField.placeholder  = "Search"
    }
    override func viewDidAppear(_ animated: Bool) {
        self.filterCollectionView.layoutIfNeeded()
        self.filterHeight = self.filterCollectionView.contentSize.height
        self.filterHeightConstraint.constant = self.filterCollectionView.contentSize.height
    }
    func apiCall(){
        self.CartImg.isHidden     = true
        self.lblAddSome.isHidden     = true
        self.lblNoSupplier.isHidden     = true
        self.nodataAvailable.isHidden     = true
        self.wsSuppliersListURL(OutletId:outletID , search: searchedText, fav_suppliers: "false", my_suppliers: "false", sort_method: "asc", sort_by: "company_name",app_type: "b2c", platform: "mobile", showloading: false, fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
    }
    
    func UIElementsSetUp(){
        self.bgView.isHidden              = true
        self.filterView.isHidden          = true
        self.CartImg.isHidden     = true
        self.lblAddSome.isHidden     = true
        self.lblNoSupplier.isHidden     = true
        self.nodataAvailable.isHidden     = true
        self.searchTextField.placeholder  = AppStaticTextManager.searchPlaceholder.rawValue
        self.searchTextField.setLeftPaddingPoints(34)
        self.searchTextField.delegate     = self
        self.searchTextField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.filterCollectionView.dataSource = self
        self.filterCollectionView.delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        pageMySupplierList              = 1
        if searchTextField.text?.count ?? 0 == 0{
            searchedText                    = ""
            pageMySupplierList              = 1
            responseCountMySupplierList     = 1
            arrSupplierList.removeAll()
            arrSupplierID.removeAll()
            isBottomRefreshMySupplierList   = false
            apiCall()
        }
    }
    func registerXibs(){
        suppliersTableView.register(UINib.init(nibName: "SuppliersTableViewCell", bundle: nil), forCellReuseIdentifier: "SuppliersTableViewCell")
        filterCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
    }
    @IBAction func backbuttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButton(_ sender: Any) {
        self.filterCollectionView.reloadData()
        self.searchTextField.resignFirstResponder()
        self.filterView.isHidden = false
        self.bgView.isHidden     = false
        
    }
    @IBAction func filterClose(_ sender: Any) {
        self.bgView.isHidden = true
        self.filterView.isHidden = true
        if clearAllOrShowButtonTapped == false{
            selectedIndexPath              = nil
            self.filtersSlectedLabel.text = "No Filters Applied"
            filterCollectionView.reloadData()
        }
    }
    @IBAction func clearAllButton(_ sender: Any) {
        clearAllOrShowButtonTapped = true
        self.filtersSlectedLabel.text = "No Filters Applied"
        selectedIndexPath              = nil
        self.bgView.isHidden           = false
        self.filterView.isHidden       = false
        filterCollectionView.reloadData()
        searchedText                    = ""
        pageMySupplierList              = 1
        responseCountMySupplierList     = 1
        arrSupplierList.removeAll()
        arrSupplierID.removeAll()
        isBottomRefreshMySupplierList   = false
        apiCall()
    }
    @IBAction func showButtonAction(_ sender: Any) {
        clearAllOrShowButtonTapped = true
        if let row = selectedIndexPath?.row{
            bgView.isHidden = true
            filterView.isHidden = true
            slectedFilter(indexPath:row)
        }else{
            self.showCustomAlert(message: "Select filter", isSuccessResponse: false)
        }
        
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
}


// MARK: -table view delegate functions
//This method is used for create the table cell
extension SupplierViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSupplierList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuppliersTableViewCell", for: indexPath)as? SuppliersTableViewCell
        
        if self.arrSupplierList[indexPath.row].isOffline == true{
            cell?.supplierofflineStatus.text = "Type : Offline"
        } else {
            cell?.supplierofflineStatus.text =  "Type : Online"
        }
        cell?.supplierName.text = self.arrSupplierList[indexPath.row].companyName
        cell?.registrationLabel.text = self.arrSupplierList[indexPath.row].companyRegistrationNo
        cell?.gmailLabel.text = self.arrSupplierList[indexPath.row].email
        cell?.phoneNumberLabel.text = self.arrSupplierList[indexPath.row].phoneNumber
        cell?.addressLabel.text = self.arrSupplierList[indexPath.row].city
        
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrSupplierList[indexPath.row].profile)")
        cell?.supplierImageview.kf.indicatorType = .activity
        cell?.supplierImageview.kf.setImage(
            with: url,
            placeholder: UIImage(named: "HomePlaceHolder"),
            options: nil)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.arrSupplierList.count > 0{
            
            let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
            objItemDetailVC.supplierID = self.arrSupplierList[indexPath.row].id
            objItemDetailVC.strImage = self.arrSupplierList[indexPath.row].profile
            objItemDetailVC.strTitle = self.arrSupplierList[indexPath.row].companyName
            objItemDetailVC.ratings = self.arrSupplierList[indexPath.row].ratings
            objItemDetailVC.strAddress = "\(self.arrSupplierList[indexPath.row].address), \(self.arrSupplierList[indexPath.row].city), \(self.arrSupplierList[indexPath.row].country)"
            self.navigationController?.pushViewController(objItemDetailVC, animated: true)
        }
    }
    
}
//This method is used for create the collection cell
extension SupplierViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        cell.layer.cornerRadius         = 20
        cell.filteredLabel.text = filterArray[indexPath.item]
        if selectedIndexPath == indexPath{
            cell.bgView.borderWidth = 1
            cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
            cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
        }else{
            cell.bgView.borderWidth = 1
            cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
            cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = filterArray[indexPath.item]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 30.0
        return CGSize( width:cellWidth , height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        
        if selectedIndexPath != indexPath {
            cell.bgView.borderWidth = 1
            cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
            cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
            selectedIndexPath = indexPath
        } else  {
            selectedIndexPath = nil
            cell.bgView.borderWidth = 1
            cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
            cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
            
        }
        if selectedIndexPath != nil {
            self.filtersSlectedLabel.text = "1 Filter Applied"
        }else{
            self.filtersSlectedLabel.text = "No Filters Applied"
        }
        self.filterCollectionView.reloadData()
    }
    func slectedFilter(indexPath: Int){
        searchedText                    = ""
        pageMySupplierList              = 1
        responseCountMySupplierList     = 1
        arrSupplierList.removeAll()
        arrSupplierID.removeAll()
        isBottomRefreshMySupplierList   = false
        
        if indexPath == 0 {
            //           Rating - (High to Low)
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "false", my_suppliers: "false", sort_method: "desc", sort_by: "ratings", app_type: "b2c", platform: "mobile", showloading: false, fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 1{
            //            "Rating - (Low to High)"
            
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "false", my_suppliers: "false", sort_method: "asc", sort_by: "ratings", app_type: "b2c", platform: "mobile", showloading: false, fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 2{
            // "Alphabetical (A to Z)"
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "false", my_suppliers: "false", sort_method: "asc", sort_by: "company_name", app_type: "b2c", platform: "mobile", showloading: false, fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 3{
            //          "Alphabetical (z to S)"
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "false", my_suppliers: "false", sort_method: "desc", sort_by: "company_name", app_type: "b2c", platform: "mobile", showloading: false, fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
        
    }
}
extension SupplierViewController {
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.count ?? 0 >= 1{
            searchedText = searchTextField.text ?? ""
            apiCall()
        }
        return true
    }
}
//This method is used for load more data
extension SupplierViewController {
    func loadMoreFromBottom(){
        if responseCountMySupplierList > self.arrSupplierList.count{
            pageMySupplierList = pageMySupplierList + 1
            self.suppliersTableView.refreshControl?.showWithAnimation(onView: self.suppliersTableView, animation: .bottom)
            self.wsSuppliersListURL(OutletId:outletID , search: searchedText, fav_suppliers: "false", my_suppliers: "false", sort_method: "asc", sort_by: "company_name",app_type: "b2c", platform: "mobile", showloading: false, fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
    }
    //This method is used for scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UITableView {
            let offsetY = scrollView.contentOffset.y
            if offsetY > 10{
                let contentHeight = scrollView.contentSize.height
                if (offsetY > contentHeight - scrollView.frame.height * 4) && !isBottomRefreshMySupplierList  {
                    if responseCountMySupplierList > self.arrSupplierList.count {
                        isBottomRefreshMySupplierList = true
                        loadMoreFromBottom()
                    }
                }
            }
        }
    }
    //This method is used for invoking the supplier list
    func wsSuppliersListURL(OutletId: String,search: String,fav_suppliers: String,my_suppliers:String,sort_method: String, sort_by: String, app_type: String, platform: String, showloading:Bool,fcm_token_ios: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramStr = ""
        if showloading{
            showLoader()
        }
        paramStr = "start=0&end=0&page=\(pageMySupplierList)&sort_method=\(sort_method)&keyword=\(search)&sort_by=\(sort_by)&outlet_id=\(OutletId)&my_suppliers=\(my_suppliers)&fav_suppliers=\(fav_suppliers)&app_type=b2c&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.suppliersListURL, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    if showloading{
                        hideLoader()
                    }
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(SupplierListResponseModel.self, from: responseData as! Data)
                        //sucess= true = 1, unsuccess = fale =0
                        if dicResponseData.success == "1" , let supplierData = dicResponseData.data {
                            self.isLoading = true
                            let supplierListFiltered = supplierData.suppliers.filter { suppliers in
                                if self.arrSupplierID.contains(suppliers.id) {
                                    return false
                                }
                                self.arrSupplierID.append(suppliers.id)
                                return true
                                
                            }
                            if self.isBottomRefreshMySupplierList == true {
                                self.suppliersTableView.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrSupplierList.append(contentsOf: supplierListFiltered)
                            } else  {
                                self.arrSupplierList = supplierListFiltered
                            }
                            self.isBottomRefreshMySupplierList = false
                            if self.arrSupplierList.count > 0 {
                                self.responseCountMySupplierList = supplierData.totalCount
                                self.suppliersTableView.isHidden = false
                                self.CartImg.isHidden     = true
                                self.lblAddSome.isHidden     = true
                                self.lblNoSupplier.isHidden     = true
                                self.nodataAvailable.isHidden = true
                            } else {
                                self.suppliersTableView.isHidden = true
                                self.CartImg.isHidden     = false
                                self.lblAddSome.isHidden     = false
                                self.lblNoSupplier.isHidden     = false
                                
                                self.nodataAvailable.isHidden = false
                            }
                        } else {
                            self.suppliersTableView.isHidden = true
                            self.CartImg.isHidden     = false
                            self.lblAddSome.isHidden     = false
                            self.lblNoSupplier.isHidden     = false
                            self.nodataAvailable.isHidden = false
                        }
                        DispatchQueue.main.async {
                            self.suppliersTableView.delegate = self
                            self.suppliersTableView.dataSource = self
                            self.suppliersTableView.reloadData()
                        }
                    } catch let err {
                        print("Session Error: ",err)
                        self.CartImg.isHidden     = false
                        self.lblAddSome.isHidden     = false
                        self.lblNoSupplier.isHidden     = false
                        self.nodataAvailable.isHidden = false
                        self.suppliersTableView.isHidden = true
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
}
