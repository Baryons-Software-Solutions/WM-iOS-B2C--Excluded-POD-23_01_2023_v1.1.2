//
//  MenuNewViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 08/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class MenuNewViewController: UIViewController {
    
    @IBOutlet weak var personName       : UILabel!
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var versionlabel: UILabel!
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var logoutview: UIView!
    @IBOutlet weak var editbutton       : UIButton!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var btnlogout: UIButton!
    @IBOutlet weak var menuTableView    : UITableView!
    @IBOutlet weak var baclButton       : UIButton!
    @IBOutlet weak var VwDelete: UIView!
    @IBOutlet weak var BtnDelete: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var ProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var menuTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSignInToGet: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var CircleTick: UIImageView!
    @IBOutlet weak var SignTick: UIImageView!
    @IBOutlet weak var PecentageTextField: UITextField!
    
    var menuNames = ["My Favourites","My Deliveries","My Addresses","Wishlist","Settings", "My Documents","Refer a Friend","Delete Account","Logout"]
    var menuImages = ["My Wishlist","My Deliveries","maps-and-flags","heart","Settings", "My Documents","Refer a Friend","DeleteAccount","Logout"]
    var subMenuNames = [["Change Password","Need Help?"],["Invoices"]]
    var selectedIndexPath           = IndexPath()
    var selectedIndexPathArray      = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "false" {
            self.menuTableViewHeight.constant =  60
            menuNames = ["Need Help?"]
            menuImages = ["Need Help (1)"]
            subMenuNames = [["Need Help?"]]
            PecentageTextField.isHidden = true
            versionlabel.text = appVersion
            menuTableView.layer.borderColor = UIColor(hexFromString: "#DCDCDC").cgColor
            VwDelete.isHidden = true
            logoutview.isHidden = true
            bgview.isHidden = true
            personName.isHidden = true
            profileImageView.isHidden = true
            ProgressBar.isHidden = true
            CircleTick.isHidden = true
            SignTick.isHidden = true
            editbutton.isHidden = true
            baclButton.isHidden = true
            delegateSetup()
            btnSignIn.cornerRadius = 10
            self.menuTableView.cornerRadius = 10
        }else{
            self.logoutview.cornerRadius = 10
            self.btncancel.cornerRadius = 10
            self.btnlogout.cornerRadius = 10
            self.VwDelete.cornerRadius = 10
            self.BtnDelete.cornerRadius = 10
            self.cancelBtn.cornerRadius = 10
            btnSignIn.cornerRadius = 10
            self.editbutton.cornerRadius = 20
            delegateSetup()
            bgview.isHidden = true
            VwDelete.isHidden = true
            logoutview.isHidden = true
            baclButton.isHidden = true
            lblSignInToGet.isHidden = true
            btnSignIn.isHidden = true
            self.menuTableView.cornerRadius = 10
            versionlabel.text = appVersion
            menuTableView.layer.borderColor = UIColor(hexFromString: "#DCDCDC").cgColor
            uiInitialization()
            NotificationCenter.default.addObserver(self, selector: #selector(collecionCellSelection(_:)), name: NSNotification.Name(rawValue: "passing_index"), object: nil)
            let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\( USERDEFAULTS.getDataForKey(.userPic))")
            profileImageView.kf.indicatorType = .activity
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_profile"),
                options: nil)
            print(url)
            self.profileImageView.setImage(with: "\(Constants.WebServiceURLs.fetchPhotoURL)\( USERDEFAULTS.getDataForKey(.userPic))")
            print(profileImageView)
            if (USERDEFAULTS.getDataForKey(.weightage)) as? Int ?? 1 >= 100{
                self.ProgressBar.value = 100
                self.PecentageTextField.isHidden = true
                self.CircleTick.isHidden = false
                self.SignTick.isHidden = false
            }else{
                self.PecentageTextField.isHidden = false
                self.CircleTick.isHidden = true
                self.SignTick.isHidden = true
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\( USERDEFAULTS.getDataForKey(.userPic))")
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_profile"),
            options: nil)
        print(url)
        self.profileImageView.setImage(with: "\(Constants.WebServiceURLs.fetchPhotoURL)\( USERDEFAULTS.getDataForKey(.userPic))")
        if (USERDEFAULTS.getDataForKey(.weightage)) as? Int ?? 1 >= 100{
            self.ProgressBar.value = 100
            self.PecentageTextField.isHidden = true
            self.CircleTick.isHidden = false
            self.SignTick.isHidden = false
        }else{
            self.CircleTick.isHidden = true
            self.SignTick.isHidden = true
        }
    }
    
    @IBAction func btncancel(_ sender: Any) {
        bgview.isHidden = true
        logoutview.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    @IBAction func btnNo(_ sender: Any) {
        bgview.isHidden = true
        VwDelete.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = UIColor(hexFromString: "FFFFFF")
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        let dashboardVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(dashboardVC, animated: true)
        dashboardVC.modalPresentationStyle = .fullScreen
    }
    //This function used for logout
    @IBAction func btnlogout(_ sender: Any) {
        USERDEFAULTS.removeDataForKey(.accessToken)
        USERDEFAULTS.setDataForKey("false", .isLogin)
        USERDEFAULTS.setDataForKey("true", .isLogout)
        USERDEFAULTS.removeDataForKey(.user_type_id)
        USERDEFAULTS.removeDataForKey(.userID)
        USERDEFAULTS.removeDataForKey(.user_first_name)
        USERDEFAULTS.removeDataForKey(.user_middle_name)
        USERDEFAULTS.removeDataForKey(.user_last_name)
        USERDEFAULTS.removeDataForKey(.user_phone)
        USERDEFAULTS.removeDataForKey(.designation)
        USERDEFAULTS.removeDataForKey(.selectTier)
        USERDEFAULTS.removeDataForKey(.tierSetUp)
        USERDEFAULTS.removeDataForKey(.getNotified)
        USERDEFAULTS.removeDataForKey(.userPic)
        USERDEFAULTS.removeDataForKey(.weightage)
        if isKeyPresentInUserDefaults(key: UserDefaultsKeys.isRememberMe.rawValue){
            if USERDEFAULTS.getDataForKey(.isRememberMe) as! String == "false" {
                USERDEFAULTS.removeDataForKey(.user_email)
                USERDEFAULTS.removeDataForKey(.user_password)
                
            } else {
                
            }
        }
        
        GlobalAlertManager.logOutFunction(OnViewController: self)
    }
    
    @objc func collecionCellSelection(_ sender: Notification){
        if let dict = sender.userInfo as NSDictionary? {
            DispatchQueue.main.async {
                let topic = dict["topic"] as! String
                if topic == "Change Password"{
                    if let objChangePasswordVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC {
                        objChangePasswordVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(objChangePasswordVC, animated: true)
                    }
                }else if topic == "Need Help?"{
                    
                    if let NeedHelpVC = mainStoryboard.instantiateViewController(withIdentifier: "NeedHelpVC") as? NeedHelpVC {
                        NeedHelpVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(NeedHelpVC, animated: true)
                    }
                }else if topic == "Reports"{
                
                    
                }else if topic == "Invoices"{
                    if let objChangePasswordVC = mainStoryboard.instantiateViewController(withIdentifier: "InvoicesVC") as? InvoicesVC {
                        objChangePasswordVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(objChangePasswordVC, animated: true)
                    }
                }
            }
        }
    }
    //This method is used for initilize the name and image
    func uiInitialization(){
        self.personName.text = "\(USERDEFAULTS.getDataForKey(.user_first_name)) \(USERDEFAULTS.getDataForKey(.user_last_name))"
        if let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(USERDEFAULTS.getDataForKey(.userPic) as? String)") {
            profileImageView.kf.indicatorType = .activity
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic_profile"),
                options: nil)
        }
    }
    
    func delegateSetup(){
        menuTableView.delegate = self
        menuTableView.dataSource = self
        self.menuTableView.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    @IBAction func editAction(_ sender: Any) {
        if let MyProfileVC = mainStoryboard.instantiateViewController(withIdentifier: "MyProfileVC") as? MyProfileVC {
            MyProfileVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(MyProfileVC, animated: true)
        }
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func BtnDelete(_ sender: Any) {
        self.showCustomAlert(message:"User profile is inactivated successfully")
        self.wsdeleteMyAccount()
        
    }
}
// this method is used for create the table cell
extension MenuNewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuNames.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= self.menuNames.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as? MenuTableViewCell
            cell?.menuLabelName.text = menuNames[indexPath.row]
            cell?.menuImageView.image = UIImage(named: menuImages[indexPath.row])
            if indexPath.row == 4  || indexPath.row == 5 {
                cell?.sideMenuArrow.isHidden = false
                cell?.sideMenuArrow.tag   = indexPath.row
                cell?.sideMenuArrow.addTarget(self, action: #selector(dropdown(_:)), for: .touchUpInside)
                if self.selectedIndexPathArray.contains(indexPath){
                    cell?.subMenuTableView.isHidden = false
                    cell?.sideMenuArrow.setImage(UIImage(named: "menuUpArrow"), for: .normal)
                }else{
                    cell?.subMenuTableView.isHidden = true
                    cell?.sideMenuArrow.setImage(UIImage(named: "menuDownArrow"), for: .normal)
                }
            }else{
                cell?.sideMenuArrow.isHidden = true
            }
            if indexPath.row == 4 {
                cell?.configure(arr: subMenuNames[0])
            } else if indexPath.row == 5{
                cell?.configure(arr: subMenuNames[1])
            }else{
                cell?.configure(arr:[])
            }
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "VersionTableViewCell") as? VersionTableViewCell
            return cell ?? UITableViewCell()
        }
    }
    // This variable used for to create version number
    var appVersion: String {
        //versionNumber
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "1.0"
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "1.0"
        return "Version : \(versionNumber)"
    }
    
    
    @objc func dropdown(_ sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.selectedIndexPath = indexPath
        if selectedIndexPathArray.contains(selectedIndexPath) {
            selectedIndexPathArray.remove(indexPath)
        }else{
            selectedIndexPathArray.append(indexPath)
        }
        self.menuTableView.reloadRows(at: [selectedIndexPath] , with: .automatic)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if String(describing: USERDEFAULTS.getDataForKey(.isLogin)) == "true" {
                if let FavouritesVC = mainStoryboard.instantiateViewController(withIdentifier: "FavouritesViewController") as?  FavouritesViewController{
                    FavouritesVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(FavouritesVC, animated: true)
                }
            }else{
                if let NeedHelpVC = mainStoryboard.instantiateViewController(withIdentifier: "NeedHelpVC") as? NeedHelpVC {
                    NeedHelpVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(NeedHelpVC, animated: true)
                }
            }
        }else if indexPath.row == 1{
            let DeliveryVC = mainStoryboard.instantiateViewController(withIdentifier: "DeliveryVC") as! DeliveryVC
            self.navigationController?.pushViewController(DeliveryVC, animated: true)}
        else if indexPath.row == 2{
            
            // my Address
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "OutletsListVC") as! OutletsListVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            //my settings
            let WishlistVC = mainStoryboard.instantiateViewController(withIdentifier: "WishlistViewController") as? WishlistViewController
            self.navigationController?.pushViewController(WishlistVC!, animated: true)
            
        }else if indexPath.row == 6 {
            //refer
            let ReferFriendVC = mainStoryboard.instantiateViewController(withIdentifier: "ReferFriendVC") as? ReferFriendVC
            self.navigationController?.pushViewController(ReferFriendVC!, animated: true)
        }else if indexPath.row == 7{
            bgview.isHidden = false
            VwDelete.isHidden = false
            self.tabBarController?.tabBar.backgroundColor = .white
            self.tabBarController?.tabBar.alpha = 0.6
            self.tabBarController?.tabBar.isUserInteractionEnabled = false
        }
        else if indexPath.row == 8{
            self.logout()
        }
    }
    //This method  is used for delete the account
    func wsdeleteMyAccount(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        let postString = "status=0"
        APICall().post(apiUrl: Constants.WebServiceURLs.deleteMyAccount, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(GenralResponseModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            USERDEFAULTS.removeDataForKey(.accessToken)
                            USERDEFAULTS.setDataForKey("false", .isLogin)
                            USERDEFAULTS.setDataForKey("true", .isLogout)
                            USERDEFAULTS.removeDataForKey(.user_type_id)
                            USERDEFAULTS.removeDataForKey(.userID)
                            USERDEFAULTS.removeDataForKey(.user_first_name)
                            USERDEFAULTS.removeDataForKey(.user_middle_name)
                            USERDEFAULTS.removeDataForKey(.user_last_name)
                            USERDEFAULTS.removeDataForKey(.user_phone)
                            USERDEFAULTS.removeDataForKey(.designation)
                            USERDEFAULTS.removeDataForKey(.selectTier)
                            USERDEFAULTS.removeDataForKey(.tierSetUp)
                            USERDEFAULTS.removeDataForKey(.getNotified)
                            USERDEFAULTS.removeDataForKey(.userPic)
                            USERDEFAULTS.removeDataForKey(.user_email)
                            USERDEFAULTS.removeDataForKey(.user_password)
                            if let objLoginVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                                objLoginVC.modalPresentationStyle = .fullScreen
                                self.present(objLoginVC, animated: true, completion: nil)
                            }
                        }
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    
    func logout(){
        bgview.isHidden = false
        logoutview.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = .white
        self.tabBarController?.tabBar.alpha = 0.6
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        
    }
}
extension CATransition {
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}
