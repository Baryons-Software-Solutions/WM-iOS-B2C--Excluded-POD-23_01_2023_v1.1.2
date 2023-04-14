//
//  MyOrdersViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 11/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
var globalCreateOrderAddress = 0
class MyOrdersViewController: UIViewController {
    
    @IBOutlet weak var vwSuccess                : UIView!
    @IBOutlet weak var vwDelete                 : UIView!
    @IBOutlet weak var lblOrderYet              : UILabel!
    @IBOutlet weak var lblLooks                 : UILabel!
    @IBOutlet weak var btnOrderNow              : UIButton!
    @IBOutlet weak var imgOrder                 : UIImageView!
    @IBOutlet weak var myOrdersTableView        : UITableView!
    @IBOutlet weak var filterCollectionView     : UICollectionView!
    @IBOutlet weak var myOrdersTitleLabel       : UILabel!
    @IBOutlet weak var searchTextField          : UITextField!
    @IBOutlet weak var filterButton             : UIButton!
    @IBOutlet weak var noDataLabel              : UILabel!
    @IBOutlet weak var SearchView               : UITextField!
    @IBOutlet weak var SearchImg                : UIButton!
    @IBOutlet weak var lblYourAre               : UILabel!
    @IBOutlet weak var btnSignIn                : UIButton!
    @IBOutlet weak var lblSignInTo              : UILabel!
    @IBOutlet weak var closeButton              : UIButton!
    @IBOutlet weak var filterBGView             : UIView!
    @IBOutlet weak var filterview               : UIView!
    @IBOutlet weak var filterAppliedLabel       : UILabel!
    @IBOutlet weak var clearbutton              : UIButton!
    @IBOutlet weak var showResultButton         : UIButton!
    @IBOutlet weak var resultsFoundLabel        : UILabel!
    @IBOutlet weak var supplierStackView        : UIStackView!
    @IBOutlet weak var supplierLabel            : UILabel!
    @IBOutlet weak var supplierDropDown         : UIButton!
    @IBOutlet weak var supplierCollectionView   : UICollectionView!
    @IBOutlet weak var supplierCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var outletStackView          : UIStackView!
    @IBOutlet weak var outletNameLabel          : UILabel!
    @IBOutlet weak var outletDropDown           : UIButton!
    @IBOutlet weak var outletCollectionView     : UICollectionView!
    @IBOutlet weak var outletCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusStackview          : UIStackView!
    @IBOutlet weak var statusTitleLabel         : UILabel!
    @IBOutlet weak var statusDropDown           : UIButton!
    @IBOutlet weak var statusCollectionView     : UICollectionView!
    @IBOutlet weak var statusCollectionViewHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var vwCreateOrderView        : UIView!
    
    var topFilterContent               =  ["ALL ORDERS", "PENDING ACCEPTANCE"]
    var selectedIndexPath              = IndexPath(row: 0, section: 0)
    var arrOrderResponse               = [Order]()
    var arrDraftOrderResponse          = [DraftOrder]()
    var isBottomRefreshDraftOrder      = false
    var responseCountDraftOrder        = 0
    var arrSuppliers : [[String:Any]]  = []
    var arrOutletList : [[String:Any]] = []
    var arrStatusDropdown              = [StatusDropdown]()
    var isBottomRefresh                = false
    var responseCount                  = 0
    var searchedText                   = ""
    var buyerPageDraftOrder            = 1
    var supplierPageDraftOrder         = 1
    var arrTempID                      = NSMutableArray()
    var supplierIndexPath              : IndexPath?
    var outletIndexPath                : IndexPath?
    var statusIndexPath                : IndexPath?
    var supplierId                     = ""
    var outletId                       = ""
    var statusId                       = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.cornerRadius = 8
        btnOrderNow.cornerRadius = 8
        vwSuccess.isHidden = true
        UIElementsSetUp()
        registerXibs()
        delegatesSetup()
        lblYourAre.isHidden         = true
        lblSignInTo.isHidden         = true
        btnSignIn.isHidden         = true
        vwDelete.isHidden = true
        filterBGView.isHidden = true
        filterview.isHidden   = true
        vwCreateOrderView.isHidden   = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            self.imgOrder.isHidden         = false
            self.lblYourAre.isHidden         = false
            self.lblSignInTo.isHidden         = false
            self.btnSignIn.isHidden         = false
            self.SearchView.isHidden = false
            self.searchTextField.isHidden = true
            self.SearchImg.isHidden = true
            self.filterButton.isHidden = true
        }else{
            lblYourAre.isHidden         = true
            lblSignInTo.isHidden         = true
            btnSignIn.isHidden         = true
            self.tabBarController?.tabBar.isHidden = false
            searchTextField.text = ""
            searchedText = ""
            apiCallingOfBuyersSupliersOnSelectedIndex()
        }
    }
    func registerXibs(){
        filterCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        supplierCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        outletCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        statusCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        myOrdersTableView.register(UINib.init(nibName: "AllOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "AllOrdersTableViewCell")
    }
    
    func UIElementsSetUp(){
        self.filterBGView.backgroundColor = .black
        self.filterBGView.alpha           = 0.6
        self.searchTextField.setLeftPaddingPoints(34)
        self.searchTextField.placeholder  = "Search"
        self.filterAppliedLabel.text      = "Sort & Filter"
        self.noDataLabel.isHidden         = true
        self.imgOrder.isHidden         = true
        self.btnOrderNow.isHidden         = true
        self.lblLooks.isHidden         = true
        self.lblOrderYet.isHidden         = true
        self.lblYourAre.isHidden         = true
        self.lblSignInTo.isHidden         = true
        self.btnSignIn.isHidden         = true
        self.resultsFoundLabel.isHidden   = true
        self.myOrdersTableView.refreshControl?.hideWithAnimation(hidden: true)
        self.myOrdersTableView.tableFooterView = UIView()
        self.searchTextField.delegate = self
        self.searchTextField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.supplierDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
        self.outletDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
        self.statusDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if searchTextField.text?.count ?? 0 == 0{
            searchedText = ""
            apiCallingOfBuyersSupliersOnSelectedIndex()
        }
    }
    func delegatesSetup(){
        supplierCollectionView.delegate = self
        supplierCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        outletCollectionView.delegate = self
        outletCollectionView.dataSource = self
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
    }
    func apiCallingOfBuyersSupliersOnSelectedIndex(){
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            
        }else{
            self.noDataLabel.isHidden = true
            self.SearchView.isHidden         = false
            self.SearchImg.isHidden         = false
            self.filterButton.isHidden         = false
            self.imgOrder.isHidden         = true
            self.btnOrderNow.isHidden         = true
            self.lblLooks.isHidden         = true
            self.lblOrderYet.isHidden         = true
            self.lblYourAre.isHidden         = true
            self.lblSignInTo.isHidden         = true
            self.btnSignIn.isHidden         = true
            //Buyer = 2 , supplier = 1
            resetValues()
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                vwCreateOrderView.isHidden  = true
                if self.selectedIndexPath ==  IndexPath(row: 0, section: 0) {
                    self.arrOrderResponse.removeAll()
                    self.wsSupplierOrders(status: "0", buyerId: "", OutletId: outletId, search: searchedText)
                } else {
                    self.arrOrderResponse.removeAll()
                    self.wsSupplierOrders(status: "-1", buyerId: "", OutletId: outletId, search: searchedText)
                }
            } else {
                vwCreateOrderView.isHidden  = true
                if self.selectedIndexPath ==  IndexPath(row: 1, section: 0)  {
                    self.arrDraftOrderResponse.removeAll()
                    self.responseCountDraftOrder = 0
                    self.isBottomRefreshDraftOrder = true
                    wsDraftOrders(status: "0", supplierId: supplierId, OutletId: outletId, search: searchedText)
                }else {
                    self.arrOrderResponse.removeAll()
                    self.buyerPageDraftOrder = 1
                    self.responseCountDraftOrder = 0
                    self.isBottomRefreshDraftOrder = true
                    wsBuyerOrders(status: "-1", supplierId: supplierId, OutletId: outletId, search: searchedText)
                }
            }
        }
    }
    func filterapiCallingOfBuyersSupliersOnSelectedIndex(){
        self.noDataLabel.isHidden  = true
        self.SearchView.isHidden         = false
        self.SearchImg.isHidden         = false
        self.filterButton.isHidden         = false
        self.imgOrder.isHidden         = true
        self.btnOrderNow.isHidden         = true
        self.lblLooks.isHidden         = true
        self.lblOrderYet.isHidden         = true
        self.lblYourAre.isHidden         = true
        self.lblSignInTo.isHidden         = true
        self.btnSignIn.isHidden         = true
        self.filterBGView.isHidden = true
        self.filterview.isHidden   = true
        self.searchTextField.resignFirstResponder()
        //Buyer = 2 , supplier = 1
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            if self.selectedIndexPath ==  IndexPath(row: 0, section: 0) {
                self.arrOrderResponse.removeAll()
                self.wsSupplierOrders(status: statusId, buyerId: supplierId, OutletId: outletId, search: searchedText)
            } else {
                self.arrOrderResponse.removeAll()
                self.wsSupplierOrders(status: statusId, buyerId: supplierId, OutletId: outletId, search: searchedText)
            }
        } else {
            if self.selectedIndexPath ==  IndexPath(row: 1, section: 0)  {
                self.arrDraftOrderResponse.removeAll()
                self.responseCountDraftOrder = 0
                self.isBottomRefreshDraftOrder = true
                wsDraftOrders(status: statusId, supplierId: supplierId, OutletId: outletId, search: searchedText)
            } else {
                self.arrOrderResponse.removeAll()
                self.buyerPageDraftOrder = 1
                self.responseCountDraftOrder = 0
                self.isBottomRefreshDraftOrder = true
                wsBuyerOrders(status: statusId, supplierId: supplierId, OutletId: outletId, search: searchedText)
            }
        }
    }
    func resetValues(){
        self.filterview.isHidden        =  true
        self.filterBGView.isHidden      = true
        supplierId                      = ""
        outletId                        = ""
        statusId                        = "0"
        supplierIndexPath               = nil
        outletIndexPath                 = nil
        statusIndexPath                 = nil
        searchTextField.resignFirstResponder()
    }
    @IBAction func btnSignIn(_ sender: Any) {
        
    }
    
    @IBAction func BtnOrderNow(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            dashboardVC.modalPresentationStyle = .fullScreen
        }else{
            let SearchViewController = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            SearchViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(SearchViewController, animated: true)
        }
    }
    @IBAction func supplierDropDown(_ sender: UIButton) {
        if supplierDropDown.isSelected{
            supplierDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            supplierCollectionView.isHidden = false
        }else{
            supplierDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            supplierCollectionView.isHidden = true
        }
        supplierDropDown.isSelected = !supplierDropDown.isSelected
    }
    
    @IBAction func outletDropDown(_ sender: UIButton) {
        if outletDropDown.isSelected{
            outletDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            outletCollectionView.isHidden = false
        }else{
            outletDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            outletCollectionView.isHidden = true
        }
        outletDropDown.isSelected = !outletDropDown.isSelected
    }
    
    @IBAction func statusDropDown(_ sender: UIButton) {
        if statusDropDown.isSelected{
            statusDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            statusCollectionView.isHidden = false
        }else{
            statusDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            statusCollectionView.isHidden = true
        }
        statusDropDown.isSelected = !statusDropDown.isSelected
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        filterview.isHidden = true
        filterBGView.isHidden = true
        searchTextField.resignFirstResponder()
    }
    @IBAction func btnclose(_ sender: Any) {
        filterBGView.isHidden = true
        vwDelete.isHidden   = true
    }
    
    
    @IBAction func btnCreateOrderAct(_ sender: Any) {
        let supplierVc = menuStoryBoard.instantiateViewController(withIdentifier: "SupplierViewController") as? SupplierViewController
        globalCreateOrderAddress = 0
        self.navigationController?.pushViewController(supplierVc!, animated: true)
    }
    
    @IBAction func clearAllButton(_ sender: Any) {
        supplierIndexPath = nil
        outletIndexPath   = nil
        statusIndexPath   = nil
        supplierCollectionView.reloadData()
        outletCollectionView.reloadData()
        statusCollectionView.reloadData()
        numberofFiltersApplies()
        resetValues()
        self.filterBGView.isHidden  = false
        self.filterview.isHidden = false
    }
    @IBAction func showResultAction(_ sender: Any) {
        filterapiCallingOfBuyersSupliersOnSelectedIndex()
    }
    @IBAction func filterButtonAction(_ sender: Any) {
        outletCollectionView.isHidden = true
        statusCollectionView.isHidden = true
        outletIndexPath   = nil
        statusIndexPath   = nil
        self.filterview.isHidden = false
        self.filterBGView.isHidden  = false
        self.supplierCollectionView.reloadData()
        let supplierheight = supplierCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.supplierCollectionViewHeightConstraint.constant = supplierheight > 240 ? supplierheight + 10 : supplierheight + 10
        self.supplierCollectionView.layoutIfNeeded()
        self.supplierCollectionView.reloadData()
        self.outletCollectionView.reloadData()
        let outletHeight = outletCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.outletCollectionViewHeightConstraint.constant = outletHeight > 240 ? outletHeight + 10 : outletHeight + 10
        self.outletCollectionView.layoutIfNeeded()
        self.outletCollectionView.reloadData()
        self.statusCollectionView.reloadData()
        let height = statusCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.statusCollectionViewHeightConstriant.constant = height > 240 ? height + 10 : height + 10
        self.statusCollectionView.layoutIfNeeded()
        self.statusCollectionView.reloadData()
    }
}

extension MyOrdersViewController {
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.count ?? 0 >= 1{
            searchedText = searchTextField.text ?? ""
            apiCallingOfBuyersSupliersOnSelectedIndex()
        }
        return true
    }
}
//This method is used for create the collection cell
extension MyOrdersViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView{
            return topFilterContent.count
        }else if collectionView == supplierCollectionView{
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
        if collectionView == filterCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
            cell.filteredLabel.text = topFilterContent[indexPath.item]
            cell.filteredLabel.textColor = hexStringToUIColor(hex: "#EC187B")
            cell.bgView.cornerRadius = 15
            cell.filteredLabel.font = UIFont.systemFont(ofSize: 14.0)
            if selectedIndexPath == indexPath {
                cell.filteredLabel.textColor = hexStringToUIColor(hex: "#EC187B")
                cell.bgView.backgroundColor  = hexStringToUIColor(hex: "#FFFFFF")
            }else{
                cell.filteredLabel.textColor = hexStringToUIColor(hex: "#FFFFFF")
                cell.bgView.backgroundColor  = .clear
            }
            return cell
        }else if collectionView == supplierCollectionView{
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
        if collectionView ==  filterCollectionView{
            let text = topFilterContent[indexPath.item]
            let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16.0)]).width + 40.0
            return CGSize(width: cellWidth, height: 40.0)
        }else if collectionView == supplierCollectionView{
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
        
        if collectionView == filterCollectionView{
            selectedIndexPath = indexPath
            searchTextField.text = ""
            apiCallingOfBuyersSupliersOnSelectedIndex()
            print("\(selectedIndexPath) is selected")
            filterCollectionView.reloadData()
        }else if collectionView == supplierCollectionView{
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
        
    }
}



// MARK: -table view delegate functions

//This method is used for create the table cell
extension MyOrdersViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //buyer = 2
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            return  self.arrOrderResponse.count
        } else {
            if self.selectedIndexPath ==  IndexPath(row: 1, section: 0)  {
                return self.arrDraftOrderResponse.count
            } else {
                return  self.arrOrderResponse.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrdersTableViewCell", for: indexPath)as? AllOrdersTableViewCell
            if arrOrderResponse.count == 0{
                return UITableViewCell()
            }
            cell?.ratingsView.rating = 0
            cell?.amountLabel.text = "AED " + "\(self.arrOrderResponse[indexPath.row].totalPayableAmount.rawValue)"
            cell?.outletNameLabel.text = "Address" + (self.arrOrderResponse[indexPath.row].supplierInfo.supplierAddress?.rawValue ?? "")
            
            if self.arrOrderResponse[indexPath.row].dueDate != nil{
                cell?.payementDueLabel.text = "Payement Due by " + "\(self.arrOrderResponse[indexPath.row].dueDate ?? "")"
            }else{
                cell?.payementDueLabel.text =  "Payement Due by " + "\(self.arrOrderResponse[indexPath.row].dueDate ?? "")"
            }
            
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\( (self.arrOrderResponse[indexPath.row].supplierInfo.supplierProfile?.rawValue) ?? "")")
            cell?.ordersImageView.kf.indicatorType = .activity
            cell?.ordersImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: nil)
            
            cell?.emailSentLable.text = self.arrOrderResponse[indexPath.row].statusName.rawValue
            var paymentStatus: String = ""
            
            if self.arrOrderResponse[indexPath.row].paidStatus == 20 {
                paymentStatus = "Paid"
                cell?.paidLabel.text = "Paid"
                cell?.paidLabel.textColor = .white
                cell?.paidLabel.backgroundColor = UIColor(hexFromString: "#36B152")
                cell?.paidLabel.borderColor = UIColor(hexFromString: "#36B152")
                cell?.paidLabel.borderWidth = 0
                cell?.payementDueLabel.isHidden = true
            } else {
                if Double(self.arrOrderResponse[indexPath.row].totalPayableAmount.rawValue) ?? 0 > 0 {
                    cell?.paidLabel.isHidden = false
                } else {
                    cell?.paidLabel.isHidden = true
                }
                if self.arrOrderResponse[indexPath.row].supplierID == "5fe9bd17e01343382c2ada9e"  {
                    cell?.paidLabel.text = self.arrOrderResponse[indexPath.row].statusName.rawValue
                    paymentStatus = "Pay Now"
                    cell?.paidLabel.text = "Pay Now"
                    cell?.paidLabel.textColor = .white
                    cell?.paidLabel.backgroundColor = .gray
                    cell?.paidLabel.borderColor = .gray
                } else {
                    cell?.paidLabel.text = self.arrOrderResponse[indexPath.row].statusName.rawValue
                    paymentStatus = "Not Paid"
                    cell?.paidLabel.backgroundColor = .red
                    cell?.paidLabel.textColor = .white
                    cell?.paidLabel.borderColor = .red
                    cell?.payementDueLabel.isHidden = false
                }
            }
            if paymentStatus.isEmpty {
                cell?.paidLabel.isHidden = true
            } else {
                cell?.paidLabel.isHidden = false
                cell?.paidLabel.text = paymentStatus
            }
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                cell?.ordersImageView.isHidden = true
                var buyerCompanyName = ""
                if let buyerDetails = self.arrOrderResponse[indexPath.row].buyerCompanyName {
                    buyerCompanyName = buyerDetails
                }
                cell?.productname.text = "Buyer: " + buyerCompanyName
                cell?.outletNameLabel.text = "Address: " + self.arrOrderResponse[indexPath.row].outletInfo.name
            } else {
                cell?.ordersImageView.isHidden = false
                cell?.productname.text = self.arrOrderResponse[indexPath.row].supplierInfo.supplierName?.rawValue ?? ""
            }
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
        }else if self.selectedIndexPath ==  IndexPath(row: 1, section: 0)  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrdersTableViewCell", for: indexPath)as? AllOrdersTableViewCell
            if arrDraftOrderResponse.count == 0{
                return UITableViewCell()
            }
            cell?.ratingsView.rating = 0
            cell?.productname.text = self.arrOrderResponse[indexPath.row].supplierInfo.supplierName?.rawValue ?? ""
            cell?.amountLabel.text = "AED " + "\(self.arrDraftOrderResponse[indexPath.row].totalPayableAmount?.rawValue ?? "0")"
            cell?.outletNameLabel.text = "Address" + (self.arrOrderResponse[indexPath.row].supplierInfo.supplierAddress?.rawValue ?? "")
            
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\( (self.arrDraftOrderResponse[indexPath.row].supplierInfo?.supplierProfile?.rawValue) ?? "")")
            cell?.ordersImageView.kf.indicatorType = .activity
            cell?.ordersImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: nil)
            cell?.paidLabel.text = self.arrDraftOrderResponse[indexPath.row].approveStatusName
            if self.arrDraftOrderResponse[indexPath.row].approveStatus >= 10 && self.arrDraftOrderResponse[indexPath.row].approveStatus <= 40{
                cell?.deleteButton.isHidden = false
            } else {
                cell?.deleteButton.isHidden = true
            }
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
            return cell ?? UITableViewCell()
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrdersTableViewCell", for: indexPath)as? AllOrdersTableViewCell
            if arrOrderResponse.count == 0{
                return UITableViewCell()
            }
            
            cell?.ratingsView.rating = 0
            cell?.amountLabel.text = "AED " + "\(self.arrOrderResponse[indexPath.row].totalPayableAmount.rawValue)"
            cell?.outletNameLabel.text = "Address: " + (self.arrOrderResponse[indexPath.row].supplierInfo.supplierAddress?.rawValue ?? "")
            
            if self.arrOrderResponse[indexPath.row].dueDate != nil{
                cell?.payementDueLabel.text = "" + "\(self.arrOrderResponse[indexPath.row].dueDate ?? "")"
            }else{
                cell?.payementDueLabel.text = "" + "\(self.arrOrderResponse[indexPath.row].dueDate ?? "")"
            }
            
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\( (self.arrOrderResponse[indexPath.row].supplierInfo.supplierProfile?.rawValue) ?? "")")
            cell?.ordersImageView.kf.indicatorType = .activity
            cell?.ordersImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_placeholder"),
                options: nil)
            
            cell?.emailSentLable.text = self.arrOrderResponse[indexPath.row].statusName.rawValue
            var paymentStatus: String = ""
            
            if self.arrOrderResponse[indexPath.row].paidStatus == 20 {
                paymentStatus = "Paid"
                cell?.paidLabel.text = "Paid"
                cell?.paidLabel.textColor = .white
                cell?.paidLabel.backgroundColor = UIColor(hexFromString: "#36B152")
                cell?.paidLabel.borderColor = UIColor(hexFromString: "#36B152")
                cell?.paidLabel.borderWidth = 0
                cell?.payementDueLabel.isHidden = true
            } else {
                if Double(self.arrOrderResponse[indexPath.row].totalPayableAmount.rawValue) ?? 0 > 0 {
                    cell?.paidLabel.isHidden = false
                } else {
                    cell?.paidLabel.isHidden = true
                }
                if self.arrOrderResponse[indexPath.row].supplierID == "5fe9bd17e01343382c2ada9e"  {
                    cell?.paidLabel.text = self.arrOrderResponse[indexPath.row].statusName.rawValue
                    paymentStatus = "Pay Now"
                    
                    cell?.paidLabel.text = "Pay Now"
                    cell?.paidLabel.textColor = .white
                    cell?.paidLabel.backgroundColor = .gray
                    cell?.paidLabel.borderColor = .gray
                    
                } else {
                    cell?.payementDueLabel.text = "Payment due by " + " \(self.arrOrderResponse[indexPath.row].orderDateTime.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "MMMM dd") ?? "")"
                    cell?.paidLabel.text = self.arrOrderResponse[indexPath.row].statusName.rawValue
                    paymentStatus = "Not Paid"
                    cell?.paidLabel.backgroundColor = .red
                    cell?.paidLabel.textColor = .white
                    cell?.paidLabel.borderColor = .red
                    cell?.payementDueLabel.isHidden = false
                }
            }
            if paymentStatus.isEmpty {
                cell?.paidLabel.isHidden = true
            } else {
                cell?.paidLabel.isHidden = false
                cell?.paidLabel.text = paymentStatus
            }
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                cell?.ordersImageView.isHidden = true
                var buyerCompanyName = ""
                if let buyerDetails = self.arrOrderResponse[indexPath.row].buyerCompanyName {
                    buyerCompanyName = buyerDetails
                }
                cell?.productname.text = "Buyer: " + buyerCompanyName
                cell?.outletNameLabel.text = "Address: " + self.arrOrderResponse[indexPath.row].outletInfo.name
            } else {
                cell?.ordersImageView.isHidden = false
                cell?.productname.text = self.arrOrderResponse[indexPath.row].supplierInfo.supplierName?.rawValue ?? ""
            }
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            if let objPlacedOrderViewVC = menuStoryBoard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController {
                objPlacedOrderViewVC.orderId = self.arrOrderResponse[indexPath.row].id
                objPlacedOrderViewVC.supplierId = self.arrOrderResponse[indexPath.row].supplierID
                self.navigationController?.pushViewController(objPlacedOrderViewVC, animated: true)
            }
            
        } else {
            if self.selectedIndexPath ==  IndexPath(row: 1, section: 0)  {
                if  let objPlacedOrderViewVC = menuStoryBoard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController {
                    objPlacedOrderViewVC.allorderApiCalling = false
                    objPlacedOrderViewVC.supplierId = self.arrOrderResponse[indexPath.row].supplierID
                    self.navigationController?.pushViewController(objPlacedOrderViewVC, animated: true)
                }
            } else {
                if let objPlacedOrderViewVC = menuStoryBoard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController {
                    objPlacedOrderViewVC.orderId = self.arrOrderResponse[indexPath.row].id
                    objPlacedOrderViewVC.allorderApiCalling = true
                    objPlacedOrderViewVC.supplierId = self.arrOrderResponse[indexPath.row].supplierID
                    self.navigationController?.pushViewController(objPlacedOrderViewVC, animated: true)
                }
            }
        }
    }
    @objc func btnDeleteClicked(sender:UIButton) {
        vwDelete.isHidden = false
        filterBGView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
}
extension MyOrdersViewController {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isBottomRefreshDraftOrder = true
        loadMoreFromBottom()
        
    }
    func loadMoreFromBottom() {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            if selectedIndexPath ==  IndexPath(row: 1, section: 0){
                if responseCount > self.arrOrderResponse.count{
                    supplierPageDraftOrder = supplierPageDraftOrder + 1
                    self.myOrdersTableView.refreshControl?.showWithAnimation(onView: self.myOrdersTableView, animation: .bottom)
                    wsSupplierOrders(status: "0", buyerId: "", OutletId: "", search: searchedText)
                }
            } else {
                if responseCount > self.arrOrderResponse.count{
                    supplierPageDraftOrder = supplierPageDraftOrder + 1
                    self.myOrdersTableView.refreshControl?.showWithAnimation(onView: self.myOrdersTableView, animation: .bottom)
                    wsSupplierOrders(status: "-1", buyerId: "", OutletId: "", search: searchedText)
                }
            }
        } else {
            if selectedIndexPath ==  IndexPath(row: 1, section: 0){
                if responseCountDraftOrder > self.arrDraftOrderResponse.count{
                    buyerPageDraftOrder = buyerPageDraftOrder + 1
                    self.myOrdersTableView.refreshControl?.showWithAnimation(onView: self.myOrdersTableView, animation: .bottom)
                    self.wsDraftOrders(status: "0", supplierId: "", OutletId: "", search: searchedText)
                }
            } else if selectedIndexPath ==  IndexPath(row: 0, section: 0){
                if responseCountDraftOrder > self.arrOrderResponse.count {
                    buyerPageDraftOrder = buyerPageDraftOrder + 1
                    self.myOrdersTableView.refreshControl?.showWithAnimation(onView: self.myOrdersTableView, animation: .bottom)
                    wsBuyerOrders(status: "-1", supplierId: "", OutletId: "", search: searchedText)
                }
            }
        }
    }
    
    //--->Pending Order Apis
    func wsDraftOrders(status: String,supplierId: String,OutletId: String,search: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "start=0&end=0&page=\(buyerPageDraftOrder)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&supplier_id=\(supplierId)&from_date=&to_date=&approve_status=\(status)"
        APICall().post(apiUrl: Constants.WebServiceURLs.DraftOrdersURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(DraftOrderResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            if self.isBottomRefreshDraftOrder == true {
                                self.arrDraftOrderResponse.append(contentsOf: [data][0].draftOrders)
                            } else  {
                                self.arrDraftOrderResponse = [data][0].draftOrders
                            }
                            self.isBottomRefreshDraftOrder = false
                            if self.arrDraftOrderResponse.count > 0{
                                self.responseCountDraftOrder = [data][0].totalCount
                                self.myOrdersTableView.delegate    = self
                                self.myOrdersTableView.dataSource = self
                                self.myOrdersTableView.reloadData()
                            } else {
                                self.myOrdersTableView.isHidden = true
                                self.noDataLabel.isHidden = false
                                self.SearchView.isHidden         = false
                                self.SearchImg.isHidden         = false
                                self.filterButton.isHidden         = false
                                self.imgOrder.isHidden         = false
                                self.btnOrderNow.isHidden         = false
                                self.lblLooks.isHidden         = false
                                self.lblOrderYet.isHidden         = false
                                self.lblYourAre.isHidden         = true
                                self.lblSignInTo.isHidden         = true
                                self.btnSignIn.isHidden         = true
                            }
                            for i in self.arrDraftOrderResponse{
                                self.arrSuppliers.append(["Title": i.supplierInfo?.supplierName?.rawValue ?? ""  , "id" : i.supplierID ])
                                self.arrOutletList.append(["Title": i.outletInfo?.name ?? ""  , "id" : i.outletID ])
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
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    
    //->view orders API
    func wsBuyerOrders(status: String,supplierId: String,OutletId: String,search: String){
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        self.arrStatusDropdown.removeAll()
        let postString = "start=0&end=0&page=\(buyerPageDraftOrder)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&supplier_id=\(supplierId)&from_date=&to_date=&status=\(status)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.OrderBuyerListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(PlacedOrderResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            if self.isBottomRefreshDraftOrder == true {
                                self.myOrdersTableView.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrOrderResponse.append(contentsOf: [data][0].orders)
                            } else  {
                                self.arrOrderResponse = [data][0].orders
                            }
                            self.isBottomRefreshDraftOrder = false
                            if self.arrOrderResponse.count > 0{
                                self.responseCountDraftOrder = [data][0].totalCount
                                self.myOrdersTableView.isHidden = false
                                self.myOrdersTableView.delegate = self
                                self.myOrdersTableView.dataSource = self
                                self.myOrdersTableView.reloadData()
                            } else {
                                self.myOrdersTableView.isHidden = true
                                self.noDataLabel.isHidden = false
                                self.SearchView.isHidden         = false
                                self.SearchImg.isHidden         = false
                                self.filterButton.isHidden         = false
                                self.imgOrder.isHidden         = false
                                self.btnOrderNow.isHidden         = false
                                self.lblLooks.isHidden         = false
                                self.lblOrderYet.isHidden         = false
                                self.lblYourAre.isHidden         = true
                                self.lblSignInTo.isHidden         = true
                                self.btnSignIn.isHidden         = true
                            }
                            for i in self.arrOrderResponse{
                                self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                self.arrSuppliers.append(["Title": i.supplierInfo.supplierName?.rawValue ?? ""  , "id" : i.supplierID ])
                                self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                                self.arrOutletList.append(["Title": i.outletInfo.name  , "id" : i.outletInfo ])
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
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    
    //below method refers, Supplier --> Pending for acceptance & view order list
    func wsSupplierOrders(status: String,buyerId: String,OutletId: String,search: String){
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "start=0&end=0&page=\(supplierPageDraftOrder)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&buyer_id=\(buyerId)&from_date=&to_date=&status=\(status)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.OrderSupplierListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(PlacedOrderResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            print("orders list::",[data][0].orders)
                            if self.isBottomRefresh == true {
                                self.myOrdersTableView.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrOrderResponse.append(contentsOf: [data][0].orders)
                            } else  {
                                self.arrOrderResponse = [data][0].orders
                            }
                            self.isBottomRefresh = false
                            if self.arrOrderResponse.count > 0{
                                self.responseCount = [data][0].totalCount
                                for i in self.arrOrderResponse{
                                    self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                    var buyerCompanyName = ""
                                    if let companyNameText = i.buyerCompanyName {
                                        buyerCompanyName=companyNameText
                                    }
                                    self.arrSuppliers.append(["Title": buyerCompanyName  , "id" : i.buyerID ])
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
                                self.myOrdersTableView.isHidden = false
                                self.myOrdersTableView.delegate = self
                                self.myOrdersTableView.dataSource = self
                                self.myOrdersTableView.reloadData()
                            } else {
                                self.noDataLabel.text = dicResponseData.message
                                self.myOrdersTableView.isHidden = true
                                self.noDataLabel.isHidden = false
                                self.SearchView.isHidden         = false
                                self.SearchImg.isHidden         = false
                                self.filterButton.isHidden         = false
                                self.imgOrder.isHidden = false
                                self.btnOrderNow.isHidden = false
                                self.lblLooks.isHidden = false
                                self.lblOrderYet.isHidden = false
                                self.lblYourAre.isHidden         = false
                                self.lblSignInTo.isHidden         = false
                                self.btnSignIn.isHidden         = false
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
    //This method is used for delete the products
    func wsDeleteProduct(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.DraftDeleteURL
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.accessToken.rawValue){
            request.setValue("Bearer " + (USERDEFAULTS.getDataForKey(.accessToken) as! String), forHTTPHeaderField: "Authorization")
            
        }
        var arrID = [String]()
        for i in self.arrTempID{
            arrID.append(i as! String)
        }
        showLoader()
        var params :[String: Any]?
        params = ["draft_order_id" : arrID]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                hideLoader()
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
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
                            let dictResponse = try decoder.decode(GenralResponseModel.self, from: data )
                            
                            let strStatus = dictResponse.success
                            
                            if strStatus == "1" {
                                DispatchQueue.main.async {
                                    
                                    self.showToast(message: dictResponse.message)
                                    self.arrDraftOrderResponse.removeAll()
                                    self.apiCallingOfBuyersSupliersOnSelectedIndex()
                                    
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.showToast(message: dictResponse.message)
                                }
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
    //This method is used for draft delete the products
    func wsDeleteProduct(draftOrderId: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "draft_order_id=\(draftOrderId)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.DraftDeleteURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showToast(message: dicResponseData.message)
                        self.arrDraftOrderResponse.removeAll()
                        self.apiCallingOfBuyersSupliersOnSelectedIndex()
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
//This class is used for common in image and title in all files 
class CommonModel {

    var strTitle : String!
    var strImage : String!
    var strSelectedImage : String!
    var strID : String!
    init(data : NSDictionary){
        strTitle = getStringFromJSON(data, key: "Title" , keyDic: "")
        strImage = getStringFromJSON(data, key: "image" , keyDic: "")
        strSelectedImage = getStringFromJSON(data, key: "selected_image" , keyDic: "")
        strID = getStringFromJSON(data, key: "id" , keyDic: "")

    }

    func getStringFromJSON(_ data: NSDictionary, key: String , keyDic : String) -> String{

        if let info = data[key] as? String {
            return info
        }

        if let info = data[key] as? [String : AnyObject]{

            if let infoDic = info[keyDic]{

                return infoDic as! String
            }

        }
        return ""
    }
}
