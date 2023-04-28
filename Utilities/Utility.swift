//
//  Utility.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Foundation
import Photos
import SystemConfiguration
import AVFoundation
import MBProgressHUD
import Reachability
import SwiftGifOrigin

var hud:MBProgressHUD = MBProgressHUD()
var reachability = Reachability.init()!
var isNoLoader = false
let buttonTintColorYellow : UIColor = UIColor(red: 242/255, green: 188/255, blue: 12/255, alpha: 1)
let buttonTintColorBlack : UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
var activityView: UIView?
let imageViewAnimatedGif = UIImageView()
var backGroundview       = UIView()

//This method is used for presenting the screen
func presentViewController(vc: UIViewController) {
    let viewController: UIViewController = (APPDELEGATE?.window?.rootViewController)!
    vc.modalPresentationStyle = .overCurrentContext
    vc.popoverPresentationController?.sourceView = viewController.view
    vc.popoverPresentationController?.sourceRect = viewController.view.bounds
    vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
    
    if (viewController.presentedViewController != nil) {
        viewController.presentedViewController?.dismiss(animated: true, completion: {
            print("")
        })
        viewController.present(vc, animated: true, completion: nil)
    } else {
        viewController.present(vc, animated: true, completion: nil)
    }
}

//This method is used for dismissing the screen
func dismissViewController() {
    APPDELEGATE?.window?.rootViewController?.dismiss(animated: true, completion: nil)
}
func removeActivityIndicator() {
    activityView?.isHidden = true
    activityView?.removeFromSuperview()
}

func isInternetConnectedWith(isAlert: Bool) -> Bool {
    do {
        try reachability.startNotifier()
    } catch {
        print("could not start reachability notifier")
    }
    if reachability.connection == .none && isAlert {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            showToastMessage(message: msgNotConnectedNetworkAlert)
            removeActivityIndicator()
        }
    }
    return reachability.connection != .none
}

//    /// MARK: - MBProgress Indicator Methods
func showToastMessage(message: String) {
    //APPDELEGATE?.window?.makeToast(message)
}
//This method is used for showing the loader
func showLoader(_ strMsg : String = "") {
    mainThread {
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        //        hud.tag = 12222
        //        UIApplication.shared.keyWindow?.addSubview(hud)
        //        hud.mode = .indeterminate
        
        
        /*
         let  HUD = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
         HUD.bezelView.color = UIColor.clear
         let imageViewAnimatedGif = UIImageView()
         //The key here is to save the GIF file or URL download directly into a NSData instead of making it a UIImage. Bypassing UIImage will let the GIF file keep the animation.
         let filePath = Bundle.main.path(forResource: "gifLoader", ofType: "gif")
         let gifData = NSData(contentsOfFile: filePath ?? "") as Data?
         imageViewAnimatedGif.image = UIImage(named: "ic_reject")
         imageViewAnimatedGif.loadGif(name: "gifLoader")
         
         HUD.customView = UIImageView(image: imageViewAnimatedGif.image)
         var rotation: CABasicAnimation?
         rotation = CABasicAnimation(keyPath: "transform.rotation")
         rotation?.fromValue = nil
         // If you want to rotate Gif Image Uncomment
         //  rotation?.toValue = CGFloat.pi * 2
         rotation?.duration = 0.7
         rotation?.isRemovedOnCompletion = false
         HUD.customView?.layer.add(rotation!, forKey: "Spin")
         HUD.mode = MBProgressHUDMode.customView
         // Change hud bezelview Color and blurr effect
         HUD.bezelView.color = UIColor.clear
         HUD.bezelView.tintColor = UIColor.clear
         HUD.bezelView.style = .solidColor
         HUD.bezelView.blurEffectStyle = .dark
         // Speed
         rotation?.repeatCount = .infinity
         HUD.show(animated: true)
         HUD.tag = 12222
         UIApplication.shared.keyWindow?.addSubview(HUD)
         */
        

        hud.backgroundColor = UIColor.clear
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        // Set an image view with a checkmark.
        
        imageViewAnimatedGif.isHidden = false
        imageViewAnimatedGif.loadGif(name: "gifLoader")
        //        imageViewAnimatedGif.image = UIImage(named: "ic_reject")
        imageViewAnimatedGif.backgroundColor = .clear
        imageViewAnimatedGif.frame =   CGRect(x: UIScreen.main.bounds.size.width/2 - 50 , y: UIScreen.main.bounds.size.height/2 - 50, width: 100 , height: 100)
        
         backGroundview = UIView.init(frame: CGRect(x: 0 , y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height))
        backGroundview.backgroundColor = UIColor.black
        backGroundview.alpha = 0.6
//        backGroundview.addSubview(imageViewAnimatedGif)
        
        backGroundview.isHidden = false
        hud.customView?.backgroundColor = UIColor.clear
        hud.show(animated: true)
        hud.tag = 12222
        UIApplication.shared.keyWindow?.addSubview(backGroundview)
        UIApplication.shared.keyWindow?.addSubview(imageViewAnimatedGif)
    }
}
//This method is used for Hiding the loader
func hideLoader() {
    mainThread {
        
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            imageViewAnimatedGif.isHidden = true
            backGroundview.isHidden       = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        if let viewWIthTag =  UIApplication.shared.keyWindow?.viewWithTag(12222) {
            imageViewAnimatedGif.isHidden = true
            backGroundview.isHidden       = true
            viewWIthTag.removeFromSuperview()
            backGroundview.removeFromSuperview()
            
        }
           backGroundview.removeFromSuperview()

            imageViewAnimatedGif.isHidden = true
            backGroundview.isHidden       = true
        //   hud.removeFromSuperview()
        
    }
}
//This method is used for showing Toast message
func showToast(message : String) {
    var toastLabel =  UILabel()
    if Constants.DeviceType.IS_IPADLarge || Constants.DeviceType.IS_IPAD || Constants.DeviceType.IS_IPADMin{
        toastLabel = UILabel(frame: CGRect(x: UIApplication.shared.keyWindow!.frame.size.width/2 - 300, y: (UIApplication.shared.keyWindow?.frame.size.height)!-100, width:600,  height : 70))
        toastLabel.font = UIFont(name: "Lato", size: 26.0)
    } else {
        
        toastLabel = UILabel(frame: CGRect(x: UIApplication.shared.keyWindow!.frame.size.width/2 - 150, y: (UIApplication.shared.keyWindow?.frame.size.height)!-100, width:300,  height : 50))
        toastLabel.font = UIFont(name: "Lato", size: 18.0)
    }
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = NSTextAlignment.center;
    let window: UIWindow? = UIApplication.shared.windows.last
    window?.addSubview(toastLabel)
    toastLabel.text = message
    toastLabel.numberOfLines = 0
    toastLabel.alpha = 1.0
    
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    UIView.animate(withDuration: 7, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
        toastLabel.alpha = 0.0
    })
}

//MARK: - Check Null or Nil Object

func isObjectNotNil(object:AnyObject!) -> Bool {
    if let _:AnyObject = object {
        return true
    }

    return false
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return USERDEFAULTS.object(forKey: key) != nil
}

func saveImage(data: Data) -> URL? {
    
    let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
    do {
        let targetURL = tempDirectoryURL.appendingPathComponent("Image.png")
        try data.write(to: targetURL)
        return targetURL
    } catch {
        print(error.localizedDescription)
        return nil
    }
}
// This method is used for opening the pop up for camere (Take and choose photo)
protocol MyAlert {
    func takeAndChoosePhoto()
}
//This function are used for asking the click on Cancel or Setting
extension MyAlert where Self: UIViewController, Self: UIImagePickerControllerDelegate, Self: UINavigationControllerDelegate {
    func alertPromptToAllowPhotoAccessViaSetting() {
        //let alert1 = UIAlertController(title: "Error", message:"Camera access required to...", preferredStyle: UIAlertControllerStyle.alert)
        let alert = UIAlertController(title: nil, message: "Photos access required", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"App-Prefs:root=Privacy&path=PHOTOS")!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL(string:"App-Prefs:root=Privacy&path=PHOTOS")!)
            }
        })
        present(alert, animated: true)
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        //let alert1 = UIAlertController(title: "Error", message:"Camera access required to...", preferredStyle: UIAlertControllerStyle.alert)
        let alert = UIAlertController(title: nil, message: "Camera access required", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"App-Prefs:root=Privacy&path=CAMERA")!, options: [:], completionHandler: nil)
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
            else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL(string:"App-Prefs:root=Privacy&path=CAMERA")!)
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        })
        present(alert, animated: true)
    }
    // This method invoking when i am cliking on camera button
    func takeAndChoosePhoto(){
        DispatchQueue.main.async(execute: {() -> Void in
            //Code that presents or dismisses a view controller here
            
            //DispatchQueue.main.async(execute: {
            // work Needs to be done
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let button0 = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) -> Void in
                
                //  UIAlertController will automatically dismiss the view
            })
            let button1 = UIAlertAction(title: "Take photo", style: .default, handler: {(action: UIAlertAction) -> Void in
                if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let alert = UIAlertView(title: "Error", message: "Device Has No Camera", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                    switch authStatus {
                    case .authorized: let imagePickerController = UIImagePickerController()
                    imagePickerController.sourceType = .camera
                    imagePickerController.delegate = self
                    self.present(imagePickerController, animated: true, completion: {() -> Void in
                    })
                    case .denied: self.alertPromptToAllowCameraAccessViaSetting()
                        
                    default:
                        let imagePickerController = UIImagePickerController()
                        imagePickerController.sourceType = .camera
                        imagePickerController.delegate = self
                        self.present(imagePickerController, animated: true, completion: {() -> Void in
                        })
                    }
                }
            })
            let button2 = UIAlertAction(title: "Choose Existing", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                //  The user tapped on "Choose existing"
                let status = PHPhotoLibrary.authorizationStatus()
                if (status == PHAuthorizationStatus.authorized) {
                    // Access has been granted.
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.sourceType = .photoLibrary
                    imagePickerController.delegate = self
                    self.present(imagePickerController, animated: true, completion: {() -> Void in
                    })
                }
                else if (status == PHAuthorizationStatus.denied) {
                    self.alertPromptToAllowPhotoAccessViaSetting()
                }
                else if (status == PHAuthorizationStatus.notDetermined) {
                    // Access has not been determined.
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        
                        if (newStatus == PHAuthorizationStatus.authorized) {
                            let imagePickerController = UIImagePickerController()
                            imagePickerController.sourceType = .photoLibrary
                            imagePickerController.delegate = self
                            
                            DispatchQueue.main.async(execute: {() -> Void in
                                //Code that presents or dismisses a view controller here
                                self.present(imagePickerController, animated: true, completion: nil)
                            })
                            //                        self.present(imagePickerController, animated: true, completion: {() -> Void in
                            //                        })
                            
                        }
                        else {
                            DispatchQueue.main.async {
                                _ = self.navigationController?.popViewController(animated: true)
                            }
                        }
                    })
                }
                else if (status == PHAuthorizationStatus.restricted) {
                    // Restricted access - normally won't happen.
                }
            })
            
            alertController.addAction(button0)
            alertController.addAction(button1)
            alertController.addAction(button2)
            
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            }
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
}

//MARK: - DispatchQueue

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func mainThread(_ completion: @escaping () -> ()) {
    DispatchQueue.main.async {
        completion()
    }
}

func backgroundThread(_ qos: DispatchQoS.QoSClass = .background , completion: @escaping () -> ()) {
    DispatchQueue.global(qos:qos).async {
        completion()
    }
}
// MARK: - Platform

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
}

// MARK: - Documents Directory Clear

func clearTempFolder() {
    let fileManager = FileManager.default
    let tempFolderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    do {
        let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
        for filePath in filePaths {
            try fileManager.removeItem(atPath: tempFolderPath + "/" + filePath)
        }
    } catch {
        print("Could not clear temp folder: \(error)")
    }
}

// MARK: - Trim String

func trimString(string : NSString) -> NSString {
    return string.trimmingCharacters(in: NSCharacterSet.whitespaces) as NSString
}

// MARK: - Alert and Action Sheet Controller

func showAlertView(_ strAlertTitle : String, strAlertMessage : String) -> UIAlertController {
    let alert = UIAlertController(title: strAlertTitle, message: strAlertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:{ (ACTION :UIAlertAction!)in
    }))
    return alert
}

// MARK:- Navigation

func viewController(withID ID : String) -> UIViewController {
    let controller = Constants.mainStoryboard.instantiateViewController(withIdentifier: ID)
    return controller
}

// MARK:- UIButton Corner Radius

func cornerLeftButton(btn : UIButton) -> UIButton {
    
    let path = UIBezierPath(roundedRect:btn.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize.init(width: 5, height: 5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    btn.layer.mask = maskLayer
    
    return btn
}

func cornerRightButton(btn : UIButton) -> UIButton {
    
    let path = UIBezierPath(roundedRect:btn.bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSize.init(width: 5, height: 5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    btn.layer.mask = maskLayer
    
    return btn
}

// MARK:- UITextField Corner Radius

func cornerLeftTextField(textfield : UITextField) -> UITextField {
    
    let path = UIBezierPath(roundedRect:textfield.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize.init(width: 2.5, height: 2.5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    textfield.layer.mask = maskLayer
    
    return textfield
}

// MARK:- UserDefault Methods

func setUserDefault<T>(_ object : T  , key : String) {
    let defaults = UserDefaults.standard
    defaults.set(object, forKey: key)
    UserDefaults.standard.synchronize()
}

func getUserDefault(_ key: String) -> AnyObject? {
    let defaults = UserDefaults.standard
    
    if let name = defaults.value(forKey: key){
        return name as AnyObject?
    }
    return nil
}
func removeUserDefault(keyToRemove : String) -> AnyObject? {
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey:keyToRemove)
    return nil
}

// MARK: - Image Upload WebService Methods

func generateBoundaryString() -> String{
    return "Boundary-\(UUID().uuidString)"
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}


// MARK: - Camera Permissions Methods

func checkCameraPermissionsGranted() -> Bool {
    var cameraPermissionStatus : Bool = false
    if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
        // Already Authorized
        cameraPermissionStatus = true
        return true
    } else {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
            if granted == true {
                // User granted
                cameraPermissionStatus = granted
                print("Granted access to Camera");
            } else {
                // User rejected
                cameraPermissionStatus = granted
                print("Not granted access to Camera");
            }
        })
        return cameraPermissionStatus
    }
}

// MARK: - Photo Library Permissions Methods

func checkPhotoLibraryPermissionsGranted() -> Bool {
    var photoLibraryPermissionStatus : Bool = false
    let status = PHPhotoLibrary.authorizationStatus()
    if (status == PHAuthorizationStatus.authorized) {
        // Access has been granted.
        photoLibraryPermissionStatus = true
    }
    else if (status == PHAuthorizationStatus.denied) {
        // Access has been denied.
        photoLibraryPermissionStatus = false
    }
    else if (status == PHAuthorizationStatus.notDetermined) {
        // Access has not been determined.
        PHPhotoLibrary.requestAuthorization({ (newStatus) in
            if (newStatus == PHAuthorizationStatus.authorized) {
                photoLibraryPermissionStatus = true
            }
            else {
                photoLibraryPermissionStatus = false
            }
        })
    }
    else if (status == PHAuthorizationStatus.restricted) {
        // Restricted access - normally won't happen.
        photoLibraryPermissionStatus = false
    }
    return photoLibraryPermissionStatus
}

// MARK: - Set NavigationBar Methods
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


func setNavigation(){
    
    if Constants.DeviceType.IS_IPAD || Constants.DeviceType.IS_IPADMin || Constants.DeviceType.IS_IPADLarge{
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: Constants.Font.latoReg, size: 26)!]
    } else {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: Constants.Font.latoReg, size: 18)!]
    }
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().isTranslucent = false

}

// MARK: - Set TabBarController NavigationBar Methods

func setTabBarControllerNavigationBar(viewController : UIViewController, strTitleName : String) {
    
    let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
    viewController.tabBarController?.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
    
    viewController.tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
    
    //viewController.tabBarController?.navigationController.navigationBar.tintColor = .white()
    viewController.tabBarController?.navigationItem.title = strTitleName
    //viewController.tabBarController?.navigationController?.navigationBar.backgroundColor = .defaultBlue()
    viewController.tabBarController?.navigationController?.navigationBar.isTranslucent = false
    
}

// MARK:- Navigation
func navigateVC(identifierId : String) -> UIViewController {
    let controller = Constants.mainStoryboard.instantiateViewController(withIdentifier: identifierId)
    return controller
}

func saveData<T>(ObjectToSave : T  , KeyToSave : String)
{
    
    let data  = NSKeyedArchiver.archivedData(withRootObject: ObjectToSave)
    let defaults = UserDefaults.standard
    defaults.set(data, forKey:KeyToSave)
    UserDefaults.standard.synchronize()
}
