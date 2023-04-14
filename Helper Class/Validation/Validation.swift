//
//  Validation.swift
//Created by Mac on 16/06/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

// This validation used for validation perpose
import UIKit
import Foundation

struct Validation{
    
    func isEmpty(txtField: Any) -> Bool {
        let value: String = (txtField as AnyObject).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (value.count ) == 0 {
            return true
        }
        return false
    }
    // This methods are validating the Names
    func isValidateFirstName(fname: String) -> Bool {
        // let nameRegex = "^[A-Za-z]+[a-zA-Z0-9'_.-@#]*${5,}"
        let nameRegex = "[a-zA-Z0-9. ]{1,25}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: fname)
    }
    // This methods are validating the Password
    func isValidatePassword(fname: String) -> Bool {
        // let nameRegex = "^[A-Za-z]+[a-zA-Z0-9'_.-@#]*${5,}"
        let nameRegex = "((?=.*\\d)(?=.*[a-zA-Z0-9])(?=.*[@#$%{}<>_]).{6,16})"
        //let nameRegex = "((?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16})"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: fname)
    }
    // This method are used for checking the min leangth and max leangth
    func checkMinAndMaxLength(txtField: String, withMinLimit minLen: Int, withMaxLimit maxLen: Int) -> Bool {
        if (txtField.count ) >= minLen && (txtField.count ) <= maxLen {
            return true
        }
        return false
    }
    // This method are used for checking password leangth
    func isPasswordLength(password: String) -> Bool {
        if (password.count >= 8 && password.count <= 15) {
            return true
        }
        else{
            return false
        }
    }
    // This method is used for password validation
    func isPasswordValidate(value: String) -> Bool {
        
        let PWD_REGEX = "^[A-Za-z]+[a-zA-Z0-9'_.-@#]*${5,}"
        let pwd = NSPredicate(format: "SELF MATCHES %@", PWD_REGEX)
        let result =  pwd.evaluate(with: value)
        return result
    }
    
    func isValidateFullName(fname: String) -> Bool {
        let nameRegex = "^[A-Za-z][a-zA-Z0-9-\\'\\-]{0,}(?: [A-Za-z0-9][a-zA-Z0-9-\\'\\-]*)$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: fname)
    }
    
    // This methid is used for valid email adderess
    func isEmailValidate(testStr:String) -> Bool {
        
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    // This method is used for phonr number leangth
    func isPhonenumberLength(phone: String) -> Bool {
        if (phone.count > 11) {
            return true
        }
        else{
            return false
        }
    }
    //This method is used for zipcode.
    func isZipcode(phone: String) -> Bool {
        if (phone.count > 6) {
            return true
        }
        else{
            return false
        }
    }
    func validate(value: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let components = value.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        return value == filtered
    }
    
    func isNull(_ object: NSObject) -> Bool {
        if (object is String) {
            return ((object as? String) == "") || ((object as? String) == "null") || ((object as? String) == "nil") || ((object as? String) == "(null)") || ((object as? String) == "<null>")
        }
        else if object == NSNull() {
            return true
        }
        
        return false
    }
    //This method is used for user name validation
    func isUserNameValidate(_ stringName:String) -> Bool {
        var sepcialChar = false
        var temp = false
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        if stringName.rangeOfCharacter(from: characterset.inverted) != nil {
            sepcialChar = true
        }
        else {
            temp = true
        }
        let phone = stringName.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if phone != "" || sepcialChar == true {
            temp = false
            for chr in stringName {
                if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z") ) {
                    temp = true
                    break
                }
            }
        }
        if temp == true {
            return true
        }
        else {
            return false
        }
    }
    
}
