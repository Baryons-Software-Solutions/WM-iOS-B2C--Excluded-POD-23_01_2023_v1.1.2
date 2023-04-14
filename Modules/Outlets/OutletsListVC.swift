//
//  OutletsListVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 21/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class OutletsListVC: UIViewController {
    
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var lblAddsome: UILabel!
    @IBOutlet weak var vwDelete: UIView!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var imgaddress: UIImageView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var filterBG: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var BtnDelete: UIButton!
    @IBOutlet weak var Btnclose: UIButton!
    @IBOutlet weak var vwSuccess: UIView!
    
    //MARK: - Variable Declaration
    var selectedIndexPathArray       = [IndexPath]()
    var selectedIndexPath            = IndexPath()
    var imageData                    : Data!
    var objWarehouseOutletListTblCell: WarehouseOutletListTblCell?
    var arrWarehouseList             = [WarehouseListResponse]()
    var arrOutletList                = [OutletListResponse]()
    var arrProfile                   = [ProfileResponse]()
    var indexPath                    = IndexPath()
    var arrTempID                    = NSMutableArray()
    var strSearch                    = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndexPathAddress = IndexPath(row: 0, section: 0)
        imgaddress.isHidden = true
        btnAddress.isHidden = true
        lblAddsome.isHidden = true
        lblNoRecord.isHidden = true
        self.btnAddress.cornerRadius = 10
        self.searchView.cornerRadius = 10
        self.BtnDelete.cornerRadius = 10
        self.Btnclose.cornerRadius = 10
        self.vwSuccess.cornerRadius = 10
        self.vwDelete.cornerRadius = 10
        filterBG.isHidden = true
        vwDelete.isHidden   = true
        vwSuccess.isHidden   = true
        self.initialization()
        
        // Do any additional setup after loading the view.
    }
    //MARK: - Initialization
    
    func initialization(){
        tabBarController?.tabBar.isHidden = true
        txtSearch.delegate = self
        txtSearch?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.tblList.register(UINib.init(nibName: "WarehouseOutletListTblCell", bundle: nil), forCellReuseIdentifier: "WarehouseOutletListTblCell")
        self.tblList.register(UINib.init(nibName: "AddAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddAddressTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
        } else {
            hideLoader()
            self.wsOutlet()
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if txtSearch.text?.count == 0{
            performAction()
        }
    }
    func performAction() {
        strSearch = txtSearch.text ?? ""
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            
        } else {
            self.wsOutlet()
        }
        //action events
    }
    //This method are used for invoke the outlets API 
    func wsOutlet(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        paramDic [Constants.WebServiceParameter.paramBuyerId] = (USERDEFAULTS.getDataForKey(.user_type_id)) as AnyObject
        let paramStr = "\(Constants.WebServiceParameter.paramSort)=ASC&\(Constants.WebServiceParameter.paramSortBy)=outlet_name&\(Constants.WebServiceParameter.paramPage)=\("")&\(Constants.WebServiceParameter.paramKeyword)=\(strSearch)&\(Constants.WebServiceParameter.paramBuyerId)=\((USERDEFAULTS.getDataForKey(.user_type_id)))"
        hideLoader()
        APICall().post(apiUrl: Constants.WebServiceURLs.outletListURL, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async { [self] in
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(OutletListResponseModel.self, from: responseData as! Data)
                        backGroundview.isHidden       = true
                        self.filterBG.isHidden        = true
                        if dicResponseData.success == "1" {
                            self.arrOutletList = dicResponseData.data!
                            self.tblList.delegate = self
                            self.tblList.dataSource = self
                            if self.arrOutletList.count > 0{
                                self.lblNodata.isHidden = true
                                self.lblNoRecord.isHidden = true
                                self.lblAddsome.isHidden = true
                                self.btnAddress.isHidden = true
                                self.imgaddress.isHidden = true
                                self.searchView.isHidden = false
                                self.tblList.isHidden = false
                                self.tblList.reloadData()
                            } else {
                                self.lblNodata.isHidden = true
                                self.lblNoRecord.isHidden = false
                                self.lblAddsome.isHidden = false
                                self.btnAddress.isHidden = false
                                self.imgaddress.isHidden = false
                                self.tblList.isHidden = true
                                self.searchView.isHidden = true
                                self.lblNodata.text = dicResponseData.message
                            }
                        } else {
                            self.lblNodata.isHidden = true
                            self.lblNoRecord.isHidden = false
                            self.lblAddsome.isHidden = false
                            self.btnAddress.isHidden = false
                            self.imgaddress.isHidden = false
                            self.searchView.isHidden = true
                            self.tblList.isHidden = true
                            self.lblNodata.text = dicResponseData.message
                        }
                        if self.arrOutletList.count == 1{
                            self.objWarehouseOutletListTblCell?.DeleteButton.isHidden = true
                        }else{
                            self.objWarehouseOutletListTblCell?.DeleteButton.isHidden = false
                        }
                        
                    }catch let err {
                        backGroundview.isHidden       = true
                        self.filterBG.isHidden        = true
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
                hideLoader()
            }
        }
    }
    //This Methods are used for delete the address
    func wsChangeStatusOutlet(status: Int){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let session = URLSession.shared
        let url = Constants.WebServiceURLs.changeStatusOutletURL
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
        params = [Constants.WebServiceParameter.paramId : arrID, Constants.WebServiceParameter.paramStatus : status]
        
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
                            let dictResponse = try decoder.decode(ChangeStatusResponseModel.self, from: data )
                            let strStatus = dictResponse.success
                            if strStatus == "1" {
                                DispatchQueue.main.async {
                                    self.arrTempID.removeAllObjects()
                                    self.showCustomAlert(message: "Address has been removed successfully")
                                    self.wsOutlet()
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.showCustomAlert(message: dictResponse.message,isSuccessResponse: false)
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
    @IBAction func btnDelete(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            self.arrTempID.add(self.arrWarehouseList[(sender as AnyObject).tag].id)
        } else {
            self.arrTempID.add(self.arrOutletList[(sender as AnyObject).tag].id)
            self.wsChangeStatusOutlet(status: 2)
        }
        filterBG.isHidden = true
        vwDelete.isHidden   = true
    }
    
    @IBAction func btnclose(_ sender: Any) {
        filterBG.isHidden = true
        vwDelete.isHidden   = true
    }
    
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnAddPrroducts(_ sender: Any) {
        let objAddWarehouseVC = mainStoryboard.instantiateViewController(withIdentifier: "AddOutletWarehouseVC") as! AddOutletWarehouseVC
        self.navigationController?.pushViewController(objAddWarehouseVC, animated: true)
    }
    
}
// MARK: - UITableView Delegate Methods
extension OutletsListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            return self.arrWarehouseList.count
        } else {
            return self.arrOutletList.count + 1
        }
    }
    @objc func btnEditClicked(sender:UIButton) {
        if let objAddWarehouseVC = mainStoryboard.instantiateViewController(withIdentifier: "AddOutletWarehouseVC") as? AddOutletWarehouseVC {
            objAddWarehouseVC.arrDetail = [self.arrOutletList[sender.tag]]
            objAddWarehouseVC.titleName  = "Edit Address"
            self.navigationController?.pushViewController(objAddWarehouseVC, animated: true)
        }
    }
    @objc func addAddress(sender:UIButton) {
        let objAddWarehouseVC = mainStoryboard.instantiateViewController(withIdentifier: "AddOutletWarehouseVC") as! AddOutletWarehouseVC
        self.navigationController?.pushViewController(objAddWarehouseVC, animated: true)
        
    }
    
    @objc func btnFavClicked(sender:UIButton) {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            let cell: WarehouseOutletListTblCell? = (self.tblList.cellForRow(at: IndexPath(row: sender.tag % 1000, section: sender.tag / 1000)) as? WarehouseOutletListTblCell)
            let currentImage: UIImage? = cell?.btnSelect.image(for: .normal)
            if currentImage?.isEqual(UIImage(named: "ic_checkbox")) == false {
                cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tblList)
                self.indexPath = self.tblList.indexPathForRow(at: buttonPosition)!
                arrTempID.add(self.arrWarehouseList[self.indexPath.row].id)
            } else  {
                cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tblList)
                self.indexPath = self.tblList.indexPathForRow(at: buttonPosition)!
                arrTempID.remove(self.arrWarehouseList[self.indexPath.row].id)
            }
            self.tblList.reloadRows(at: [self.indexPath], with: .none)
            print(arrTempID)
        } else {
            let cell: WarehouseOutletListTblCell? = (self.tblList.cellForRow(at: IndexPath(row: sender.tag % 1000, section: sender.tag / 1000)) as? WarehouseOutletListTblCell)
            
            let currentImage: UIImage? = cell?.btnSelect.image(for: .normal)
            if currentImage?.isEqual(UIImage(named: "ic_checkbox")) == false {
                cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tblList)
                self.indexPath = self.tblList.indexPathForRow(at: buttonPosition)!
                arrTempID.add(self.arrOutletList[self.indexPath.row].id)
            } else  {
                cell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
                
                let buttonPosition = sender.convert(CGPoint.zero, to: self.tblList)
                self.indexPath = self.tblList.indexPathForRow(at: buttonPosition)!
                arrTempID.remove(self.arrOutletList[self.indexPath.row].id)
            }
            
            self.tblList.reloadRows(at: [self.indexPath], with: .none)
            print(arrTempID)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            objWarehouseOutletListTblCell?.imgWidthConstraint.constant = 0
            objWarehouseOutletListTblCell?.lblName.text = self.arrWarehouseList[indexPath.row].warehouseName
            objWarehouseOutletListTblCell?.DeleteButton.tag = indexPath.row
            objWarehouseOutletListTblCell?.DeleteButton.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
            if self.arrOutletList.count == 1{
                self.objWarehouseOutletListTblCell?.DeleteButton.isHidden = true
            }else{
                self.objWarehouseOutletListTblCell?.DeleteButton.isHidden = false
            }
            
            let strTermAndCondition = "\(self.arrWarehouseList[indexPath.row].address),\(self.arrWarehouseList[indexPath.row].area ?? ""),\(self.arrWarehouseList[indexPath.row].city ?? ""),\(self.arrWarehouseList[indexPath.row].country ?? "")\n\(self.arrWarehouseList[indexPath.row].createdBy) \(self.arrWarehouseList[indexPath.row].email)\n\(self.arrWarehouseList[indexPath.row].phoneNumber)"
            let attributedString = NSMutableAttributedString(string: strTermAndCondition, attributes: [
                .font: objWarehouseOutletListTblCell?.lblAdress.font!,
                .foregroundColor: UIColor.darkGray
            ])
            let rangeName = (strTermAndCondition as NSString).range(of: self.arrWarehouseList[indexPath.row].createdBy)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: rangeName)
            attributedString.addAttribute(NSAttributedString.Key.font, value: font(name: .robotoMedium, size: 11.0), range: rangeName)
            let range1 = (strTermAndCondition as NSString).range(of: self.arrWarehouseList[indexPath.row].email)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
            attributedString.addAttribute(NSAttributedString.Key.font, value: font(name: .robotoRegular, size: 11.0), range: range1)
            let range2 = (strTermAndCondition as NSString).range(of: self.arrWarehouseList[indexPath.row].phoneNumber)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range2)
            attributedString.addAttribute(NSAttributedString.Key.font, value: font(name: .robotoRegular, size: 11.0), range: range2)
            objWarehouseOutletListTblCell?.lblAdress.attributedText = attributedString
            
            if arrTempID.contains(self.arrWarehouseList[indexPath.row].id){
                objWarehouseOutletListTblCell?.btnSelect.setImage(UIImage(named: "ic_checkbox"), for: .normal)
            } else {
                objWarehouseOutletListTblCell?.btnSelect.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            }
            objWarehouseOutletListTblCell?.btnSelect.setTitle(self.arrWarehouseList[indexPath.row].statusName, for: .normal)
            objWarehouseOutletListTblCell?.btnSelect.tag = (indexPath.section * 1000) + indexPath.row
            objWarehouseOutletListTblCell?.btnSelect.addTarget(self , action:#selector(btnFavClicked(sender:)), for: .touchUpInside)
            objWarehouseOutletListTblCell?.DeleteButton.isHidden = true
            
        } else {
            print(indexPath.row)
            if indexPath.row  == self.arrOutletList.count{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddAddressTableViewCell", for: indexPath as IndexPath) as? AddAddressTableViewCell
                cell?.addNewAddressButton.tag = indexPath.row
                cell?.addNewAddressButton.addTarget(self , action:#selector(addAddress(sender:)), for: .touchUpInside)
                return cell ?? UITableViewCell()
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarehouseOutletListTblCell", for: indexPath as IndexPath) as? WarehouseOutletListTblCell
                if self.arrOutletList[indexPath.row].outletLogo != nil && self.arrOutletList[indexPath.row].outletLogo != "" {
                } else {
                    
                }
                cell?.lblName.text = self.arrOutletList[indexPath.row].outletName
                cell?.lblAdress.text = "\(self.arrOutletList[indexPath.row].address),\(self.arrOutletList[indexPath.row].area),\(self.arrOutletList[indexPath.row].city),\(self.arrOutletList[indexPath.row].country)"
                cell?.DeleteButton.tag = indexPath.row
                cell?.DeleteButton.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
                cell?.editbutton.tag = indexPath.row
                cell?.editbutton.addTarget(self , action:#selector(btnEditClicked), for: .touchUpInside)
                return cell ?? UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    @objc func btnDeleteClicked(sender:UIButton) {
        filterBG.isHidden = false
        vwDelete.isHidden   = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - UITextField Delegate Methods

extension OutletsListVC {
    
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

