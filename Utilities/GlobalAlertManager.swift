//
//  GlobalAlertManager.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 08/10/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This GlobalAlertManager used for return to LoginScreen

import Foundation
import UIKit

var systemAlertDisplayed = false
class GlobalAlertManager: NSObject {
    
    static let sharedInstance = GlobalAlertManager()
    
    
    //MARK: LogOut and session expire handling
    static func logOutFunction(OnViewController vc: UIViewController) {
        vc.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        
        DispatchQueue.main.async {
            let identifier = "LoginVC"
            
            let viewController = AuthenticationStoryboard.instantiateViewController(withIdentifier :"LoginVC") as! LoginVC
            let window = UIApplication.shared.keyWindow
            let naviagtionController = UINavigationController.init(rootViewController: viewController)
            naviagtionController.navigationBar.isHidden = true
            window?.rootViewController = naviagtionController
        }
    }
    
    
    //MARK: LogOut and session expire handling
    static func navigateToLogin(OnViewController vc: UIViewController) {
        vc.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        
        DispatchQueue.main.async {
            let identifier = "LoginVC"
            
            let viewControllerClass = LoginVC()
            var available = false
            let storyboard = AuthenticationStoryboard
            UserDefaults.standard.setValue(false, forKey: identifier)
            
            if #available(iOS 13.0, *) {
                let popScreen = storyboard.instantiateViewController(identifier: identifier)
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                let navigationController = keyWindow?.rootViewController as? UINavigationController
                if let viewControllers = navigationController?.viewControllers {
                    for vc in viewControllers {
                        if vc.isKind(of: viewControllerClass.classForCoder) {
                            
                            navigationController!.popToViewController(vc, animated: true)
                            available = true
                            break
                        }
                    }
                    if !available{
                        navigationController?.pushViewController(popScreen, animated: true)
                    }
                }
            } else {
                let keyWindow = (UIApplication.shared.delegate as! AppDelegate).window ?? UIWindow()
                let navigationController: UINavigationController = (keyWindow.rootViewController as? UINavigationController)!
                
                for controller in navigationController.viewControllers as Array {
                    if controller.isKind(of: viewControllerClass.classForCoder) {
                        _ =  navigationController.popToViewController(controller, animated: true)
                        available = true
                        break
                    }
                }
                if !available{
                    let nextScreen = AuthenticationStoryboard.instantiateViewController(withIdentifier: identifier)
                    nextScreen.modalTransitionStyle = .crossDissolve
                    navigationController.pushViewController(nextScreen, animated: true)
                }
            }
        }
    }
    
}


