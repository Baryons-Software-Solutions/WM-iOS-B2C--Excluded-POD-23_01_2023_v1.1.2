//
//  UIViewExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UIView {
    
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 0.9, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func copyView<T: UIView>() -> T? {        
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? T
    }
    
    class func initFromNib<T: UIView>() -> T? {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as? T
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
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get {
            return CGFloat(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            // self.layer.shouldRasterize = true
            
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addTapGesture(_ callBack : @escaping GestureCallBackClosure) {
        let tap = UITapGestureRecognizer()
        self.addGestureRecognizer(tap)
        
        self.isUserInteractionEnabled = true
        tap.callBackTarget(closure: callBack)
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
            //self.layer.shouldRasterize = true
            
        }
        
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            //self.layer.shouldRasterize = true
            
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
        
        //didSet {
        // layer.borderColor = borderColor?.CGColor
        //}
    }
    
    func masks(maskRect: CGRect, invert: Bool = true) {
        // self.removeAllLayer()
        self.mask?.removeAllLayer()
        
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath.init()
        if (invert) {
            path.addRect(self.bounds)
        }
        path.addRoundedRect(in: maskRect, cornerWidth: 5, cornerHeight: 5)
        maskLayer.path = path
        maskLayer.opacity = 0.9
        if (invert) {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        
        // Set the mask of the view.
        self.layer.mask = maskLayer
    }
    
    func addMaskToBlurView(maskRect: CGRect, invert: Bool = false) {
        // self.removeAllLayer()
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath.init()
        if invert {
            path.addRect(self.bounds)
        }
        path.addRoundedRect(in: maskRect, cornerWidth: 5, cornerHeight: 5)
        maskLayer.path = path
        maskLayer.opacity = 0.9
        if (invert) {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = path
        //        borderLayer.strokeColor = UIColor.white.cgColor
        //        borderLayer.fillColor = UIColor.clear.cgColor //Remember this line, it caused me some issues
        //        borderLayer.lineWidth = 10
        
        let maskView = UIView(frame: self.frame)
        //  maskView.backgroundColor = UIColor.black
        maskView.layer.mask = maskLayer
        
        self.layer.addSublayer(borderLayer)
        self.mask = maskView
    }
    
    func removeAllLayer() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func showWithAnimation(onView: UIView, animation: PopUpAnimation) {
        self.showPopup(withAnimation: animation, popUpView: self)
    }
    
    func dismissWithAnimation(animation: PopUpAnimation) {
        self.dismissPopUpViewWithView(popUpView: self, animation: animation, afterDelay: 0.0) {
        }
    }
    
    private func showPopup(withAnimation animation: PopUpAnimation, popUpView: UIView, inView: UIView? = nil) {
        let animationTime: Double = 0.25
        
        switch  animation {
        case .bottom:
            
            popUpView.frame = CGRect(x: 0, y: UIApplication.shared.keyWindow!.bounds.size.height + 1, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            
            if let view = inView {
                view.addSubview(popUpView)
            } else {
                UIApplication.shared.keyWindow?.addSubview(popUpView)
                popUpView.tag = 111
            }
            
            UIView.beginAnimations("animateOff", context: nil)
            UIView.setAnimationDuration(animationTime)
            popUpView.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            UIView.commitAnimations()
            
        case .right:
            
            popUpView.frame = CGRect(x: UIApplication.shared.keyWindow!.bounds.size.width + 1, y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            if let view = inView {
                view.addSubview(popUpView)
            } else {
                UIApplication.shared.keyWindow?.addSubview(popUpView)
            }
            UIView.beginAnimations("animateOff", context: nil)
            UIView.setAnimationDuration(animationTime)
            popUpView.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            UIView.commitAnimations()
            
        case .left:
            
            popUpView.frame = CGRect(x: -(UIApplication.shared.keyWindow!.bounds.size.width + 1), y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            if let view = inView {
                view.addSubview(popUpView)
            } else {
                UIApplication.shared.keyWindow?.addSubview(popUpView)
            }
            UIView.beginAnimations("animateOff", context: nil)
            UIView.setAnimationDuration(animationTime)
            popUpView.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            UIView.commitAnimations()
            
        case .fade:
            
            popUpView.alpha = 0.0
            
            if let view = inView {
                view.addSubview(popUpView)
            } else {
                UIApplication.shared.keyWindow?.addSubview(popUpView)
            }
            UIView.beginAnimations("animateOff", context: nil)
            UIView.setAnimationDuration(animationTime)
            popUpView.alpha = 1.0
            UIView.commitAnimations()
            
        case .top:
            popUpView.frame = CGRect(x: 0, y: -(UIApplication.shared.keyWindow!.bounds.size.height + 1), width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            if let view = inView {
                view.addSubview(popUpView)
            } else {
                UIApplication.shared.keyWindow?.addSubview(popUpView)
            }
            UIView.beginAnimations("animateOff", context: nil)
            UIView.setAnimationDuration(animationTime)
            popUpView.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            UIView.commitAnimations()
            
        case .none:
            
            popUpView.frame = CGRect(x: 0, y: -(UIApplication.shared.keyWindow!.bounds.size.height + 1), width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
            if let view = inView {
                view.addSubview(popUpView)
            } else {
                UIApplication.shared.keyWindow?.addSubview(popUpView)
            }
            popUpView.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.size.width, height: UIApplication.shared.keyWindow!.bounds.size.height)
        }
    }
    
    private func dismissPopUpViewWithView(popUpView: UIView, animation: PopUpAnimation, afterDelay: Double, completionClosure:(() -> Void)?) {
        var rect: CGRect = popUpView.frame
        
        switch animation {
        case .top:
            rect = CGRect(x: 0,
                          y: -(popUpView.frame.size.height + 1),
                          width: popUpView.frame.size.width,
                          height: popUpView.frame.size.height)
            
        case .bottom:
            rect = CGRect(x: 0,
                          y: popUpView.frame.size.height + 1,
                          width: popUpView.frame.size.width,
                          height: popUpView.frame.size.height)
            
        case .left:
            rect = CGRect(x: -(popUpView.frame.size.height + 1),
                          y: 0,
                          width: popUpView.frame.size.width,
                          height: popUpView.frame.size.height)
            
        case .right:
            rect = CGRect(x: 0,
                          y: popUpView.frame.size.height + 1,
                          width: popUpView.frame.size.width,
                          height: popUpView.frame.size.height)
            
        default:
            break
        }
        
        UIView.animate(withDuration: 0.25,
                       delay: afterDelay,
                       options: .curveEaseInOut,
                       animations: {
            if animation == .fade {
                popUpView.alpha = 0.0
            } else {
                popUpView.frame = rect
            }
        },
                       completion: { (_: Bool) in
            completionClosure?()
        })
    }
    
    @IBInspectable var bottomLineColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var bottomLineWidth: CGFloat {
        get {
            return self.bottomLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addBottomBorderWithColor(color: self.bottomLineColor, width: newValue)
            }
        }
    }
    
    @IBInspectable var topLineColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var topLineWidth: CGFloat {
        get {
            return self.topLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addTopBorderWithColor(color: self.topLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var rightLineColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var rightLineWidth: CGFloat {
        get {
            return self.rightLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addRightBorderWithColor(color: self.rightLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var leftLineColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var leftLineWidth: CGFloat {
        get {
            return self.leftLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addLeftBorderWithColor(color: self.leftLineColor, width: newValue)
            }
        }
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "topBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "rightBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "bottomBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    func addBottomBorderWithColor1(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "bottomBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: width, y: self.frame.size.height - width, width: self.frame.size.width - width, height: width)
        border.cornerRadius = border.frame.height / 2
        self.layer.addSublayer(border)
    }
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "leftBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func removePreviouslyAddedLayer(name: String) {
        if self.layer.sublayers?.count ?? 0 > 0 {
            self.layer.sublayers?.forEach {
                if $0.name == name {
                    $0.removeFromSuperlayer()
                }
            }
        }
    }
    
    /** Loads instance from nib with the same name. */
    class func fromNib<T: UIView>() -> T? {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T
    }
    
    func colorOfPoint(point: CGPoint) -> UIColor {
        return autoreleasepool { () -> UIColor in
            let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
            
            var pixelData: [UInt8] = [0, 0, 0, 0]
            
            let context = CGContext(data: &pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            
            context!.translateBy(x: -point.x, y: -point.y)
            
            self.layer.render(in: context!)
            
            let red: CGFloat = CGFloat(pixelData[0]) / CGFloat(255.0)
            let green: CGFloat = CGFloat(pixelData[1]) / CGFloat(255.0)
            let blue: CGFloat = CGFloat(pixelData[2]) / CGFloat(255.0)
            let alpha: CGFloat = CGFloat(pixelData[3]) / CGFloat(255.0)
            
            let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            
            return color
        }
    }
}
