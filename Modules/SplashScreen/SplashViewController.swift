//
//  SplashViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 25/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            if UserDefaults.standard.object(forKey: "is_Onboard_Completed") != nil{
                if isKeyPresentInUserDefaults(key: UserDefaultsKeys.isLogin.rawValue){
                    if USERDEFAULTS.getDataForKey(.isLogin) as! String == "true" {
                        let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
                        dashboardvc?.selectedIndex = 0
                        Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
                    }else{
                        if USERDEFAULTS.getDataForKey(.isGuest) as? String == "true" {
                            let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
                            dashboardvc?.selectedIndex = 0
                            Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
                        }else{
                            let welcomeVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                            self.navigationController?.pushViewController(welcomeVC, animated: true)
                            Constants.GlobalConstants.appDelegate.window?.rootViewController = welcomeVC
                        }
                    }
                }else{
                    let welcomeVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    self.navigationController?.pushViewController(welcomeVC, animated: true)
                }
            }else{
                let welcomeVC = AuthenticationStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                self.navigationController?.pushViewController(welcomeVC, animated: true)
            }
        }
    }
}
