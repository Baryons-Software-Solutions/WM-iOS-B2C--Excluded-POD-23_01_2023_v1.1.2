//
//  UIButtonExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.

import Foundation
// This method is used for Global Button
extension UIButton {
    @IBInspectable var actualValue: String {
        get {
            return (objc_getAssociatedObject(self, &Keys.ButtonValueKey) as? String)!
        }
        set {
            objc_setAssociatedObject(self, &Keys.ButtonValueKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func awakeFromNib() {
        dynamicFontSize = true
        super.awakeFromNib()
    }
    
    var dynamicFontSize: Bool {
        set {
            if newValue {
                if newValue {
                    if (titleLabel?.font) != nil {
                        // titleLabel?.font = fonts.scaleFont()
                    }
                }
            }
        }
        get {
            return false
        }
    }
    // This function calling the to set the background colour of button
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    @IBInspectable var isFloatingButton: Bool {
        set {
            if newValue {
                self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowOpacity = 1.0
                self.layer.shadowRadius = 0.0
                self.layer.masksToBounds = false
            }
        }
        get {
            return false
        }
    }
    
    @IBInspectable var normalBackground: UIColor { // for blended layer test
        set {
            self.setBackgroundColor(color: newValue, forState: .normal)
        }
        get {
            return self.backgroundColor!
        }
    }
    
    @IBInspectable var selectedBackground: UIColor { // for blended layer test
        set {
            self.setBackgroundColor(color: newValue, forState: .selected)
        }
        get {
            return self.backgroundColor!
        }
    }
    // This method used for set white background of the button
    @IBInspectable var isSetWhiteBackground: Bool { // for blended layer test
        set {
            if newValue {
                titleLabel?.backgroundColor = UIColor.white
            }
        }
        get {
            return false
        }
    }
    // This methos is used for underline the word in the Button.
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        let attributes = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func callBackTargetForCollections(alongWith otherButtons: [UIButton?], closure: @escaping ButtonCallBackClosure) {
        callBackTargetClosure = closure
        for  btn in otherButtons {
            if let btn = btn {
                btn.addTarget(self, action: #selector(clickOnClosureButton(_:)), for: .touchUpInside)
            }
        }
    }
    
    func callBackTarget(closure: @escaping ButtonCallBackClosure) {
        callBackTargetClosure = closure
    }
    
    private var callBackTargetClosure: ButtonCallBackClosure? {
        get {
            return objc_getAssociatedObject(self, &Keys.buttonClosure) as? ButtonCallBackClosure
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &Keys.buttonClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                addTarget(self, action: #selector(clickOnClosureButton(_:)), for: .touchUpInside)
            }
        }
    }
    
    func invokeCallBackClosure() {
        if let callBack = callBackTargetClosure {
            callBack(self)
        }
    }
    
    @objc private func clickOnClosureButton(_ sender: UIButton) {
        if let callBack = callBackTargetClosure {
            callBack(sender)
        }
    }
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    func alignTextBelow(spacing: CGFloat) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width + 5, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
            
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
    
    private var badgeLayer: CAShapeLayer? {
        if let bValue: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return bValue as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, addedView: UIView?) {
        guard let view = addedView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        let badgeWidth = 15
        let numberOffset = 1
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(10)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - CGFloat(numberOffset), y: offset.y), size: CGSize(width: badgeWidth, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}
extension UIApplication {
    ///  Run a block in background after app resigns activity
    public func runInBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
    
    ///  Get the top most view controller from the base view controller; default param is UIWindow's rootViewController
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
