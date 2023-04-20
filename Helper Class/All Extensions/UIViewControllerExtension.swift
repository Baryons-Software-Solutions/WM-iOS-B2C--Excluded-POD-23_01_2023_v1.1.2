//
//  UIViewControllerExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UIViewController: UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.navigationController?.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if (self is UINavigationController) || (self is UITabBarController) {
            return
        }
        // NotificationCenter.default.addObserver(self, selector: #selector(self.refreshUI), name: NSNotification.Name(rawValue: "refreshUI"), object: nil)
    }
    
    // NaivgationController Delegate
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationController.interactivePopGestureRecognizer?.isEnabled = navigationController.viewControllers.count > 1
    }

    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            //do stuff
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // for get app time out notification
    func getNotificationForAppTimeOut(_ callback :@escaping (_ notification: Notification) -> Void) {
        let testBlock: (Notification) -> Void = { notifications in
            callback(notifications)
        }
        _ = NOTIFICATIONCENTER.addObserver(forName: .appTimeout, object: nil, queue: OperationQueue.main, using: testBlock)
    }
    
    // get touch event over all window
    func getNotificationForTouchOnView(_ callback :@escaping (_ event: UIEvent?) -> Void) {
        let testBlock: (Notification) -> Void = { notification in
            if let event = notification.object as? UIEvent {
                callback(event)
            } else {
                callback(nil)
            }
        }
        _ = NOTIFICATIONCENTER.addObserver(forName: .touchOnViewEvent, object: nil, queue: OperationQueue.main, using: testBlock)
    }
    
    // for get notification for user change
    func getNotificationForChangeUser(_ callback :@escaping (_ notification: Notification) -> Void) {
        let testBlock: (Notification) -> Void = { notifications in
            callback(notifications)
        }
        _ = NOTIFICATIONCENTER.addObserver(forName: .changeUser, object: nil, queue: OperationQueue.main, using: testBlock)
    }
    
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        //APPDELEGATE.tabBarController?.menuButton.isHidden = !visible
        
        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
    
//    func navigateBackToViewController(identifier : String, storyboardName: String, viewControllerClass: UIViewController){
//        DispatchQueue.main.async {
//            var available = false
//            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
//            UserDefaults.standard.setValue(false, forKey: identifier)
//            
//            if #available(iOS 13.0, *) {
//                let popScreen = storyboard.instantiateViewController(identifier: identifier)
//                let keyWindow = UIApplication.shared.connectedScenes
//                    .filter({$0.activationState == .foregroundActive})
//                    .map({$0 as? UIWindowScene})
//                    .compactMap({$0})
//                    .first?.windows
//                    .filter({$0.isKeyWindow}).first
//                let navigationController = keyWindow?.rootViewController as? UINavigationController
//                if let viewControllers = navigationController?.viewControllers {
//                    for vc in viewControllers {
//                        if vc.isKind(of: viewControllerClass.classForCoder) {
//                            navigationController!.popToViewController(vc, animated: true)
//                            available = true
//                            break
//                        }
//                    }
//                    if !available{
//                        if storyboardName == "TabBar"{
//                            (popScreen as? TabbarViewController)!.selectedIndex = 2;
//                        }
//                        navigationController?.pushViewController(popScreen, animated: true)
//                    }
//                    
//                }
//            } else {
//                for controller in self.navigationController!.viewControllers as Array {
//                    if controller.isKind(of: viewControllerClass.classForCoder) {
//                        _ =  self.navigationController!.popToViewController(controller, animated: true)
//                        available = true
//                        break
//                    }
//                }
//                if !available{
//                    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
//                    let nextScreen = storyboard.instantiateViewController(withIdentifier: identifier)
//                    nextScreen.modalTransitionStyle = .crossDissolve
//                    if storyboardName == "TabBar"{
//                        (nextScreen as? TabbarViewController)!.selectedIndex = 2;
//                    }
//                    self.navigationController?.pushViewController(nextScreen, animated: true)
//                }
//                
//            }
//        }
//    }
    
    
}

extension UIViewController {
    func viewSlideInFromTopToBottom(view: UIView) -> Void {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.layer.add(transition, forKey: kCATransition)
    }
    func viewSlideInFromBottomToTop(view: UIView) -> Void {
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        view.layer.add(transition, forKey: kCATransition)
    }
    func openMenu()  {
        //        if isFromMenu{
        //             isFromMenu = !isFromMenu
        //        }
        //
        sideMenuController?.showLeftView(animated:true)
    }
    func backMenu() {
        if let navController = self.navigationController {
            navController.popViewController(animated: false)
        }
    }
    func showToast(message : String){
        var toastLabel =  UILabel()
        if Constants.DeviceType.IS_IPADLarge || Constants.DeviceType.IS_IPAD || Constants.DeviceType.IS_IPADMin{
            toastLabel = UILabel(frame: CGRect(x: UIApplication.shared.keyWindow!.frame.size.width/2 - 300, y: (UIApplication.shared.keyWindow?.frame.size.height)!-100, width:600,  height : 70))
            toastLabel.font = UIFont(name: "Lato", size: 26.0)
        } else {
            
            toastLabel = UILabel(frame: CGRect(x: UIApplication.shared.keyWindow!.frame.size.width/2 - 150, y: (UIApplication.shared.keyWindow?.frame.size.height)!-100, width:300,  height : 50))
            toastLabel.font = UIFont(name: "Lato", size: 18.0)
        }
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1.0)
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
    func scrollToTop() {
        func scrollToTop(view: UIView?) {
            guard let view = view else { return }
            
            switch view {
            case let scrollView as UIScrollView:
                if scrollView.scrollsToTop == true {
                    scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
                    return
                }
            default:
                break
            }
            
            for subView in view.subviews {
                scrollToTop(view: subView)
            }
        }
        
        scrollToTop(view: self.view)
    }
    
    @objc func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as? UIViewController
                        return viewController?.topMostViewController() ?? UIViewController()
                    }
                }
            }
            return self
        }
    }
    
    private var isShowCloseButton: Bool? {
        get {
            return objc_getAssociatedObject(self, &Keys.OfflineViewCloseButtonKey) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &Keys.OfflineViewCloseButtonKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func hideOfflineView() {
        //viewOffline?.fadeOut()
    }
    
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    // for get app time out notification. isShowOfflineView is for
    func getNotificationForNetworkChanges( isShowOfflineView: Bool = false, isShowCloseButton: Bool, _ callback :@escaping (_ isConnected: (Bool)) -> Void) {
        self.isShowCloseButton = isShowCloseButton
        
        if !isInternetConnectedWith(isAlert: false) {
            // self.showOfflineView()
        }
        
        // Reachable block
        reachability.whenReachable = { reachability in
            callback(true)
            
            if reachability.connection == .wifi {
                print("Reachabled via WiFi Utility")
            } else {
                print("Reachable via Cellular Utitlity")
            }
        }
        
        // No Reachable block will be called on network lost.
        reachability.whenUnreachable = { _ in
            print("Not reachable Utility")
            callback(false)
        }
    }
}

extension UIViewController {
    func showCustomAlert(message: String, isSuccessResponse: Bool = true, popUptype : popUpType =  .success , buttonTitle : String = "Continue",alertTitle:String = "") {
        let myAlert = AuthenticationStoryboard.instantiateViewController(withIdentifier: "CustomAlertVC") as! CustomAlertVC
        myAlert.message = message
        myAlert.isSuccessResponse = isSuccessResponse
        myAlert.buttonTitle = buttonTitle
        myAlert.popupmessageTypes = popUptype
        myAlert.alertTitle = alertTitle
        //    myAlert.popupmessageTypes = popTypeTyes
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(myAlert, animated: true, completion: nil)
    }
}

