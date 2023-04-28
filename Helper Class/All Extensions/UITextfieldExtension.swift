//
//  UITextfieldExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
var selfMache = "SELF MATCHES %@"
extension UITextField: UITextFieldDelegate {
    
    func enableTapOnTextfield(callBack : @escaping TextFieldChangeValueHandler) {
        self.isTextEnable = false
        self.delegate = self
        self.addTapGesture { (gesture) in
            gesture.view?.window?.endEditing(true)
            if let txtField = gesture.view as? UITextField {
                callBack(txtField)
            }
        }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.isTextEnable ?? true
    }
    
    private var isTextEnable: Bool? {
        get {
            return objc_getAssociatedObject(self, &Keys.TapOnTextKey) as? Bool ?? true
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &Keys.TapOnTextKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    class func connectFields(fields: [UITextField]) {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i + 1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    open override func awakeFromNib() {
        dynamicFontSize = true
        super.awakeFromNib()
    }
    
    func enableTextChangeEvent(callBack : @escaping TextFieldChangeValueHandler) {
        self.callBackTargetClosure = callBack
    }
    
    func enableTextChangeEventForCollections(alongWith otherButtons: [UITextField?], closure: @escaping TextFieldChangeValueHandler) {
        callBackTargetClosure = closure
        for txtfld in otherButtons {
            if let txtfield = txtfld {
                txtfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
        }
    }
    
    private var callBackTargetClosure: TextFieldChangeValueHandler? {
        get {
            return objc_getAssociatedObject(self, &Keys.TextValueChangeKey) as? TextFieldChangeValueHandler
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &Keys.TextValueChangeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        callBackTargetClosure?(textField)
    }
    
    var dynamicFontSize: Bool {
        set {
                if newValue {
                    if  font != nil {
                        print("")
                    }
                }
        }
        get {
            return false
        }
    }
    
    var selectedID: String {
        get {
            return objc_getAssociatedObject(self, &Keys.AssociatedObjectKey) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &Keys.AssociatedObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var selectedDate: Date {
        get {
            return objc_getAssociatedObject(self, &Keys.TextSelectedDateKey) as? Date ?? Date()
        }
        set {
            objc_setAssociatedObject(self, &Keys.TextSelectedDateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var textFieldValue: String? {
        get {
            return (objc_getAssociatedObject(self, &Keys.TextFieldValueKey) as? String)
        }
        set {
            objc_setAssociatedObject(self, &Keys.TextFieldValueKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func isValidEmail() -> Bool {
        let regex1: String = "\\A[A-Za-z0-9]+([-._][a-z0-9]+)*@([a-z0-9]+(-[a-z0-9]+)*\\.)+[a-z]{2,64}\\z"
        let regex2: String = "^(?=.{1,64}@.{4,64}$)(?=.{6,100}$).*"
        let test1: NSPredicate = NSPredicate.init(format: selfMache, regex1)
        let test2: NSPredicate = NSPredicate.init(format: selfMache, regex2)
        return test1.evaluate(with: self.text) && test2.evaluate(with: self.text)
    }
    
    func setLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(5), height: CGFloat(25)))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPadding() {
        let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(5), height: CGFloat(25)))
        rightView = paddingView
        rightViewMode = .always
    }
    
    func isEmpty() -> Bool {
        return self.text!.isEmpty()
    }
    
    @IBInspectable var rightPadding: CGFloat {
        get {
            return CGFloat(0)
        }
        set {
            let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: newValue, height: newValue))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    @IBInspectable var leftPadding: CGFloat {
        get {
            return CGFloat(0)
        }
        set {
            let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: newValue, height: newValue))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var rightTextView: UIImage? {
        get {
            return nil
        }
        set {
            if newValue != nil {
                let finalImageView = UIImageView.init(image: newValue)
                let views = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: finalImageView.frame.width + 18, height: finalImageView.frame.height)))
                finalImageView.frame.origin.x = 10
                views.addSubview(finalImageView)
                
                finalImageView.contentMode = .scaleAspectFit
                rightView = views
                rightViewMode = .always
            }
        }
    }
    
    @IBInspectable var leftViews: UIImage? {
        get {
            return nil
        }
        set {
            if newValue != nil {
                let finalImageView = UIImageView.init(image: newValue)
                let views = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: finalImageView.frame.width + 18, height: finalImageView.frame.height)))
                finalImageView.frame.origin.x = 10
                views.addSubview(finalImageView)
                
                finalImageView.contentMode = .scaleAspectFit
                leftView = views
                leftViewMode = .always
            }
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
extension UITextField {
    enum TextFldType {
        case defaultSet
        case firstName
        case lastName
        case username
        case email
        case password
    }
    
    var textFieldType: TextFldType {
        set {
            objc_setAssociatedObject(self, &kAssociationKeyTxtfldType, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            if let type = objc_getAssociatedObject(self, &kAssociationKeyTxtfldType) as? TextFldType {
                return type
            } else {
                return .defaultSet
            }
        }
    }
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length //If value has then it will return value
            } else {
                return Int.max //9223372036854775807
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            self.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    //The method is used to cancel the check when use Chinese Pinyin input method.
    //Because the alphabet also appears in the textfield when inputting, we should cancel the check.
    func isInputMethod() -> Bool {
        if let positionRange = self.markedTextRange {
            if  self.position(from: positionRange.start, offset: 0) != nil {
                return true
            }
        }
        return false
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard !self.isInputMethod(), let prospectiveText = self.text, prospectiveText.count > maxLength //set 5 range value
        else {
            return //set value if value is less than max length
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(prospectiveText.prefix(upTo: maxCharIndex)) //.substring(to: maxCharIndex) //to set current indicator after
        selectedTextRange = selection
    }
    
    @IBInspectable var minLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMinLength) as? Int {
                return length //If value has then it will return value
            } else {
                return -1
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMinLength, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func isValidFirstOrLastName() -> Bool {
        guard let text = self.text else {
            return false
        }
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return text.rangeOfCharacter(from: set.inverted) == nil
    }
    
    func isValidUserName() -> Bool {
        let userNameRegEx = "[A-Za-z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*$"
        let userNameTest = NSPredicate(format: selfMache, userNameRegEx)
        return userNameTest.evaluate(with: self.text)
    }
    
    //Strong Passsword
    func isStrongPassword() -> Bool {
        var lowerCaseLetter = false
        var upperCaseLetter = false
        var digit = false
        var specialCharacter = false
        
        guard let text = self.text else {
            return false
        }
        if text.count >= 8 {
            for char in text.unicodeScalars {
                if !lowerCaseLetter {
                    lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
                }
                else if !upperCaseLetter {
                    upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
                }
                else if !digit {
                    digit = CharacterSet.decimalDigits.contains(char)
                }
                else if !specialCharacter {
                    specialCharacter = CharacterSet.punctuationCharacters.contains(char)
                }
            }
            if specialCharacter || (digit && lowerCaseLetter && upperCaseLetter) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}
