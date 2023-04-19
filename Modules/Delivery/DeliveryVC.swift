//
//  DeliveryVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 16/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import SideMenu

class DeliveryVC: UIViewController {
    
    @IBOutlet weak var btnAddproduct: UIButton!
    @IBOutlet weak var lblAddSome: UILabel!
    @IBOutlet weak var lblNodelievry: UILabel!
    @IBOutlet weak var imgDelievry: UIImageView!
    @IBOutlet weak var btnBackOut: UIButton!
    @IBOutlet weak var btnHomeOut: UIButton!
    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var filterview: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDeliveries: UITableView!
    @IBOutlet weak var txtStatusFilter: UITextField!
    @IBOutlet weak var txtOutletFIlter: UITextField!
    @IBOutlet weak var txtSupplierFilter: UITextField!
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var vwFilter: UIView!
    @IBOutlet weak var BtnClearAll: UIButton!
    @IBOutlet weak var btnApplyFilterOut: UIButton!
    @IBOutlet weak var btnClearFilterOut: UIButton!
    //Avinash added code for Filters
    @IBOutlet weak var filterAppliedLabel       : UILabel!
    @IBOutlet weak var supplierStackView: UIStackView!
    @IBOutlet weak var supplierLabel            : UILabel!
    @IBOutlet weak var supplierDropDown         : UIButton!
    @IBOutlet weak var supplierCollectionView: UICollectionView!
    @IBOutlet weak var supplierCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var outletStackView: UIStackView!
    @IBOutlet weak var outletNameLabel: UILabel!
    @IBOutlet weak var outletDropDown: UIButton!
    @IBOutlet weak var outletCollectionView: UICollectionView!
    @IBOutlet weak var outletCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusStackview: UIStackView!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusDropDown: UIButton!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var statusCollectionViewHeightConstriant: NSLayoutConstraint!
    
    var arrUpcomingDeliveryResponse         = [UpcomingDelivery]()
    var pickerSuppliers                     = UIPickerView()
    var pickerOutlets                       = UIPickerView()
    var pickerStatus                        = UIPickerView()
    var arrSuppliers : [[String:Any]]       = []
    var arrStatusDropdown                   = [StatusDropdown]()
    var arrOutletList : [[String:Any]]      = []
    var strSearch                           = ""
    var page                                = 1
    var fetch                               = 10
    var isBottomRefresh                     = false
    var responseCount                       = 0
    var selectedInvoiceID                   = ""
    var pickerPaymentType                   = UIPickerView()
    var titlesDic : [[String:Any]]          = []
    var arrTempID                           = NSMutableArray()
    var indexPath                           = IndexPath()
    var arrTempCount                        = NSMutableArray()
    var supplierId                          = ""
    var outletId                            = ""
    var statusId                            = "0"
    var searchedText                        = ""
    var selectedIndexPath                   = IndexPath(row: 0, section: 0)
    var arrOrderResponse                    = [Order]()
    var arrDraftOrderResponse               = [DraftOrder]()
    var responseCountDraftOrder             = 0
    var isBottomRefreshDraftOrder           = false
    var buyerPageDraftOrder                 = 1
    var supplierIndexPath                   : IndexPath?
    var outletIndexPath                     : IndexPath?
    var statusIndexPath                     : IndexPath?
    var arrPaymentResponse                  = [Payment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddproduct.cornerRadius = 8
        filterBGView.isHidden = true
        filterview.isHidden   = true
        registerXibs()
        UIElementsSetUp()
        delegatesSetup()
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        initialization()
        // Do any additional setup after loading the view.
    }
    func registerXibs(){
        supplierCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        outletCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        statusCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
    }
    func UIElementsSetUp(){
        self.filterBGView.backgroundColor = .black
        self.filterBGView.alpha           = 0.6
        self.filterAppliedLabel.text      = "No Filters Applied"
        self.imgDelievry.isHidden = true
        self.SearchView.isHidden = false
        self.lblNodelievry.isHidden = true
        self.lblAddSome.isHidden = true
        self.btnAddproduct.isHidden = true
        self.supplierDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
        self.outletDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
        self.statusDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
    }
    func delegatesSetup(){
        supplierCollectionView.delegate = self
        supplierCollectionView.dataSource = self
        outletCollectionView.delegate = self
        outletCollectionView.dataSource = self
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
    }
    //MARK: - Initialization
    
    func initialization(){
        self.navigationController?.navigationBar.isHidden = true
        titlesDic.append(["Title": "Cash"])
        titlesDic.append(["Title": "Cheque"])
        titlesDic.append(["Title": "Credit/Debit Card"])
        titlesDic.append(["Title": "Bank Transfer"])
        titlesDic.append(["Title": "Mobile Payment"])
        titlesDic.append(["Title": "Paid through Watermelon"])
        titlesDic.append(["Title": "Others"])
        self.tblDeliveries.tableFooterView = UIView()
        self.tblDeliveries.register(UINib.init(nibName: "DeliveryTblCell", bundle: nil), forCellReuseIdentifier: "DeliveryTblCell")
        
        pickerSuppliers.dataSource = self
        pickerSuppliers.delegate = self
        pickerOutlets.dataSource = self
        pickerOutlets.delegate = self
        pickerStatus.dataSource = self
        pickerStatus.delegate = self
        self.isBottomRefresh = false
        self.page = 1
        self.fetch = 10
        self.tblDeliveries.refreshControl?.hideWithAnimation(hidden: true)
        pickerPaymentType.dataSource = self
        pickerPaymentType.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.arrUpcomingDeliveryResponse.removeAll()
        wsUpcomingDelivery(status: "-1", supplierId: "", OutletId: "", search: strSearch)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if txtSearch.text?.count == 0{
            performAction()
        }
    }
    func performAction() {
        strSearch = txtSearch.text ?? ""
        self.arrUpcomingDeliveryResponse.removeAll()
        wsUpcomingDelivery(status: "-1", supplierId: "", OutletId: "", search: strSearch)
        //action events
    }
    
    @IBAction func btnAddproduct(_ sender: Any) {
        let SearchViewController = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        SearchViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(SearchViewController, animated: true)
    }
    // MARK: - PickerView Methods
    // This method is used for pickerview methods
    func pickerViewSet(_ pickerViewName:UIPickerView, _ textField:UITextField, btnDoneSelector:Selector) {
        textField.inputView = pickerViewName
        pickerViewName.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()
        let doneBtnAction = UIBarButtonItem(title: "Done", style: .plain, target: self, action: btnDoneSelector)
        toolBar.setItems([doneBtnAction], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    @objc func donePickerSupplier() {
        if txtSupplierFilter.text == "" {
            let objCommonModel = CommonModel(data : arrSuppliers[0] as NSDictionary)
            txtSupplierFilter.text = objCommonModel.strTitle
            txtSupplierFilter.selectedID = objCommonModel.strID
            
        }
        self.txtSupplierFilter.resignFirstResponder()
    }
    
    @objc func donePickerOutlets() {
        if txtOutletFIlter.text == "" {
            let objCommonModel = CommonModel(data : arrOutletList[0] as NSDictionary)
            txtOutletFIlter.text = objCommonModel.strTitle
            txtOutletFIlter.selectedID = objCommonModel.strID
            
        }
        self.txtOutletFIlter.resignFirstResponder()
    }
    @objc func donePickerStatus() {
        if txtStatusFilter.text == "" {
            txtStatusFilter.text = arrStatusDropdown[0].name
            txtStatusFilter.selectedID = arrStatusDropdown[0].status.rawValue
        }
        self.txtStatusFilter.resignFirstResponder()
    }
    // This api calls for total Upcoming delivery
    func wsUpcomingDelivery(status: String,supplierId: String,OutletId: String,search: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "start=0&end=0&page=\(page)&fetch=\(fetch)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&supplier_id=\(supplierId)&from_date=&to_date=&status=\(status)"
        APICall().post(apiUrl: Constants.WebServiceURLs.UpcomingDeliveriesURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(DeliveryResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.page = 1
                            self.fetch = 10
                            if self.isBottomRefresh == true {
                                self.tblDeliveries.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrUpcomingDeliveryResponse.append(contentsOf: dicResponseData.data.upcomingDeliveries)
                            } else  {
                                self.arrUpcomingDeliveryResponse.append(contentsOf: dicResponseData.data.upcomingDeliveries)
                            }
                            self.isBottomRefresh = false
                            if self.arrUpcomingDeliveryResponse.count > 0{
                                self.responseCount = dicResponseData.data.totalCount
                                self.tblDeliveries.isHidden = false
                                self.imgDelievry.isHidden = true
                                self.SearchView.isHidden = false
                                self.lblNodelievry.isHidden = true
                                self.lblAddSome.isHidden = true
                                self.btnAddproduct.isHidden = true
                            } else {
                                self.tblDeliveries.isHidden = true
                                self.imgDelievry.isHidden = false
                                self.SearchView.isHidden = true
                                self.lblNodelievry.isHidden = false
                                self.lblAddSome.isHidden = false
                                self.btnAddproduct.isHidden = false
                            }
                            for i in self.arrUpcomingDeliveryResponse{
                                self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                self.arrSuppliers.append(["Title": i.supplierInfo?.supplierName?.rawValue ?? ""  , "id" : i.supplierID ])
                                self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                                self.arrOutletList.append(["Title": i.outletInfo?.name ?? ""  , "id" : i.outletID ])
                            }
                            var set = Set<String>()
                            self.arrSuppliers =  self.arrSuppliers.compactMap {
                                guard let name = $0["Title"] as? String else { return nil }
                                return set.insert(name).inserted ? $0 : nil
                            }
                            self.pickerSuppliers.reloadAllComponents()
                            var setOutlet = Set<String>()
                            self.arrOutletList =  self.arrOutletList.compactMap {
                                guard let name = $0["Title"] as? String else { return nil }
                                return setOutlet.insert(name).inserted ? $0 : nil
                            }
                            self.pickerOutlets.reloadAllComponents()
                            self.arrStatusDropdown = dicResponseData.data.statusDropdown
                            self.pickerStatus.reloadAllComponents()
                        } else {
                            self.tblDeliveries.isHidden = true
                            self.imgDelievry.isHidden = false
                            self.SearchView.isHidden = true
                            self.lblNodelievry.isHidden = false
                            self.lblAddSome.isHidden = false
                            self.btnAddproduct.isHidden = false
                        }
                        DispatchQueue.main.async {
                            self.tblDeliveries.delegate = self
                            self.tblDeliveries.dataSource = self
                            self.tblDeliveries.reloadData()
                        }
                    }catch let err {
                        print("Session Error: ",err)
                        self.imgDelievry.isHidden = false
                        self.SearchView.isHidden = true
                        self.lblNodelievry.isHidden = false
                        self.lblAddSome.isHidden = false
                        self.btnAddproduct.isHidden = false
                        self.tblDeliveries.isHidden = true
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    //This method is used for invoke the outletlist API
    func wsOutlet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        self.arrOutletList.removeAll()
        let paramStr = "\(Constants.WebServiceParameter.paramBuyerId)=\(USERDEFAULTS.getDataForKey(.user_type_id))"
        APICall().post(apiUrl: Constants.WebServiceURLs.outletListURL, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(OutletListResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                            for i in dicResponseData.data!{
                                self.arrOutletList.append(["Title": i.outletName  , "id" : i.id ])
                            }
                            self.pickerOutlets.reloadAllComponents()
                            
                        }
                        self.arrUpcomingDeliveryResponse.removeAll()
                        
                        self.wsUpcomingDelivery(status: "-1", supplierId: self.txtSupplierFilter.selectedID, OutletId: self.txtOutletFIlter.selectedID, search: "")
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
    //This method is ussed for on selecting filter button
    func filterapiCallingOfBuyersSupliersOnSelectedIndex(){
        self.imgDelievry.isHidden = true
        self.SearchView.isHidden = false
        self.lblNodelievry.isHidden = true
        self.lblAddSome.isHidden = true
        self.btnAddproduct.isHidden = true
        self.filterBGView.isHidden = true
        self.filterview.isHidden   = true
        self.txtSearch.resignFirstResponder()
        //Buyer = 2 , supplier = 1
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            if self.selectedIndexPath ==  IndexPath(row: 0, section: 0) {
                self.arrOrderResponse.removeAll()
            }
        } else {
            if self.selectedIndexPath ==  IndexPath(row: 1, section: 0)  {
                self.arrDraftOrderResponse.removeAll()
                self.responseCountDraftOrder = 0
                self.isBottomRefreshDraftOrder = true
            } else {
                self.arrOrderResponse.removeAll()
                self.buyerPageDraftOrder = 1
                self.responseCountDraftOrder = 0
                self.isBottomRefreshDraftOrder = true
                
                wsUpcomingDelivery(status: "-1", supplierId: supplierId, OutletId: "", search: strSearch)
            }
        }
    }
    @IBAction func showResultAction(_ sender: Any) {
        filterapiCallingOfBuyersSupliersOnSelectedIndex()
    }
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated:true)
    }
    @IBAction func btnFilterAct(_ sender: Any) {
        self.filterview.isHidden = false
        self.filterBGView.isHidden  = false
        self.supplierCollectionView.reloadData()
        let supplierheight = supplierCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.supplierCollectionViewHeightConstraint.constant = supplierheight > 240 ? supplierheight + 15 : supplierheight + 10
        self.supplierCollectionView.layoutIfNeeded()
        self.supplierCollectionView.reloadData()
        self.outletCollectionView.reloadData()
        let outletHeight = outletCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.outletCollectionViewHeightConstraint.constant = outletHeight > 240 ? outletHeight + 15 : outletHeight + 10
        self.outletCollectionView.layoutIfNeeded()
        self.outletCollectionView.reloadData()
        self.statusCollectionView.reloadData()
        let height = statusCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.statusCollectionViewHeightConstriant.constant = height > 240 ? height + 15 : height + 10
        self.statusCollectionView.layoutIfNeeded()
        self.statusCollectionView.reloadData()
        self.arrPaymentResponse.removeAll()
    }
    @IBAction func btnApplyFilterAct(_ sender: Any) {
        self.arrUpcomingDeliveryResponse.removeAll()
        self.wsUpcomingDelivery(status: self.txtStatusFilter.selectedID != "" ? self.txtStatusFilter.selectedID : "-1", supplierId: self.txtSupplierFilter.selectedID, OutletId: self.txtOutletFIlter.selectedID, search: "")
    }
    @IBAction func btnClearFilter(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
        } else {
            self.arrUpcomingDeliveryResponse.removeAll()
            wsUpcomingDelivery(status: "-1", supplierId: "", OutletId: "", search: strSearch)
        }
    }
    @IBAction func BtnClearAll(_ sender: Any) {
        self.arrUpcomingDeliveryResponse.removeAll()
        supplierIndexPath              = nil
        outletIndexPath              = nil
        statusIndexPath              = nil
        self.filterview.isHidden = false
        self.filterBGView.isHidden  = false
    }
    
    
    @IBAction func btnCloseFilterAct(_ sender: Any) {
        self.filterview.isHidden = true
        self.filterBGView.isHidden  = true
    }
    
}
// MARK: - UITableView Delegate Methods
//This method is used for create the table cell
extension DeliveryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUpcomingDeliveryResponse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryTblCell")! as! DeliveryTblCell
        cell.lblOrderNumber.text = "\(self.arrUpcomingDeliveryResponse[indexPath.row].uniqueName)"
        cell.lblOrderName.text = self.arrUpcomingDeliveryResponse[indexPath.row].supplierInfo?.supplierName?.rawValue ?? ""
        cell.lblOrderStatus.text = self.arrUpcomingDeliveryResponse[indexPath.row].statusName
        
        cell.lblOrderDate.text = "\(self.arrUpcomingDeliveryResponse[indexPath.row].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "MMM dd"))"//" hh:mm a"))"
        cell.lblOrderAmount.text = "AED \(self.arrUpcomingDeliveryResponse[indexPath.row].totalPayableAmount)"
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(self.arrUpcomingDeliveryResponse[indexPath.row].supplierInfo?.supplierProfile?.rawValue ?? "")")
        cell.imgDelivery.kf.indicatorType = .activity
        cell.imgDelivery.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_placeholder"),
            options: nil)
        if indexPath.row % 2 == 0{
            cell.backgroundColor = .white
        } 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let objInvoiceDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "DeliveryDetailVC") as? DeliveryDetailVC {
//            objInvoiceDetailVC.orderId = self.arrUpcomingDeliveryResponse[indexPath.row].id
//            self.navigationController?.pushViewController(objInvoiceDetailVC, animated: true)
//        }
    }
    //MARK: - UIScrollView Method
    // This are used for scroll View Delegate for more data
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isBottomRefresh = true
        loadMoreFromBottom()
    }
    //This method is used for load more data
    func loadMoreFromBottom() {
        if responseCount > self.arrUpcomingDeliveryResponse.count{
            page = page + 1
            fetch = fetch + 10
            self.tblDeliveries.refreshControl?.showWithAnimation(onView: self.tblDeliveries, animation: .bottom)
            wsUpcomingDelivery(status: "-1", supplierId: "", OutletId: "", search: strSearch)
        }
    }
}
// MARK: - Pickerview Methods
// This method are used for Picker in filter dropdown
extension DeliveryVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView {
        case pickerSuppliers:
            return self.arrSuppliers.count
        case pickerOutlets:
            return self.arrOutletList.count
        case pickerStatus:
            return self.arrStatusDropdown.count
        case pickerPaymentType:
            return self.titlesDic.count
        default:
            return 5
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case pickerSuppliers:
            let objCommonModel = CommonModel(data : arrSuppliers[row] as NSDictionary)
            return objCommonModel.strTitle
        case pickerOutlets:
            let objCommonModel = CommonModel(data : arrOutletList[row] as NSDictionary)
            return objCommonModel.strTitle
        case pickerStatus:
            return self.arrStatusDropdown[row].name
        case pickerPaymentType:
            let objCommonModel = CommonModel(data : titlesDic[row] as NSDictionary)
            return objCommonModel.strTitle
        default:
            let objCommonModel = CommonModel(data : arrOutletList[row] as NSDictionary)
            return objCommonModel.strTitle
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        switch pickerView {
        case pickerSuppliers:
            let objCommonModel = CommonModel(data : arrSuppliers[row] as NSDictionary)
            txtSupplierFilter.text = objCommonModel.strTitle
            txtSupplierFilter.selectedID = objCommonModel.strID
        case pickerOutlets:
            let objCommonModel = CommonModel(data : arrOutletList[row] as NSDictionary)
            txtOutletFIlter.text = objCommonModel.strTitle
            txtOutletFIlter.selectedID = objCommonModel.strID
        case pickerStatus:
            txtStatusFilter.text = self.arrStatusDropdown[row].name
            txtStatusFilter.selectedID = self.arrStatusDropdown[row].status.rawValue
        default:
            let objCommonModel = CommonModel(data : arrSuppliers[row] as NSDictionary)
            txtSupplierFilter.text = objCommonModel.strTitle
            txtSupplierFilter.selectedID = objCommonModel.strID
        }
    }
}
//In this method are used for collection view delegate
extension DeliveryVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == supplierCollectionView{
            return arrSuppliers.count
        }else if collectionView == outletCollectionView{
            return arrOutletList.count
        }else if collectionView == statusCollectionView{
            return arrStatusDropdown.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == supplierCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            let objCommonModel = CommonModel(data : arrSuppliers[indexPath.row] as NSDictionary)
            cell.filteredLabel.text         = objCommonModel.strTitle
            cell.bgView.borderWidth         = 1
            cell.layer.cornerRadius         = 6
            cell.filteredLabel.font         = UIFont.systemFont(ofSize: 14.0)
            cell.bgView.backgroundColor =  supplierIndexPath == indexPath ? hexStringToUIColor(hex: "#FFF5FA") : hexStringToUIColor(hex: "#EDF5FF")
            cell.bgView.borderColor     =  supplierIndexPath == indexPath ? hexStringToUIColor(hex: "#EC187B") : hexStringToUIColor(hex: "#EDF5FF")
            cell.filteredLabel.textColor = .black
            return cell
        }else if collectionView == outletCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            let objCommonModel = CommonModel(data : arrOutletList[indexPath.row] as NSDictionary)
            cell.filteredLabel.text         = objCommonModel.strTitle
            cell.bgView.borderWidth         = 1
            cell.layer.cornerRadius         = 6
            cell.filteredLabel.font         = UIFont.systemFont(ofSize: 14.0)
            cell.bgView.backgroundColor =  outletIndexPath == indexPath ? hexStringToUIColor(hex: "#FFF5FA") : hexStringToUIColor(hex: "#EDF5FF")
            cell.bgView.borderColor     =  outletIndexPath == indexPath ? hexStringToUIColor(hex: "#EC187B") : hexStringToUIColor(hex: "#EDF5FF")
            cell.filteredLabel.textColor = .black
            
            return cell
        }else if collectionView == statusCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            cell.filteredLabel.text         = arrStatusDropdown[indexPath.row].name
            cell.bgView.borderWidth         = 1
            cell.layer.cornerRadius         = 6
            cell.filteredLabel.font         = UIFont.systemFont(ofSize: 14.0)
            cell.bgView.backgroundColor =  statusIndexPath == indexPath ? hexStringToUIColor(hex: "#FFF5FA") : hexStringToUIColor(hex: "#EDF5FF")
            cell.bgView.borderColor     =  statusIndexPath == indexPath ? hexStringToUIColor(hex: "#EC187B") : hexStringToUIColor(hex: "#EDF5FF")
            cell.filteredLabel.textColor = .black
            
            return cell
        }else{
            return  UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == supplierCollectionView{
            if self.arrSuppliers.count == 0{
                return CGSize()
            }
            let objCommonModel = CommonModel(data : arrSuppliers[indexPath.row] as NSDictionary)
            let text = objCommonModel.strTitle ?? ""
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 44.0
            return CGSize(width: cellWidth, height: 38.0)
        }else if collectionView == outletCollectionView{
            if self.arrOutletList.count == 0{
                return CGSize()
            }
            let objCommonModel = CommonModel(data : arrOutletList[indexPath.row] as NSDictionary)
            let text = objCommonModel.strTitle ?? ""
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 50.0
            return CGSize(width: cellWidth, height: 38.0)
        }else if collectionView == statusCollectionView{
            if self.arrStatusDropdown.count == 0{
                return CGSize()
            }
            let text = arrStatusDropdown[indexPath.row].name
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 50.0
            return CGSize(width: cellWidth, height: 38.0)
        }else{
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == supplierCollectionView{
            let objCommonModel = CommonModel(data : arrSuppliers[indexPath.row] as NSDictionary)
            if supplierIndexPath == indexPath {
                supplierIndexPath = nil
                supplierId = ""
            }else{
                supplierId = objCommonModel.strID
                supplierIndexPath = indexPath
            }
            supplierCollectionView.reloadData()
        }else if collectionView == outletCollectionView{
            let objCommonModel = CommonModel(data : arrOutletList[indexPath.row] as NSDictionary)
            if outletIndexPath == indexPath {
                outletIndexPath = nil
                outletId        = ""
            }else{
                outletId        = objCommonModel.strID
                outletIndexPath = indexPath
            }
            outletCollectionView.reloadData()
        }else if collectionView == statusCollectionView{
            if statusIndexPath == indexPath {
                statusIndexPath = nil
                statusId        = ""
            }else{
                statusId        =  arrStatusDropdown[indexPath.row].status.rawValue
                statusIndexPath = indexPath
            }
            statusCollectionView.reloadData()
        }
        self.numberofFiltersApplies()
    }
    func numberofFiltersApplies(){
        if supplierIndexPath == nil && outletIndexPath == nil && statusIndexPath == nil {
            print("No Filters Applied")
            self.filterAppliedLabel.text = "No Filters Applied"
        }else if  supplierIndexPath != nil && outletIndexPath != nil && statusIndexPath != nil{
            self.filterAppliedLabel.text = "3 filters Applied"
        }else if supplierIndexPath != nil && outletIndexPath != nil {
            self.filterAppliedLabel.text = "2 Filters Applied"
        }else if outletIndexPath != nil && statusIndexPath != nil{
            self.filterAppliedLabel.text = "2 Filters Applied"
        }else if statusIndexPath != nil  && supplierIndexPath != nil {
            self.filterAppliedLabel.text = "2 Filters Applied"
        }else {
            self.filterAppliedLabel.text = "1 Filters Applied"
        }
    }
}
//This are used in to seach in textfileds
extension DeliveryVC {
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if(textField.returnKeyType==UIReturnKeyType.next) {
            textField.superview?.viewWithTag(textField.tag+1)?.becomeFirstResponder()
        }
        else if(textField.returnKeyType==UIReturnKeyType.done){
            textField.resignFirstResponder()
            if textField == txtSearch{
                textField.resignFirstResponder()  //if desired
                performAction()
            }
        }
        return true
    }
}

