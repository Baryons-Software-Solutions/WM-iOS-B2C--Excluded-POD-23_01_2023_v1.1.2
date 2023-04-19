//
//  FavouritesViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by apple on 18/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var vwSuccess: UIView!
    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var btnAddFav: UIButton!
    @IBOutlet weak var lblAddYour: UILabel!
    @IBOutlet weak var Nofav: UILabel!
    @IBOutlet weak var imgfav: UIImageView!
    @IBOutlet weak var BtnDelete: UIButton!
    @IBOutlet weak var BtnCancel: UIButton!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var suppliersTableView: UITableView!
    @IBOutlet weak var nodataAvailable: UILabel!
    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var filterCollectionView : UICollectionView!
    @IBOutlet weak var filterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterDropDown       : UIButton!
    @IBOutlet weak var filterView           : UIView!
    @IBOutlet weak var filtersSlectedLabel  : UILabel!
    @IBOutlet weak var btnNotification: UIButton!
    
    var pageMyFavList                   = 1
    var locationId                      = ""
    var isBottomRefreshMySupplierList   = false
    var arrSupplierID: [String]         = []
    var arrSupplierList                 = [SupplierListResponse]()
    var responseCountMyFavList          = 0
    var searchedText                    =  ""
    var pageMySupplierList              = 1
    var arrPaymentResponse              = [Payment]()
    var responseCountMySupplierList     = 0
    var arrOrderResponse                = [Order]()
    var arrDraftOrderResponse           = [DraftOrder]()
    var isBottomRefreshDraftOrder       = false
    var responseCountDraftOrder         = 0
    var arrSuppliers : [[String:Any]]   = []
    var arrOutletList : [[String:Any]]  = []
    var arrStatusDropdown               = [StatusDropdown]()
    var isBottomRefresh                 = false
    var responseCount                   = 0
    var selectedIndexPath               = IndexPath(row: 0, section: 0)
    var supplierId                      = ""
    var outletId                        = ""
    var statusId                        = "0"
    var filterHeight:CGFloat            = 0
    var filterArray = ["Rating - (High to Low)","Rating - (Low to High)","Alphabetical (A to Z)", "Alphabetical (Z to A)"]
    var selectedFilterIndexPath         :IndexPath?
    var clearAllOrShowButtonTapped      = false
    var deletedIndex                    : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwSuccess.cornerRadius = 8
        BtnDelete.cornerRadius = 8
        BtnCancel.cornerRadius = 8
        btnAddFav.cornerRadius = 8
        delegatesSetup()
        UIElementsSetUp()
        vwSuccess.isHidden       = true
        imgfav.isHidden          = true
        Nofav.isHidden           = true
        lblAddYour.isHidden      = true
        btnAddFav.isHidden       = true
        vwDelete.isHidden         = true
        self.tabBarController?.tabBar.isHidden = true
        registerXibs()
        apiCall()
    }
    
    func apiCall(){
        self.nodataAvailable.isHidden     = true
        self.SearchView.isHidden = false
        self.pageMySupplierList  = 1
        arrSupplierList.removeAll()
        arrSupplierID.removeAll()
        self.wsSuppliersListURL(OutletId:outletID , search: searchedText, fav_suppliers: "true", my_suppliers: "false", sort_method: "asc", sort_by: "company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))" )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.filterCollectionView.layoutIfNeeded()
        self.filterHeight = self.filterCollectionView.contentSize.height
        self.filterHeightConstraint.constant = self.filterCollectionView.contentSize.height
        self.suppliersTableView.reloadData()
    }
    func registerXibs(){
        suppliersTableView.register(FavouritesTblCell.nib(), forCellReuseIdentifier: FavouritesTblCell.identifier)
        filterCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
    }
    func UIElementsSetUp(){
        self.filterBGView.backgroundColor = .black
        self.filterView.isHidden          = true
        self.filterBGView.isHidden        = true
        self.filterBGView.alpha           = 0.6
        self.nodataAvailable.isHidden     = true
        self.SearchView.isHidden = false
        imgfav.isHidden                   = true
        Nofav.isHidden                    = true
        lblAddYour.isHidden               = true
        btnAddFav.isHidden                = true
        self.searchTextField.delegate     = self
        self.searchTextField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
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
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.count ?? 0 >= 1{
            searchedText = searchTextField.text ?? ""
            apiCall()
        }
        return true
    }
    func delegatesSetup(){
        self.filterCollectionView.dataSource = self
        self.filterCollectionView.delegate = self
    }
    //This function is used for order buyes list
    func wsBuyerOrders(status: String,supplierId: String,OutletId: String,search: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            return
        }
        self.arrStatusDropdown.removeAll()
        let postString = "start=0&end=0&page=\(pageMySupplierList)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&supplier_id=\(supplierId)&from_date=&to_date=&status=\(status)"
        APICall().post(apiUrl: Constants.WebServiceURLs.OrderBuyerListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(PlacedOrderResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            if self.isBottomRefreshDraftOrder == true {
                                self.suppliersTableView.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrOrderResponse.append(contentsOf: [data][0].orders)
                            } else  {
                                self.arrOrderResponse = [data][0].orders
                            }
                            self.isBottomRefreshDraftOrder = false
                            if self.arrOrderResponse.count > 0{
                                self.responseCountDraftOrder = [data][0].totalCount
                                self.suppliersTableView.isHidden = false
                                self.suppliersTableView.delegate = self
                                self.suppliersTableView.dataSource = self
                                self.suppliersTableView.reloadData()
                            } else {
                                self.suppliersTableView.isHidden = true
                                self.SearchView.isHidden = false
                                self.nodataAvailable.isHidden = true
                                self.imgfav.isHidden = true
                                self.Nofav.isHidden = true
                                self.lblAddYour.isHidden = true
                                self.btnAddFav.isHidden = true
                            }
                            for i in self.arrOrderResponse{
                                self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                self.arrSuppliers.append(["Title": i.supplierInfo.supplierName?.rawValue ?? ""  , "id" : i.supplierID ])
                                self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                            }
                            var set = Set<String>()
                            self.arrSuppliers =  self.arrSuppliers.compactMap {
                                guard let name = $0["Title"] as? String else { return nil }
                                return set.insert(name).inserted ? $0 : nil
                            }
                            var setOutlet = Set<String>()
                            self.arrOutletList =  self.arrOutletList.compactMap {
                                guard let name = $0["Title"] as? String else { return nil }
                                return setOutlet.insert(name).inserted ? $0 : nil
                            }
                            self.arrStatusDropdown = [data][0].statusDropdown
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
    
    @IBAction func Btnclear(_ sender: Any) {
        vwDelete.isHidden         = true
        filterBGView.isHidden     = true
    }
    @IBAction func BtnDelete(_ sender: Any) {
        vwDelete.isHidden         = true
        filterBGView.isHidden = true
        self.wsRemoveFavSupplier(supplierID: arrSupplierList[deletedIndex ?? 0].id )
    }
    @IBAction func btnAddFav(_ sender: Any) {
        let SearchViewController = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierViewController") as! SupplierViewController
        SearchViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    @IBAction func btnNotification(_ sender: Any) {
        let notificationVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnFilterAct(_ sender: Any) {
        DispatchQueue.main.async {
            self.filterCollectionView.reloadData()
        }
        self.searchTextField.resignFirstResponder()
        self.filterView.isHidden       = false
        self.filterBGView.isHidden     = false
        
    }
    @IBAction func showResultAction(_ sender: Any) {
        clearAllOrShowButtonTapped = true
        if let row = selectedFilterIndexPath?.row{
            filterView.isHidden = true
            filterBGView.isHidden = true
            slectedFilter(indexPath:row)
        }else{
            showToast(message: "Select filter")
        }
    }
    
    @IBAction func filterClose(_ sender: Any) {
        self.filterBGView.isHidden = true
        self.filterView.isHidden = true
        if clearAllOrShowButtonTapped == false{
            selectedFilterIndexPath              = nil
            self.filtersSlectedLabel.text = "Sort & Filter"
            DispatchQueue.main.async {
                self.filterCollectionView.reloadData()
            }
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
    
    @IBAction func clearAllButton(_ sender: Any) {
        clearAllOrShowButtonTapped = true
        self.filtersSlectedLabel.text = "Sort & Filter"
        selectedFilterIndexPath              = nil
        self.filterBGView.isHidden           = false
        self.filterView.isHidden             = false
        DispatchQueue.main.async {
            self.filterCollectionView.reloadData()
        }
        searchedText                    = ""
        pageMySupplierList              = 1
        responseCountMySupplierList     = 1
        arrSupplierList.removeAll()
        arrSupplierID.removeAll()
        isBottomRefreshMySupplierList   = false
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
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "true", my_suppliers: "false", sort_method: "desc", sort_by: "ratings",app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 1{
            //            "Rating - (Low to High)"
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "true", my_suppliers: "false", sort_method: "asc", sort_by: "ratings", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 2{
            // "Alphabetical (A to Z)"
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "true", my_suppliers: "false", sort_method: "asc", sort_by: "company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }else if indexPath == 3{
            //          "Alphabetical (z to S)"
            self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "true", my_suppliers: "false", sort_method: "desc", sort_by: "company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
        }
    }
}
extension FavouritesViewController {
    //This method is used for marketplace supplier API
    func wsSuppliersListURL(OutletId: String,search: String,fav_suppliers: String,my_suppliers:String,sort_method: String, sort_by: String, app_type: String, platform: String, fcm_token_ios: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            return
        }
        var paramStr = ""
        paramStr = "start=0&end=0&page=\(pageMySupplierList)&sort_method=\(sort_method)&keyword=\(search)&sort_by=\(sort_by)&outlet_id=\(OutletId)&my_suppliers=\(my_suppliers)&fav_suppliers=\(fav_suppliers)&app_type=b2c&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.suppliersListURL, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(SupplierListResponseModel.self, from: responseData as! Data)
                        // success = true = 1, unsucess = false = 0
                        if dicResponseData.success == "1" , let supplierData = dicResponseData.data {
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
                                self.nodataAvailable.isHidden = true
                                self.SearchView.isHidden = false
                            } else {
                                self.suppliersTableView.isHidden = true
                                self.SearchView.isHidden = true
                                self.nodataAvailable.isHidden = false
                                self.imgfav.isHidden  = false
                                self.Nofav.isHidden  = false
                                self.lblAddYour.isHidden  = false
                                self.btnAddFav.isHidden  = false
                            }
                        } else {
                            self.suppliersTableView.isHidden = true
                            self.SearchView.isHidden = true
                            self.nodataAvailable.isHidden = false
                            self.imgfav.isHidden  = false
                            self.Nofav.isHidden  = false
                            self.lblAddYour.isHidden  = false
                            self.btnAddFav.isHidden  = false
                        }
                        DispatchQueue.main.async {
                            self.suppliersTableView.delegate = self
                            self.suppliersTableView.dataSource = self
                            self.suppliersTableView.reloadData()
                        }
                    } catch let err {
                        print("Session Error: ",err)
                        self.SearchView.isHidden = true
                        self.nodataAvailable.isHidden = false
                        self.imgfav.isHidden  = false
                        self.Nofav.isHidden  = false
                        self.lblAddYour.isHidden  = false
                        self.btnAddFav.isHidden  = false
                        self.suppliersTableView.isHidden = true
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    func wsSuppliersListURL() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            return
        }
        let paramStr = "start=0&end=0&page=\(pageMyFavList)&sort_method=\("asc")&keyword=&sort_by=company_name&outlet_id=\(outletID)&my_suppliers=\(false)&fav_suppliers=\(true)&app_type=b2c&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        APICall().post(apiUrl: Constants.WebServiceURLs.suppliersListURL, requestPARAMS: paramStr, isTimeOut: false) {
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    do {
                        let dicResponseData = try JSONDecoder().decode(SupplierListResponseModel.self, from: responseData as! Data)
                        guard let data = dicResponseData.data?.suppliers else {
                            return
                        }
                        self.arrSupplierList = data
                        self.responseCountMyFavList = dicResponseData.data?.totalCount ?? 0
                        print(data)
                        DispatchQueue.main.async {
                            self.suppliersTableView.reloadData()
                        }
                    } catch let error {
                        print("Session Error:\(error)")
                    }
                } else {
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
    //  This method is used for remove the favorite ssupplier
    func wsRemoveFavSupplier(supplierID: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            return
        }
        
        let postString = "user_type=1&user_id=\(USERDEFAULTS.getDataForKey(.user_type_id))&fav_id=\(supplierID)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.addToFavouriteSupplierURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ChangeStatusResponseModel.self, from: responseData as! Data)
                        self.apiCall()
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
}
// This methos is used for to create the collection view cell
extension FavouritesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        cell.layer.cornerRadius         = 20
        cell.filteredLabel.text = filterArray[indexPath.item]
        if selectedFilterIndexPath == indexPath{
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
        return CGSize(width: cellWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        if selectedFilterIndexPath != indexPath {
            cell.bgView.borderWidth = 1
            cell.bgView.backgroundColor =  hexStringToUIColor(hex: "#FFF5FA")
            cell.bgView.borderColor     = hexStringToUIColor(hex: "#EC187B")
            selectedFilterIndexPath = indexPath
        } else  {
            selectedFilterIndexPath = nil
            cell.bgView.borderWidth = 1
            cell.bgView.backgroundColor = hexStringToUIColor(hex: "#EDF5FF")
            cell.bgView.borderColor     = hexStringToUIColor(hex: "#EDF5FF")
        }
        DispatchQueue.main.async {
            self.filterCollectionView.reloadData()
        }
        
    }
    
}
// This methos is used for to create the table view cell
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSupplierList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTblCell.identifier, for: indexPath) as! FavouritesTblCell
        let reusableData = arrSupplierList[indexPath.row]
        cell.supplierName.text = reusableData.companyName
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(reusableData.profile)")
        cell.supplierImageview.kf.indicatorType = .activity
        cell.supplierImageview.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_placeholder"),
            options: nil)
        cell.registrationNumber.text = "Registration No: \(reusableData.companyRegistrationNo)"
        cell.typeOfOutlet.text = reusableData.isOffline ? "Type: Offline" : "Type: Online"
        cell.phoneNumber.text = reusableData.city
        cell.supplierEmail.text = reusableData.email
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self , action:#selector(heartClicked(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.arrSupplierList.count > 0 {
            let objItemDetailVC = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierDetailsViewController") as! SupplierDetailsViewController
            objItemDetailVC.supplierID = self.arrSupplierList[indexPath.row].id
            objItemDetailVC.strImage = self.arrSupplierList[indexPath.row].profile
            objItemDetailVC.strTitle = self.arrSupplierList[indexPath.row].companyName
            objItemDetailVC.ratings = self.arrSupplierList[indexPath.row].ratings
            objItemDetailVC.strAddress = "\(self.arrSupplierList[indexPath.row].address), \(self.arrSupplierList[indexPath.row].city), \(self.arrSupplierList[indexPath.row].country)"
            self.navigationController?.pushViewController(objItemDetailVC, animated: true)
        }
    }
    
    @objc func heartClicked(sender:UIButton) {
        deletedIndex  = sender.tag
        self.vwDelete.isHidden         = false
        self.filterBGView.isHidden = false
    }
    func loadMoreFromBottom(){
        if responseCountMySupplierList > self.arrSupplierList.count{
            pageMySupplierList = pageMySupplierList + 1
            self.suppliersTableView.refreshControl?.showWithAnimation(onView: self.suppliersTableView, animation: .bottom)
            apiCall()
        }
    }
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
}
