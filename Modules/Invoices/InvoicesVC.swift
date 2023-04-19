//
//  InvoicesVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 16/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import FittedSheets
import ExpyTableView
import PaymentSDK
import SideMenu

class InvoicesVC: UIViewController {
    
    @IBOutlet weak var vwSuccess: UIView!
    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var lblYou: UILabel!
    @IBOutlet weak var lblNoInvoice: UILabel!
    @IBOutlet weak var imgInvoice: UIImageView!
    @IBOutlet weak var invoicePayment:UISegmentedControl!
    @IBOutlet weak var filterCollectionView     : UICollectionView!
    @IBOutlet weak var filterAppliedLabel: UILabel!
    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var filterview: UIView!
    @IBOutlet weak var btnPayments: UIButton!
    @IBOutlet weak var btnInvoices: UIButton!
    @IBOutlet weak var stackSelect: UIStackView!
    @IBOutlet weak var btnSelectAllOut: UIButton!
    @IBOutlet weak var btnMarkAsPaidOut: UIButton!
    @IBOutlet weak var btnSubmitNotes: UIButton!
    @IBOutlet weak var btnCancelNotes: UIButton!
    @IBOutlet weak var txtNotes: UITextField!
    @IBOutlet weak var vwNotes: UIView!
    @IBOutlet weak var lblReceivePaymentTitle: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblInvoiceList: UITableView!
    @IBOutlet weak var txtStatusFilter: UITextField!
    @IBOutlet weak var txtOutletFIlter: UITextField!
    @IBOutlet weak var txtSupplierFilter: UITextField!
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var vwFilter: UIView!
    @IBOutlet weak var vwReceivePayment: UIView!
    @IBOutlet weak var txtReceiveDate: UITextField!
    @IBOutlet weak var txtReceiveAmount: UITextField!
    @IBOutlet weak var txtPaymentType: UITextField!
    @IBOutlet weak var txtRemark: UITextField!
    @IBOutlet weak var lblTransactionId: UILabel!
    @IBOutlet weak var vwTransactionId: UIView!
    @IBOutlet weak var txtTransactionID: UITextField!
    @IBOutlet weak var btnSubmitReceivePaymentOut: UIButton!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var supplierStackView: UIStackView!
    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var supplierDropDown: UIButton!
    @IBOutlet weak var supplierCollectionView: UICollectionView!
    @IBOutlet weak var supplierCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var outletStackView: UIStackView!
    @IBOutlet weak var outletNameLabel: UILabel!
    @IBOutlet weak var outletDropDown: UIButton!
    @IBOutlet weak var outletCollectionView: UICollectionView!
    @IBOutlet weak var outletCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwStatusFilterPopup: UIView!
    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusDropDown: UIButton!
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var statusCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCancelReceiveOut: UIButton!
    @IBOutlet weak var btnApplyFilterOut: UIButton!
    @IBOutlet weak var btnClearFilterOut: UIButton!
    @IBOutlet weak var tblPayments: ExpyTableView!
    
    var topFilterContent                =  ["ALL ORDERS", "PENDING ACCEPTANCE"]
    var selectedIndexPath               = IndexPath(row: 0, section: 0)

    var arrOrderResponse                = [Order]()
    var arrDraftOrderResponse1          = [DraftOrder]()
    var arrDraftOrderResponse           = [Invoice]()
    var pickerSuppliers                 = UIPickerView()
    var pickerOutlets                   = UIPickerView()
    var pickerStatus                    = UIPickerView()
    var arrSuppliers : [[String:Any]]   = []
    var arrStatusDropdown               = [StatusDropdown]()
    var arrOutletList : [[String:Any]]  = []
    var strSearch                       = ""
    var searchedText                    = ""
    var isBottomRefreshDraftOrder       = false
    var responseCountDraftOrder         = 0
    var buyerPageDraftOrder             = 1
    var supplierPageDraftOrder          = 1
    var page                            = 1
    var isBottomRefresh                 = false
    var responseCount                   = 0
    var selectedInvoiceID               = ""
    var pickerPaymentType               = UIPickerView()
    var titlesDic : [[String:Any]]      = []
    var arrTempID                       = NSMutableArray()
    var indexPath                       = IndexPath()
    var arrTempCount                    = NSMutableArray()
    var pagePaymentList                 = 1
    var isBottomRefreshPaymentList      = false
    var responseCountPaymentList        = 0
    var arrPaymentResponse              = [Payment]()
    var objPaymentTblCell: PaymentTblCell?
    var supplierIndexPath              : IndexPath?
    var outletIndexPath                : IndexPath?
    var statusIndexPath                : IndexPath?
    var supplierId                      = ""
    var outletId                        = ""
    var statusId                        = "0"
    
    //MARK: - Variable Declaration
    // var titlesDic = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOrder.cornerRadius = 10
        vwSuccess.isHidden = true
        vwDelete.isHidden   = true
        btnOrder.isHidden = true
        UIElementsSetUp()
        registerXibs()
        delegatesSetup()
        filterBGView.isHidden = true
        filterview.isHidden   = true
        self.invoicePayment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        self.invoicePayment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hexFromString: "#59658E")], for: .normal)
        self.btnInvoices.isHidden = true
        navigationController?.isNavigationBarHidden = true
        self.initialization()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Initialization
    func registerXibs(){
        supplierCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        outletCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
        statusCollectionView.register(UINib.init(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
    }
    func UIElementsSetUp(){
        self.filterAppliedLabel.text      = "Sort & Filter"
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
    func resetValues(){
        self.filterview.isHidden         =  true
        self.filterBGView.isHidden       = true
        supplierId                      = ""
        outletId                        = ""
        statusId                        = "0"
        supplierIndexPath               = nil
        outletIndexPath                = nil
        statusIndexPath                = nil
        //searchTextField.resignFirstResponder()
    }
    //MARK: - Initialization
    
    func initialization(){
        self.navigationController?.navigationBar.isHidden = true
        self.btnSubmitReceivePaymentOut.cornerRadius = 6
        self.btnSubmitNotes.cornerRadius = 6
        self.btnCancelNotes.cornerRadius = 6
        self.btnCancelReceiveOut.cornerRadius = 6
        self.btnApplyFilterOut.cornerRadius = 6
        self.btnClearFilterOut.cornerRadius = 6
        titlesDic.append(["Title": "Cash"])
        titlesDic.append(["Title": "Cheque"])
        titlesDic.append(["Title": "Credit/Debit Card"])
        titlesDic.append(["Title": "Bank Transfer"])
        titlesDic.append(["Title": "Mobile Payment"])
        titlesDic.append(["Title": "Paid through Watermelon"])
        titlesDic.append(["Title": "Others"])
        
        self.tblInvoiceList.tableFooterView = UIView()
        self.tblInvoiceList.register(UINib.init(nibName: "InvoiceListTblCell", bundle: nil), forCellReuseIdentifier: "InvoiceListTblCell")
        self.tblInvoiceList.register(UINib.init(nibName: "PaymentDetailTblCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailTblCell")
        pickerSuppliers.dataSource = self
        pickerSuppliers.delegate = self
        txtSupplierFilter.inputView = pickerSuppliers
        self.pickerViewSet(pickerSuppliers, txtSupplierFilter, btnDoneSelector: #selector(InvoicesVC.donePickerSupplier))
        pickerOutlets.dataSource = self
        pickerOutlets.delegate = self
        txtOutletFIlter.inputView = pickerSuppliers
        self.pickerViewSet(pickerOutlets, txtOutletFIlter, btnDoneSelector: #selector(InvoicesVC.donePickerOutlets))
        pickerStatus.dataSource = self
        pickerStatus.delegate = self
        txtStatusFilter.inputView = pickerStatus
        self.pickerViewSet(pickerStatus, txtStatusFilter, btnDoneSelector: #selector(InvoicesVC.donePickerStatus))
        self.isBottomRefresh = false
        self.page = 1
        self.tblInvoiceList.refreshControl?.hideWithAnimation(hidden: true)
        txtSearch.delegate = self
        txtSearch?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        pickerPaymentType.dataSource = self
        pickerPaymentType.delegate = self
        txtPaymentType.inputView = pickerPaymentType
        self.pickerViewSet(pickerPaymentType, txtPaymentType, btnDoneSelector: #selector(InvoicesVC.donePickerPaymentType))
        txtReceiveDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.tblPayments.tableFooterView = UIView()
        self.tblPayments.register(UINib.init(nibName: "PaymentTblCell", bundle: nil), forCellReuseIdentifier: "PaymentTblCell")
        self.tblPayments.refreshControl?.hideWithAnimation(hidden: true)
        self.isBottomRefreshPaymentList = false
        self.pagePaymentList = 1
        self.tblPayments.register(UINib.init(nibName: "PaymentDetailTblCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailTblCell")
        self.btnInvoices.isSelected = true
        self.btnPayments.isSelected = false
        self.btnInvoices.addBottomBorderWithColor(color: .forestGreen, width: 2)
        self.btnPayments.addBottomBorderWithColor(color: .forestGreen, width: 0)
        self.tblInvoiceList.backgroundColor = hexStringToUIColor(hex: "#F2F7FC")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.wsInvoicesBuyerList(status: "-1", supplierId: self.txtSupplierFilter.selectedID, OutletId: self.txtOutletFIlter.selectedID, search: "")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtReceiveDate.inputView as? UIDatePicker {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "YYYY-MM-dd"
            self.txtReceiveDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtReceiveDate.resignFirstResponder()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if txtSearch.text?.count == 0{
            performAction()
        }
    }
    func performAction() {
        if self.invoicePayment.selectedSegmentIndex == 0{
            self.arrDraftOrderResponse.removeAll()
            self.page = 1
            self.responseCount = 0
            self.isBottomRefresh = true
            strSearch = txtSearch.text ?? ""
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                wsInvoicesSupplierListURL(status: "-1", buyerId: "", OutletId: "", search: strSearch)
            } else {
                wsInvoicesBuyerList(status: "-1", supplierId: "", OutletId: "", search: strSearch)
            }
            
        } else {
            self.arrPaymentResponse.removeAll()
            self.pagePaymentList = 1
            self.responseCountPaymentList = 0
            self.isBottomRefreshPaymentList = true
            strSearch = txtSearch.text ?? ""
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                wsSupplierPaymentList(page: 0, buyerId: "", OutletId: "", search: strSearch)
            } else {
                wsBuyerPaymentList(page: 0, supplierId: "", OutletId: "", search: strSearch)
                
            }
        }
    }
    
    // MARK: - PickerView Methods
    
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
    @objc func donePickerPaymentType() {
        if txtPaymentType.text == "" {
            let objCommonModel = CommonModel(data : titlesDic[0] as NSDictionary)
            txtPaymentType.text = objCommonModel.strTitle
            txtPaymentType.selectedID = objCommonModel.strID
            
        }
        self.txtPaymentType.resignFirstResponder()
    }
    
    //This method is used for invoke the invoice buyer list API
    func wsInvoicesBuyerList(status: String,supplierId: String,OutletId: String,search: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        self.tblPayments.isHidden = true
        
        let postString = "start=0&end=0&page=\(page)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&supplier_id=\(supplierId)&from_date=&to_date=&status=\(status)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.InvoicesBuyerListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(InvoiceListResponseModel.self, from: responseData as! Data)
                        // success = true = 1 , unsuccess = false = 0
                        if dicResponseData.success == "1" {
                            self.vwBlur.isHidden = true
                            self.vwFilter.isHidden = true
                            self.page = 1
                            self.stackSelect.isHidden = true
                            
                            if self.isBottomRefresh == true {
                                self.tblInvoiceList.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrDraftOrderResponse.append(contentsOf: dicResponseData.data!.invoices)
                            } else  {
                                self.arrDraftOrderResponse = dicResponseData.data!.invoices
                                
                            }
                            self.isBottomRefresh = false
                            if self.arrDraftOrderResponse.count > 0{
                                
                                self.responseCount = dicResponseData.data!.totalCount
                                self.SearchView.isHidden = false
                                self.tblInvoiceList.isHidden = false
                                self.lblNoData.isHidden = true
                                self.imgInvoice.isHidden = true
                                self.lblNoInvoice.isHidden = true
                                self.lblYou.isHidden = true
                                self.btnOrder.isHidden = true
                                
                            } else {
                                self.tblInvoiceList.isHidden = true
                                self.SearchView.isHidden = true
                                self.lblNoData.isHidden = true
                                self.imgInvoice.isHidden = false
                                self.lblNoInvoice.isHidden = false
                                self.lblYou.isHidden = false
                                self.btnOrder.isHidden = false
                            }
                            
                            for i in self.arrDraftOrderResponse{
                                if i.status?.rawValue == "10.0" {
                                    self.arrTempCount.add(i)
                                }
                            }
                            if self.arrTempCount.count > 0{
                                self.stackSelect.isHidden = true
                            }
                            for i in self.arrDraftOrderResponse{
                                // self.arrSuppliers.append(i.supplierInfo)
                                self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                
                                self.arrSuppliers.append(["Title": i.supplierInfo.supplierName?.rawValue ?? ""  , "id" : i.supplierID ])
                                
                                self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                                
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
                            
                            
                            self.arrStatusDropdown = dicResponseData.data!.statusDropdown
                            self.pickerStatus.reloadAllComponents()
                        } else {
                            self.tblInvoiceList.isHidden = true
                            self.lblNoData.isHidden = true
                            self.SearchView.isHidden = true
                            self.imgInvoice.isHidden = false
                            self.lblNoInvoice.isHidden = false
                            self.lblYou.isHidden = false
                            self.btnOrder.isHidden = false
                        }
                        DispatchQueue.main.async {
                            self.tblInvoiceList.delegate = self
                            self.tblInvoiceList.dataSource = self
                            self.tblInvoiceList.reloadData()
                        }
                    }catch let err {
                        print("Session Error: ",err)
                        //   self.lblNoData.text = "No records found!"
                        self.lblNoData.isHidden = true
                        self.SearchView.isHidden = true
                        self.imgInvoice.isHidden = false
                        self.lblNoInvoice.isHidden = false
                        self.lblYou.isHidden = false
                        self.btnOrder.isHidden = false
                        self.tblInvoiceList.isHidden = true
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    //This method is used for invoke the Invoice supplier List API
    func wsInvoicesSupplierListURL(status: String,buyerId: String,OutletId: String,search: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        self.tblPayments.isHidden = true
        
        let postString = "start=0&end=0&page=\(page)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&buyer_id=\(buyerId)&from_date=&to_date=&status=\(status)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.InvoicesSupplierListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(InvoiceListResponseModel.self, from: responseData as! Data)
                        // success = true = 1 , unsuccess = false = 0
                        if dicResponseData.success == "1" {
                            self.vwBlur.isHidden = true
                            self.vwFilter.isHidden = true
                            self.page = 1
                            if self.isBottomRefresh == true {
                                self.tblInvoiceList.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrDraftOrderResponse.append(contentsOf: dicResponseData.data!.invoices)
                            } else  {
                                self.arrDraftOrderResponse = dicResponseData.data!.invoices
                                
                            }
                            self.isBottomRefresh = false
                            if self.arrDraftOrderResponse.count > 0{
                                self.responseCount = dicResponseData.data!.totalCount
                                self.SearchView.isHidden = false
                                self.tblInvoiceList.isHidden = false
                                self.lblNoData.isHidden = true
                                self.imgInvoice.isHidden = true
                                self.lblNoInvoice.isHidden = true
                                self.lblYou.isHidden = true
                                self.btnOrder.isHidden = true
                            } else {
                                self.tblInvoiceList.isHidden = true
                                self.lblNoData.isHidden = true
                                self.SearchView.isHidden = true
                                self.imgInvoice.isHidden = false
                                self.lblNoInvoice.isHidden = false
                                self.lblYou.isHidden = false
                                self.btnOrder.isHidden = false
                            }
                            
                            for i in self.arrDraftOrderResponse{
                                if i.status?.rawValue == "10.0" {
                                    self.arrTempCount.add(i)
                                }
                            }
                            if self.arrTempCount.count > 0{
                                self.stackSelect.isHidden = false
                            } else {
                                self.stackSelect.isHidden = true
                            }
                            for i in self.arrDraftOrderResponse{
                                self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                var buyerCompanyName = ""
                                if let companyNameText = i.buyerCompanyName {
                                    buyerCompanyName=companyNameText
                                }
                                self.arrSuppliers.append(["Title": buyerCompanyName , "id" : i.buyerID ])
                                
                                self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                                
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
                            self.arrStatusDropdown = dicResponseData.data!.statusDropdown
                            self.pickerStatus.reloadAllComponents()
                            
                        } else {
                            self.tblInvoiceList.isHidden = true
                            self.lblNoData.isHidden = true
                            self.SearchView.isHidden = true
                            self.imgInvoice.isHidden = false
                            self.lblNoInvoice.isHidden = false
                            self.lblYou.isHidden = false
                            self.btnOrder.isHidden = false
                        }
                        DispatchQueue.main.async {
                            self.tblInvoiceList.delegate = self
                            self.tblInvoiceList.dataSource = self
                            self.tblInvoiceList.reloadData()
                        }
                    }catch let err {
                        print("Session Error: ",err)
                        self.lblNoData.text = "No records found!"
                        self.lblNoData.isHidden = true
                        self.SearchView.isHidden = true
                        self.imgInvoice.isHidden = false
                        self.lblNoInvoice.isHidden = false
                        self.lblYou.isHidden = false
                        self.btnOrder.isHidden = false
                        self.tblInvoiceList.isHidden = true
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
    
    //This method is used for invoke the payment buyer list API
    func wsBuyerPaymentList(page:Int,supplierId: String,OutletId: String,search: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        //self.arrPaymentResponse.removeAll()
        self.tblInvoiceList.isHidden = true
        
        let postString = "start=0&end=0&page=\(page)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&supplier_id=\(supplierId)&from_date=&to_date="
        
        APICall().post(apiUrl: Constants.WebServiceURLs.PaymentBuyerListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(PaymentResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            self.vwBlur.isHidden = true
                            self.vwFilter.isHidden = true
                            
                            if self.isBottomRefresh == true {
                                self.tblPayments.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrPaymentResponse.append(contentsOf: [data][0].payments!)
                            } else  {
                                self.arrPaymentResponse = [data][0].payments!
                            }
                            self.isBottomRefresh = false
                            
                            
                            // self.arrPaymentResponse = [data][0].orders
                            if self.arrPaymentResponse.count > 0{
                                self.responseCount = [data][0].totalCount
                                for i in self.arrPaymentResponse{
                                    // self.arrSuppliers.append(i.supplierInfo)
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
                                self.SearchView.isHidden = false
                                self.tblPayments.isHidden = false
                                self.lblNoData.isHidden = true
                                self.imgInvoice.isHidden = true
                                self.lblNoInvoice.isHidden = true
                                self.lblYou.isHidden = true
                                self.btnOrder.isHidden = true
                                self.tblPayments.delegate = self
                                self.tblPayments.dataSource = self
                                self.tblPayments.reloadData()
                            } else {
                                //self.lblNoData.text = dicResponseData.message
                                self.tblPayments.isHidden = true
                                self.lblNoData.isHidden = true
                                self.SearchView.isHidden = true
                                self.imgInvoice.isHidden = false
                                self.lblNoInvoice.isHidden = false
                                self.lblYou.isHidden = false
                                self.btnOrder.isHidden = false
                            }
                        }
                        //self.showToast(message: dicResponseData.message)
                        
                        
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
    //This method is used for invoke the payment supplier list API
    func wsSupplierPaymentList(page:Int,buyerId: String,OutletId: String,search: String){
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        self.tblInvoiceList.isHidden = true
        
        //self.arrPaymentResponse.removeAll()
        let postString = "start=0&end=0&page=\(page)&sort_method=DESC&keyword=\(search)&sort_by=&outlet_id=\(OutletId)&buyer_id=\(buyerId)&from_date=&to_date="
        
        APICall().post(apiUrl: Constants.WebServiceURLs.PaymentSupplierListURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(PaymentResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            self.vwBlur.isHidden = true
                            self.vwFilter.isHidden = true
                            
                            if self.isBottomRefresh == true {
                                self.tblPayments.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrPaymentResponse.append(contentsOf: [data][0].payments!)
                            } else  {
                                self.arrPaymentResponse = [data][0].payments!
                            }
                            self.isBottomRefresh = false
                            
                            if self.arrPaymentResponse.count > 0{
                                self.responseCount = [data][0].totalCount
                                
                                for i in self.arrPaymentResponse{
                                    // self.arrSuppliers.append(i.supplierInfo)
                                    self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                    var buyerCompanyName = ""
                                    if let companyNameText = i.buyerCompanyName {
                                        buyerCompanyName=companyNameText
                                    }
                                    self.arrSuppliers.append(["Title": buyerCompanyName  , "id" : i.buyerID ])
                                    
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
                                
                                
                                self.tblPayments.isHidden = false
                                self.SearchView.isHidden = false
                                self.lblNoData.isHidden = true
                                self.imgInvoice.isHidden = true
                                self.lblNoInvoice.isHidden = true
                                self.lblYou.isHidden = true
                                self.btnOrder.isHidden = true
                                self.tblPayments.delegate = self
                                self.tblPayments.dataSource = self
                                self.tblPayments.reloadData()
                            } else {
                                self.tblPayments.isHidden = true
                                self.lblNoData.isHidden = true
                                self.SearchView.isHidden = true
                                self.imgInvoice.isHidden = false
                                self.lblNoInvoice.isHidden = false
                                self.lblYou.isHidden = false
                                self.btnOrder.isHidden = false
                                
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
    //This method is used for invoke the paynow API
    func wsPayNow(invoiceId: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            
            return
        }
        
        let postString = "invoice_id=\(self.selectedInvoiceID)&date=\(self.txtReceiveDate.text ?? "")&amount=\(self.txtReceiveAmount.text ?? "")&type=\(self.txtPaymentType.text ?? "")&remarks=\(self.txtRemark.text ?? "")&transaction_id=\(self.txtTransactionID.text ?? "")"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.PayNowURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        self.showToast(message: dicResponseData.message)
                        
                        self.vwBlur.isHidden = true
                        self.vwReceivePayment.isHidden = true
                        self.wsInvoicesBuyerList(status: "-1", supplierId: self.txtSupplierFilter.selectedID, OutletId: self.txtOutletFIlter.selectedID, search: "")
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
    //This method is used for invoke the invoice status update API
    func wsUpdateStatusInvoice(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.InvoicesStatusUpdateURL
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
        
        var params :[String: Any]?
        params = ["invoice_id" : arrID, Constants.WebServiceParameter.paramStatus : 20, "notes" : self.txtNotes.text ?? ""]
        
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params as Any, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
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
                            //success = true = 1 , unsuccess = false = 0
                            if strStatus == "1" {
                                DispatchQueue.main.async {
                                    self.arrTempID.removeAllObjects()
                                    self.showToast(message:dictResponse.message)
                                    self.vwBlur.isHidden = true
                                    self.vwNotes.isHidden = true
                                    self.arrDraftOrderResponse.removeAll()
                                    if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                                        self.wsInvoicesSupplierListURL(status: "-1", buyerId: self.txtSupplierFilter.selectedID, OutletId: self.txtOutletFIlter.selectedID, search: "")
                                    } else {
                                        
                                        self.wsInvoicesBuyerList(status: "-1", supplierId: self.txtSupplierFilter.selectedID, OutletId: self.txtOutletFIlter.selectedID, search: "")
                                        
                                    }                                }
                                
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
    
    @IBAction func Btnclose(_ sender: Any) {
        filterBGView.isHidden = true
        vwDelete.isHidden   = true
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.vwFilter.isHidden = true
        self.vwBlur.isHidden = true
    }
    @IBAction func BtnOrderNowAct(_ sender: Any) {
        let SearchViewController = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        SearchViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(SearchViewController, animated: true)
    }
    
    
    // End code for filter popup
    @IBAction func btnPlacedOrderAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func filterapiCallingOfBuyersSupliersOnSelectedIndex(){
        self.lblNoData.isHidden  = true
        self.imgInvoice.isHidden = true
        self.lblNoInvoice.isHidden = true
        self.lblYou.isHidden = true
        self.btnOrder.isHidden = true
        self.SearchView.isHidden = false
        self.SearchView.isHidden = false
        self.filterBGView.isHidden = true
        self.filterview.isHidden   = true
        self.txtSearch.resignFirstResponder()
        //Buyer = 2 , supplier = 1
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            if self.selectedIndexPath ==  IndexPath(row: 0, section: 0) {
                self.arrOrderResponse.removeAll()
                self.wsSupplierOrders(status: statusId, buyerId: supplierId, OutletId: outletId, search: searchedText)
            } else{
                self.arrOrderResponse.removeAll()
                self.wsSupplierOrders(status: statusId, buyerId: supplierId, OutletId: outletId, search: "")
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
                self.wsInvoicesBuyerList(status: "-1", supplierId: supplierId , OutletId: "" ,search: "")
                
            }
        }
    }
    @IBAction func showResultAction(_ sender: Any) {
        filterapiCallingOfBuyersSupliersOnSelectedIndex()
    }
    //This method is used for invoke the Draft Order API
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
                                self.arrDraftOrderResponse1.append(contentsOf: [data][0].draftOrders)
                            } else  {
                                self.arrDraftOrderResponse1 = [data][0].draftOrders
                            }
                            self.isBottomRefreshDraftOrder = false
                            ////  self.arrDraftOrderResponse = [data][0].draftOrders
                            
                            if self.arrDraftOrderResponse.count > 0{
                                self.responseCountDraftOrder = [data][0].totalCount
                                self.tblInvoiceList.delegate    = self
                                
                                self.tblInvoiceList.dataSource = self
                                self.tblInvoiceList.reloadData()
                            } else {
                                //self.lblNoData.text = dicResponseData.message
                                self.tblInvoiceList.isHidden = true
                                self.lblNoData.isHidden = true
                                self.SearchView.isHidden = true
                                self.imgInvoice.isHidden = false
                                self.lblNoInvoice.isHidden = false
                                self.lblYou.isHidden = false
                                self.btnOrder.isHidden = false
                            }
                            
                            
                            for i in self.arrDraftOrderResponse{
                                // self.arrSuppliers.append(i.supplierInfo)
                                self.arrSuppliers.append(["Title": i.supplierInfo.supplierName?.rawValue ?? ""  , "id" : i.supplierID ])
                                //       self.arrOutletList.append(["Title": i.outletInfo.name ?? ""  , "id" : i.outletID ])
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
    //This method is used for invoke the order supplier list API
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
                            // self.arrOrderResponse = [data][0].orders
                            print("orders list::",[data][0].orders)
                            if self.isBottomRefresh == true {
                                self.tblInvoiceList.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrOrderResponse.append(contentsOf: [data][0].orders)
                            } else  {
                                self.arrOrderResponse = [data][0].orders
                            }
                            self.isBottomRefresh = false
                            
                            if self.arrOrderResponse.count > 0{
                                self.responseCount = [data][0].totalCount
                                
                                for i in self.arrOrderResponse{
                                    // self.arrSuppliers.append(i.supplierInfo)
                                    self.arrSuppliers.append(["Title": "All"  , "id" : "" ])
                                    var buyerCompanyName = ""
                                    if let companyNameText = i.buyerCompanyName {
                                        buyerCompanyName=companyNameText
                                    }
                                    self.arrSuppliers.append(["Title": buyerCompanyName  , "id" : i.buyerID ])
                                    
                                    self.arrOutletList.append(["Title": "All"  , "id" : "" ])
                                    //      self.arrOutletList.append(["Title": i.outletInfo.name  , "id" : i.outletID ])
                                    
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
                                self.tblInvoiceList.isHidden = false
                                self.tblInvoiceList.delegate = self
                                self.tblInvoiceList.dataSource = self
                                self.tblInvoiceList.reloadData()
                            } else {
                                self.lblNoData.text = dicResponseData.message
                                self.tblInvoiceList.isHidden = true
                                self.lblNoData.isHidden = true
                                self.SearchView.isHidden = true
                                self.imgInvoice.isHidden = false
                                self.lblNoInvoice.isHidden = false
                                self.lblYou.isHidden = false
                                self.btnOrder.isHidden = false
                            }
                        }
                        //self.showToast(message: dicResponseData.message)
                        
                        
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
    
    @IBAction func btnFilterAct(_ sender: Any) {
        outletCollectionView.isHidden = true
        statusCollectionView.isHidden = true
        self.filterview.isHidden = false
        self.filterBGView.isHidden  = false
        //   self.SearchView.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
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
        self.statusCollectionViewHeightConstraint.constant = height > 240 ? height + 15 : height + 10
        self.statusCollectionView.layoutIfNeeded()
        self.statusCollectionView.reloadData()
        
    }
    @IBAction func BtnClearAll(_ sender: Any) {
        supplierIndexPath = nil
        outletIndexPath   = nil
        statusIndexPath   = nil
        supplierCollectionView.reloadData()
        outletCollectionView.reloadData()
        statusCollectionView.reloadData()
        self.arrPaymentResponse.removeAll()
        self.filterview.isHidden = false
        self.filterBGView.isHidden  = false
        
    }
    
    
    @IBAction func btnCloseFilterAct(_ sender: Any) {
        self.filterview.isHidden = true
        self.filterBGView.isHidden  = true
        //    self.SearchView.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    @IBAction func btnCloseReceivePymentAct(_ sender: Any) {
        self.vwBlur.isHidden = true
        self.vwReceivePayment.isHidden = true
    }

    @IBAction func btnCancelReceiveAct(_ sender: Any) {
        self.vwBlur.isHidden = true
        self.vwReceivePayment.isHidden = true
    }
    @IBAction func btnCloseNotesAct(_ sender: Any) {
        self.vwBlur.isHidden = true
        self.vwNotes.isHidden = true
    }
    
    @IBAction func btnCancelNotesAct(_ sender: Any) {
        self.vwBlur.isHidden = true
        self.vwNotes.isHidden = true
    }
    @IBAction func btnSubmitNotesAct(_ sender: Any) {
        if Validation().isEmpty(txtField: txtNotes.text!){
            showToast(message:Constants.AlertMessage.notes)
        } else {
            wsUpdateStatusInvoice()
        }
    }
    @IBAction func supplierDropDown(_ sender: Any) {
        if supplierDropDown.isSelected{
            //            ios-arrow-down
            supplierDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            supplierCollectionView.isHidden = false
        }else{
            supplierDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            supplierCollectionView.isHidden = true
        }
        supplierDropDown.isSelected = !supplierDropDown.isSelected
    }
    
    @IBAction func outletDropDown(_ sender: Any) {
        if outletDropDown.isSelected{
            outletDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            outletCollectionView.isHidden = false
        }else{
            outletDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            outletCollectionView.isHidden = true
        }
        outletDropDown.isSelected = !outletDropDown.isSelected
    }
    
    @IBAction func statusDropDown(_ sender: Any) {
        if statusDropDown.isSelected{
            statusDropDown.setImage(UIImage(named: "menuDownArrow"), for: .normal)
            statusCollectionView.isHidden = false
        }else{
            statusDropDown.setImage(UIImage(named: "menuUpArrow"), for: .normal)
            statusCollectionView.isHidden = true
        }
        statusDropDown.isSelected = !statusDropDown.isSelected
    }
    
    @IBAction func btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated:true)
    }
    
    @IBAction func btnBackAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated:true)
    }
}
//Avinash added code for Filter button
extension InvoicesVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
            txtSearch.text = ""
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
// MARK: - UITableView Delegate Methods

extension InvoicesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnInvoices.isSelected{
            return self.arrDraftOrderResponse.count
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.invoicePayment.selectedSegmentIndex == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceListTblCell") as? InvoiceListTblCell
            cell?.lblInvoiceID.text = "\(self.arrDraftOrderResponse[indexPath.row].uniqueName)"
            cell?.ButtonDelete.tag = indexPath.row
            cell?.ButtonDelete.addTarget(self, action: #selector(dropdown(_:)), for: .touchUpInside)
            if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                cell?.lblSupplierName.text = "\(self.arrDraftOrderResponse[indexPath.row].supplierInfo.supplierName?.rawValue ?? "")"
               cell?.lblremainingAmountTitle.text = "Remaining"
                cell?.btnPayNow.setTitle("Received Amount", for: .normal)
                cell?.btnMarkAsPaidOut.isHidden = true

                if self.arrDraftOrderResponse[indexPath.row].status?.rawValue == "10.0" {
                      cell?.btnMarkAsPaidOut.isHidden = true
                    cell?.btnSelect.isHidden = false
                } else {
                     cell?.btnMarkAsPaidOut.isHidden = true
                    cell?.btnSelect.isHidden = true

                }
                if arrTempID.contains(self.arrDraftOrderResponse[indexPath.row].id){
                    cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                } else {
                    cell?.btnSelect.setImage(UIImage(named: "ic_uncheck"), for: .normal)
                }
                cell?.btnSelect.tag = (indexPath.section * 1000) + indexPath.row
                cell?.btnSelect.addTarget(self , action:#selector(btnFavClicked(sender:)), for: .touchUpInside)
            } else {
                cell?.lblSupplierName.text = "\(self.arrDraftOrderResponse[indexPath.row].supplierInfo.supplierName?.rawValue ?? "")"
                cell?.lblremainingAmountTitle.text = "Remaining"
                cell?.btnPayNow.setTitle("Pay Now", for: .normal)
                cell?.btnMarkAsPaidOut.isHidden = false
                cell?.btnSelect.isHidden = true
            }
            cell?.lblRemainingPendingAmount.text = "AED \(self.arrDraftOrderResponse[indexPath.row].pendingAmount?.rawValue ?? "0")"
            cell?.lblInvoiceAmount.text = "AED \(self.arrDraftOrderResponse[indexPath.row].totalPayableAmount?.rawValue ?? "0") "

            cell?.lblDate.text = "Get it by \(self.arrDraftOrderResponse[indexPath.row].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "MMM dd"))"
            cell?.lblStatus.text = self.arrDraftOrderResponse[indexPath.row].statusName
            cell?.btnPayNow.tag = indexPath.row
            cell?.btnPayNow.addTarget(self , action:#selector(btnPayNowClicked), for: .touchUpInside)

            cell?.btnPayments.underline()
            cell?.btnPayments.tag = indexPath.row
            cell?.btnPayments.addTarget(self , action:#selector(btnPaymentsClicked), for: .touchUpInside)
            if self.arrDraftOrderResponse[indexPath.row].status?.rawValue == "10.0" {
                cell?.btnPayNow.isHidden = false
                cell?.btnPayments.isHidden = true
                cell?.lblStatus.backgroundColor = hexStringToUIColor(hex: "#E73B42")
                cell?.lblInvoiceAmount.textColor = hexStringToUIColor(hex: "#E73B42")
            } else {
                cell?.btnPayNow.isHidden = true
                cell?.lblStatus.backgroundColor = hexStringToUIColor(hex: "#36B152")
                cell?.lblStatus.text = "paid"
                cell?.btnMarkAsPaidOut.isHidden = true
                cell?.btnPayments.isHidden = false
                cell?.lblInvoiceAmount.textColor = hexStringToUIColor(hex: "#153E73")
            }
            cell?.btnMarkAsPaidOut.tag = indexPath.row
            cell?.btnMarkAsPaidOut.addTarget(self , action:#selector(btnMarkAsPaidClicked), for: .touchUpInside)
            if self.arrDraftOrderResponse[indexPath.row].payments!.count > 0{
                cell?.btnPayments.isHidden = false
                cell?.btnMarkAsPaidOut.isHidden = true
            } else {
                cell?.btnPayments.isHidden = true
            }
            if indexPath.row % 2 == 0{
                cell?.backgroundColor = .white
            }
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailTblCell", for: indexPath as IndexPath) as? PaymentDetailTblCell

            cell?.lblOutlet.text = "Outlet: \(self.arrPaymentResponse[indexPath.section].outletInfo?.name ?? "---")"
            cell?.lblTransactionID.text = "Transaction Id : \(self.arrPaymentResponse[indexPath.section].transactionId?.rawValue ?? "---")"

            cell?.lblRemarks.text = self.arrPaymentResponse[indexPath.section].remarks

            if indexPath.section % 2 == 0{
                cell?.vwBg.backgroundColor = .white
            }
            return cell ?? PaymentDetailTblCell()
        }
    }
    @objc func dropdown(_ sender: UIButton){
        filterBGView.isHidden = false
        vwDelete.isHidden   = false
  
    }
    @objc func btnFavClicked(sender:UIButton) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            let cell: InvoiceListTblCell? = (self.tblInvoiceList.cellForRow(at: IndexPath(row: sender.tag % 1000, section: sender.tag / 1000)) as? InvoiceListTblCell)
            
            let currentImage: UIImage? = cell?.btnSelect.image(for: .normal)
            if currentImage?.isEqual(UIImage(named: "ic_checkbox")) == false {
                cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tblInvoiceList)
                self.indexPath = self.tblInvoiceList.indexPathForRow(at: buttonPosition)!
                arrTempID.add(self.arrDraftOrderResponse[self.indexPath.row].id)
            } else  {
                cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tblInvoiceList)
                self.indexPath = self.tblInvoiceList.indexPathForRow(at: buttonPosition)!
                arrTempID.remove(self.arrDraftOrderResponse[self.indexPath.row].id)
            }
            if arrTempID.count == self.arrTempCount.count{
                self.btnSelectAllOut.setImage(UIImage(named: "ic_checkbox"), for: .normal)
            } else {
                self.btnSelectAllOut.setImage(UIImage(named: "ic_uncheck"), for: .normal)
                
            }
            self.tblInvoiceList.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.invoicePayment.selectedSegmentIndex == 0{
            if let objInvoiceDetailVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "InvoiceDetailsVCNew") as? InvoiceDetailsVCNew {
                objInvoiceDetailVC.invoiceId = self.arrDraftOrderResponse[indexPath.row].id
                self.navigationController?.pushViewController(objInvoiceDetailVC, animated: true)
            }
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            
        }
    }
    @objc func btnPayNowClicked(sender:UIButton) {
      self.selectedInvoiceID = self.arrDraftOrderResponse[sender.tag].id
    }
    
    @objc func btnMarkAsPaidClicked(sender:UIButton) {
        self.selectedInvoiceID = self.arrDraftOrderResponse[sender.tag].id
        self.vwBlur.isHidden = false
        self.vwNotes.isHidden = false
        self.txtNotes.text = ""
    }
    @objc func btnPaymentsClicked(sender:UIButton) {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "PaymentHistoryVC") as? PaymentHistoryVC
        controller?.isHistory = false
        controller?.arrPayment = self.arrDraftOrderResponse[sender.tag].payments!
        let sheetController = SheetViewController(controller: controller!, sizes: [SheetSize.fixed(CGFloat((100 + (118 * self.arrDraftOrderResponse[sender.tag].payments!.count))))])

        self.present(sheetController, animated: false, completion: nil)
    }
}
extension InvoicesVC: ExpyTableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.invoicePayment.selectedSegmentIndex == 0{
            isBottomRefresh = true
            loadMoreFromBottom()
        } else {
            isBottomRefreshPaymentList = true
            loadMoreFromBottom()
        }
    }
    func loadMoreFromBottom() {
        if self.invoicePayment.selectedSegmentIndex == 0{
            if responseCount > self.arrDraftOrderResponse.count{
                page = page + 1
                self.tblInvoiceList.refreshControl?.showWithAnimation(onView: self.tblInvoiceList, animation: .bottom)
                if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                    wsInvoicesSupplierListURL(status: "-1", buyerId: "", OutletId: "", search: strSearch)
                } else {
                    wsInvoicesBuyerList(status: "-1", supplierId: "", OutletId: "", search: strSearch)
                }
            }
            
        } else {
            if responseCountPaymentList > self.arrPaymentResponse.count{
                pagePaymentList = pagePaymentList + 1
                self.tblPayments.refreshControl?.showWithAnimation(onView: self.tblPayments, animation: .bottom)
                if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
                    wsSupplierPaymentList(page: pagePaymentList, buyerId: "", OutletId: "", search: strSearch)
                } else {
                    wsBuyerPaymentList(page: pagePaymentList, supplierId: "", OutletId: "", search: strSearch)
                }
                
            }
        }
    }
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        objPaymentTblCell = tableView.dequeueReusableCell(withIdentifier: "PaymentTblCell")! as? PaymentTblCell
        objPaymentTblCell?.lblInvoiceNum.text = self.arrPaymentResponse[section].invoiceUniqueName
        objPaymentTblCell?.lblAmount.text = "AED \(self.arrPaymentResponse[section].amount?.rawValue ?? "0")"
        objPaymentTblCell?.lblSupplier.text = "Supplier: \(self.arrPaymentResponse[section].supplierInfo?.supplierName?.rawValue ?? "---")"
        
        objPaymentTblCell?.lblDate.text = self.arrPaymentResponse[section].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy hh:mm a")
        
        objPaymentTblCell?.lblType.text = self.arrPaymentResponse[section].type
        
        if section % 2 == 0{
            objPaymentTblCell?.vwBg.backgroundColor = .white
        }
        return objPaymentTblCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        
        return ExpyTableViewDefaultValues.expandableStatus
    }
}
extension InvoicesVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        if invoicePayment.selectedSegmentIndex == 0{
            return 1
        } else {
            return self.arrPaymentResponse.count
        }
    }
}

extension InvoicesVC: ExpyTableViewDelegate {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        print("Current state: \(state)")
    }
}

// MARK: - Pickerview Methods

extension InvoicesVC : UIPickerViewDelegate,UIPickerViewDataSource{
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
        case pickerPaymentType:
            let objCommonModel = CommonModel(data : titlesDic[row] as NSDictionary)
            txtPaymentType.text = objCommonModel.strTitle
            if objCommonModel.strTitle == "Cheque" {
                self.vwTransactionId.isHidden = false
            } else  if objCommonModel.strTitle == "Cash" || objCommonModel.strTitle == "Others" {
                self.vwTransactionId.isHidden = true
            } else  {
                self.vwTransactionId.isHidden = false
            }
        default:
            let objCommonModel = CommonModel(data : arrSuppliers[row] as NSDictionary)
            
            txtSupplierFilter.text = objCommonModel.strTitle
            txtSupplierFilter.selectedID = objCommonModel.strID
        }
    }
}
extension InvoicesVC {
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
