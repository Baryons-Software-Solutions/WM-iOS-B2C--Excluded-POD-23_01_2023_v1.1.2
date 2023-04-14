//
//  UINavigationControllerExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        return self.visibleViewController!.topMostViewController()
    }
    //    func addShadowToNavigation() {
    //        self.navigationBar.shadowImage = UIImage()
    //        if #available(iOS 11.0, *) {
    //            let aColor = UIColor(named: "customControlColor")
    //        } else {
    //            // Fallback on earlier versions
    //        }
    //        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: aColor!, NSAttributedString.Key.font: font(name: .hindMedium, size: 26)]
    //    }
    
    @IBInspectable var barTintColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            navigationBar.barTintColor = uiColor
        }
        get {
            guard let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
    
    @IBInspectable var barTextColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: uiColor]
        }
        get {
            guard let textAttributes = navigationBar.titleTextAttributes else { return nil }
            return textAttributes[NSAttributedString.Key.foregroundColor] as? UIColor
        }
    }
    
    @IBInspectable var barTextFont: UIFont? {
        set {
            guard let uiFont = newValue else { return }
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: uiFont]
        }
        get {
            guard let textAttributes = navigationBar.titleTextAttributes else { return nil }
            return textAttributes[NSAttributedString.Key.font] as? UIFont
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: navigationBar.layer.shadowColor!)
        }
        set {
            navigationBar.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get {
            return CGFloat(navigationBar.shadowOpacity)
        }
        set {
            navigationBar.layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return navigationBar.shadowRadius
        }
        set {
            navigationBar.shadowRadius = newValue
            // self.layer.shouldRasterize = true
            
        }
    }
}
