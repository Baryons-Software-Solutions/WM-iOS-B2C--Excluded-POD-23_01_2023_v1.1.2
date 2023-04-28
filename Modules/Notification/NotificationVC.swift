//
//  NotificationVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 04/01/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//

import UIKit
import ExpyTableView
class NotificationVC: UIViewController {
    
    @IBOutlet weak var NoNotificationYet: UILabel!
    @IBOutlet weak var lblYourUpTo: UILabel!
    @IBOutlet weak var btnno: UIButton!
    @IBOutlet weak var notiview: UIView!
    @IBOutlet weak var btnyes: UIButton!
    @IBOutlet weak var BtnGoBack: UIButton!
    @IBOutlet weak var imgNotification: UIImageView!
    @IBOutlet weak var lblNoData        : UILabel!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var tblNotifications : ExpyTableView!
    @IBOutlet weak var successview: UIView!
    @IBOutlet weak var unreadButton     : UIButton!
    @IBOutlet weak var markAllAsReadButton: UIButton!
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var allButton        : UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var imgOrder: UIImageView!
    @IBOutlet weak var lblSignInTo: UILabel!
    @IBOutlet weak var lblYourMissing: UILabel!
    
    var page                             = 1
    var isBottomRefresh                 = false
    var isFromDash                      = false
    var responseCount                   = 0
    var arrOrderResponse                = [Order]()
    var arrNotificationResponse         = [NotificationResponse]()
    var objNotificationTblCell          : NotificationTblCell?
    var strStatus                       = "-1"
    var pickerStatus                    = UIPickerView()
    var allButtonSelected               = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgOrder.isHidden         = true
        self.btnSignIn.isHidden         = true
        self.lblSignInTo.isHidden         = true
        self.lblYourMissing.isHidden         = true
        notiview.cornerRadius = 8
        btnSignIn.cornerRadius = 8
        successview.cornerRadius = 8
        btncontinue.cornerRadius = 8
        btnno.cornerRadius = 8
        btnyes.cornerRadius = 8
        BtnGoBack.cornerRadius = 8
        successview.isHidden = true
        bgview.isHidden = true
        notiview.isHidden = true
        self.initialization()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Initialization
    
    func initialization(){
        selectecAllButton(bool: true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.tblNotifications.tableFooterView = UIView()
        self.isBottomRefresh = false
        self.page = 1
        self.tblNotifications.refreshControl?.hideWithAnimation(hidden: true)
        self.tblNotifications.register(UINib.init(nibName: "NotificationTblCell", bundle: nil), forCellReuseIdentifier: "NotificationTblCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.arrNotificationResponse.removeAll()
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            self.imgOrder.isHidden         = false
            self.btnSignIn.isHidden         = false
            self.lblSignInTo.isHidden         = false
            self.lblYourMissing.isHidden         = false
            self.NoNotificationYet.isHidden = true
            self.lblYourUpTo.isHidden = true
            self.BtnGoBack.isHidden = true
            self.imgNotification.isHidden = true
        }else{
            self.arrNotificationResponse.removeAll()
            self.wsNotificationsURL(page: page, fetch: responseCount, search: "", status: strStatus)
        }
    }
    
    @IBAction func allButtonAction(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            self.imgOrder.isHidden         = false
            self.btnSignIn.isHidden         = false
            self.lblSignInTo.isHidden         = false
            self.lblYourMissing.isHidden         = false
            self.NoNotificationYet.isHidden = true
            self.lblYourUpTo.isHidden = true
            self.BtnGoBack.isHidden = true
            self.imgNotification.isHidden = true
            selectecAllButton(bool: true)
        }else{
            arrNotificationResponse.removeAll()
            self.objNotificationTblCell?.ImgBell.isHidden = true
            page                = 1
            responseCount       = 0
            allButtonSelected   = true
            selectecAllButton(bool: true)
            self.wsNotificationsURL(page: page, fetch: responseCount, search: "", status: strStatus)
        }
    }
    
    @IBAction func btncontinue(_ sender: Any) {
        successview.isHidden = true
        bgview.isHidden = true
    }
    @IBAction func unreadAction(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            self.imgOrder.isHidden         = false
            self.btnSignIn.isHidden         = false
            self.lblSignInTo.isHidden         = false
            self.lblYourMissing.isHidden         = false
            self.NoNotificationYet.isHidden = true
            self.lblYourUpTo.isHidden = true
            self.BtnGoBack.isHidden = true
            self.imgNotification.isHidden = true
            selectecAllButton(bool: false)
        }else{
            self.imgOrder.isHidden         = true
            self.btnSignIn.isHidden         = true
            self.lblSignInTo.isHidden         = true
            self.lblYourMissing.isHidden         = true
            arrNotificationResponse.removeAll()
            page = 1
            responseCount = 0
            allButtonSelected = false
            selectecAllButton(bool: false)
            wsunreadNotificationsURL(page: 1)
        }
    }
    
    @IBAction func btnyes(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            notiview.isHidden = true
            bgview.isHidden = false
            successview.isHidden = false
        }else{
            markAsRead()
            notiview.isHidden = true
            successview.isHidden = false
            bgview.isHidden = false
        }
    }
    @IBAction func btnno(_ sender: Any) {
        bgview.isHidden = true
        notiview.isHidden = true
    }
    @IBAction func markAllasReadAction(_ sender: Any) {
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
          print("")
        }else{
            notiview.isHidden = false
            bgview.isHidden = false
            
        }
    }
    @IBAction func btnSignIn(_ sender: Any) {
        if let objLoginVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            self.navigationController?.pushViewController(objLoginVC, animated: true)
        }
        
    }
    func selectecAllButton(bool :Bool){
        if bool{
            unreadButton.backgroundColor    = .clear
            allButton.backgroundColor       = .white
            allButton.setTitleColor(UIColor(hexFromString: "#EC187B"), for: .normal)
            unreadButton.setTitleColor(.white, for: .normal)
        }else{
            allButton.backgroundColor       = .clear
            unreadButton.backgroundColor    = .white
            unreadButton.setTitleColor(UIColor(hexFromString: "#EC187B"), for: .normal)
            allButton.setTitleColor(.white, for: .normal)
        }
    }
    func markAsRead(){
        self.lblNoData.isHidden = true
        self.NoNotificationYet.isHidden = true
        self.lblYourUpTo.isHidden = true
        self.BtnGoBack.isHidden = true
        self.imgNotification.isHidden = true
        
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "status=1"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.NotificationsMarkAsRead, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        
                        self.arrNotificationResponse.removeAll()
                        self.page = 1
                        self.responseCount = 0
                        self.selectecAllButton(bool: true)
                        self.wsNotificationsURL(page: 1, fetch: self.responseCount, search: "", status: self.strStatus)
                    }catch let err {
                        self.tblNotifications.isHidden = true
                        self.lblNoData.isHidden = false
                        self.NoNotificationYet.isHidden = false
                        self.lblYourUpTo.isHidden = false
                        self.BtnGoBack.isHidden = false
                        self.imgNotification.isHidden = false
                        print("Session Error: ",err)
                    }
                }
                else{
                }
            }
        }
    }
    //This method is used for invoke the notifiaction API
    func wsNotificationsURL(page:Int,fetch: Int, search: String, status: String){
        self.lblNoData.isHidden = true
        self.objNotificationTblCell?.ImgBell.isHidden = true
        self.NoNotificationYet.isHidden = true
        self.lblYourUpTo.isHidden = true
        self.BtnGoBack.isHidden = true
        self.imgNotification.isHidden = true
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "fetch=\(10)&status=-1&page=\(page)&sort_by=&keyword="
        APICall().post(apiUrl: Constants.WebServiceURLs.NotificationsURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(NotificationListResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            if self.isBottomRefresh == true {
                                self.tblNotifications.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrNotificationResponse.append(contentsOf: [data][0].notifications!)
                            } else  {
                                self.arrNotificationResponse = data.notifications!
                            }
                            self.isBottomRefresh = false
                            if self.arrNotificationResponse.count > 0{
                                self.responseCount = data.totalCount
                                self.tblNotifications.isHidden = false
                                self.lblNoData.isHidden = true
                                self.NoNotificationYet.isHidden = true
                                self.lblYourUpTo.isHidden = true
                                self.BtnGoBack.isHidden = true
                                self.imgNotification.isHidden = true
                                self.tblNotifications.delegate = self
                                self.tblNotifications.dataSource = self
                                self.tblNotifications.reloadData()
                            } else {
                                //self.lblNoData.text = dicResponseData.message
                                self.tblNotifications.isHidden = true
                                self.lblNoData.isHidden = false
                                self.NoNotificationYet.isHidden = false
                                self.lblYourUpTo.isHidden = false
                                self.BtnGoBack.isHidden = false
                                self.imgNotification.isHidden = false
                            }
                        }
                    }catch let err {
                        self.tblNotifications.isHidden = true
                        self.lblNoData.isHidden = false
                        self.NoNotificationYet.isHidden = false
                        self.lblYourUpTo.isHidden = false
                        self.BtnGoBack.isHidden = false
                        self.imgNotification.isHidden = false
                        print("Session Error:",err)
                    }
                }
                else{
                }
            }
        }
    }
    //This function used for unread the notification API
    func wsunreadNotificationsURL(page:Int){
        self.objNotificationTblCell?.ImgBell.isHidden = true
        self.lblNoData.isHidden = true
        self.NoNotificationYet.isHidden = true
        self.lblYourUpTo.isHidden = true
        self.BtnGoBack.isHidden = true
        self.imgNotification.isHidden = true
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "fetch=\(10)&status=-1&page=\(page)&sort_by=&keyword=&sort_method="
        APICall().post(apiUrl: Constants.WebServiceURLs.NotificationsUnreadURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(NotificationListResponseModel.self, from: responseData as! Data)
                        if let data = dicResponseData.data {
                            
                            if self.isBottomRefresh == true {
                                self.tblNotifications.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrNotificationResponse.append(contentsOf: [data][0].notifications!)
                            } else  {
                                self.arrNotificationResponse = data.notifications!
                            }
                            self.isBottomRefresh = false
                            if self.arrNotificationResponse.count > 0{
                                self.responseCount = data.totalCount
                                self.tblNotifications.isHidden = false
                                self.lblNoData.isHidden = true
                                self.objNotificationTblCell?.ImgBell.isHidden = true
                                self.NoNotificationYet.isHidden = true
                                self.lblYourUpTo.isHidden = true
                                self.BtnGoBack.isHidden = true
                                self.imgNotification.isHidden = true
                                self.tblNotifications.delegate = self
                                self.tblNotifications.dataSource = self
                                self.tblNotifications.reloadData()
                            } else {
                                //self.lblNoData.text = dicResponseData.message
                                self.tblNotifications.isHidden = true
                                self.lblNoData.isHidden = false
                                self.NoNotificationYet.isHidden = false
                                self.lblYourUpTo.isHidden = false
                                self.BtnGoBack.isHidden = false
                                self.imgNotification.isHidden = false
                            }
                        }
                    }catch let err {
                        self.tblNotifications.isHidden = true
                        self.lblNoData.isHidden = false
                        self.NoNotificationYet.isHidden = false
                        self.lblYourUpTo.isHidden = false
                        self.BtnGoBack.isHidden = false
                        self.imgNotification.isHidden = false
                        print("Session Error: ",err)
                    }
                }
                else{
                }
            }
        }
    }
    @IBAction func goback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
}

extension NotificationVC: ExpyTableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isBottomRefresh = true
        loadMoreFromBottom()
    }
    //This method is used for load more data
    func loadMoreFromBottom() {
        if responseCount > self.arrNotificationResponse.count{
            page = page + 1
            self.tblNotifications.refreshControl?.showWithAnimation(onView: self.tblNotifications, animation: .bottom)
            if allButtonSelected{
                self.wsNotificationsURL(page: page, fetch: responseCount, search: "", status: strStatus)
            }else{
                self.wsunreadNotificationsURL(page: page)
            }
        }
    }
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        objNotificationTblCell = tableView.dequeueReusableCell(withIdentifier: "NotificationTblCell")! as? NotificationTblCell
        objNotificationTblCell?.lblTitle.text = self.arrNotificationResponse[section].title
        objNotificationTblCell?.lblDesc.text = self.arrNotificationResponse[section].body
        objNotificationTblCell?.lblDate.text = self.arrNotificationResponse[section].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy")// hh:mm a")
        if self.arrNotificationResponse[section].isRead == 1{
            objNotificationTblCell?.ImgBell.isHidden = true
        }else {
            objNotificationTblCell?.ImgBell.isHidden = false
        }
        return objNotificationTblCell ?? UITableViewCell()
    }
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return ExpyTableViewDefaultValues.expandableStatus
    }
}

//MARK: Basic Table View Implementation, no need to write UITableViewDataSource because ExpyTableViewDataSource is forwarding all the delegate methods of UITableView that are not handled by itself.
extension NotificationVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrNotificationResponse.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTblCell", for: indexPath as IndexPath) as? NotificationTblCell
        return cell ?? NotificationTblCell()
    }
}
extension NotificationVC: ExpyTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        print("Current state: \(state)")
    }
}
