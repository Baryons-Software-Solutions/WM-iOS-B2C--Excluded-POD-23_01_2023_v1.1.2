//
//  AppDelegate.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Kingfisher
import Reachability
import UIKit
@_exported import ViewAnimator

class AllExtensions: NSObject {}

typealias EmptyCallBackClosure = () -> Void
typealias ButtonCallBackClosure = (_ sender: UIButton) -> Void
typealias GestureCallBackClosure = (_ sender: UITapGestureRecognizer) -> Void
typealias TextFieldChangeValueHandler = (_ sender: UITextField) -> Void

struct Keys {
    static var closure: UInt8 = 0
    static var control: UInt8 = 0
    static var footer: UInt8 = 0
    static var buttonClosure: UInt8 = 0
    static fileprivate var buttonNodeClosure: UInt8 = 0
    static var AssociatedObjectKey: UInt8 = 0
    static var TextFieldValueKey: UInt8 = 0
    static var LabelRxValueKey: UInt8 = 0
    static var LabelValueKey: UInt8 = 0
    static var LabelLineSpacingKey: UInt8 = 0
    
    static var ButtonValueKey: UInt8 = 0
    static var TextSelectedDateKey: UInt8 = 0
    static var TextValueChangeKey: UInt8 = 0
    static var TapOnTextKey: UInt8 = 0
    static var OfflineViewKey: UInt8 = 0
    static var OfflineViewCloseButtonKey: UInt8 = 0
}

enum PopUpAnimation {
    case left
    case right
    case top
    case bottom
    case fade
    case none
}

enum UserDefaultsKeys: String {
    case isLogin // login
    case isRememberMe // login
    case isGoogle
    case isGuest //Guest
    
    case user_type //user type
    case accessToken // access token
    case userID
    case user_email
    case user_first_name
    case user_middle_name
    case user_mobile_number_code
    case user_password
    case user_last_name
    case user_orgname
    case user_phone
    case user_referralCode
    case abn
    case fcmToken // fcm token
    case address
    case city
    case state
    case pincode
    case userPic
    case arrCart
    case delivery_fee
    case gst_amount // fcm token
    case sub_total
    case total
    case supplier_id
    case payment_token
    case user_type_id
    case role_id
    case permission
    case status
    case status_name
    case getNotified
    case selectTier
    case tierSetUp
    case designation
    case buyerType
    case weightage
    
    case billingAddress
    case deliveryAddress
    
    case billingCity //Baryons-Surendra added on 24/01/22
    case shippingCity //Baryons-Surendra added on 24/01/22
    case selectedUserType //Baryons-Surendra added on 07/02/22
    case isLogout //Baryons-Surendra added on 14/02/22
}

enum BuyerType {
    case company
    case individual
}

//given type to textField
var kAssociationKeyTxtfldType: Int = 0

//Max Length in IBInspectable
var kAssociationKeyMaxLength: Int = 0

//Min Length
var kAssociationKeyMinLength: Int = 0
var handle: UInt8 = 0

@IBDesignable
class GradientViewLight: UIView {
    @IBInspectable var startColor: UIColor = .greyishBrownThree { didSet { updateColors() } }
    @IBInspectable var endColor: UIColor = .shadow { didSet { updateColors() } }
    @IBInspectable var startLocation: Double = 0.05 { didSet { updateLocations() } }
    @IBInspectable var endLocation: Double = 0.95 { didSet { updateLocations() } }
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() } }
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() } }
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as? CAGradientLayer ?? CAGradientLayer() }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 1, y: 0.5)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
@IBDesignable
class RightAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
    }
}
@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .blackThree { didSet { updateColors() } }
    @IBInspectable var endColor: UIColor = .greyishBrownThree { didSet { updateColors() } }
    @IBInspectable var startLocation: Double = 0 { didSet { updateLocations() } }
    @IBInspectable var endLocation: Double = 1 { didSet { updateLocations() } }
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() } }
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() } }
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as?  CAGradientLayer ?? CAGradientLayer() }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

class LifeCycleView: UIView {
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil {
            // UIView disappear
            self.viewWillDisAppear()
        } else {
            // UIView appear
            self.viewWillAppear()
        }
    }
    
    func viewWillAppear() {
    }
    
    func viewWillDisAppear() {
    }
}

public enum PanDirection: Int {
    case up, down, left, right
    
    public var isVertical: Bool { return [.up, .down].contains(self) }
    
    public var isHorizontal: Bool { return !isVertical }
}
