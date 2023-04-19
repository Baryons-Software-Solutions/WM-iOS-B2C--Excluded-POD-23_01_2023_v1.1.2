//
//  AppDelegate.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var brownGrey: UIColor {
        return UIColor(red: 146.0 / 255.0, green: 146.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var orangeGrey: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 111.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var salmonPink: UIColor {
        return UIColor(red: 1.0, green: 119.0 / 255.0, blue: 134.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var salmon: UIColor {
        return UIColor(red: 1.0, green: 139.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var salmonPinkTwo: UIColor {
        return UIColor(red: 252.0 / 255.0, green: 121.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var carnation: UIColor {
        return UIColor(red: 1.0, green: 110.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var rosa: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 136.0 / 255.0, blue: 158.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var greyishBrown1: UIColor {
        return UIColor(red: 70.0 / 255.0, green: 70.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var brownishGrey23: UIColor {
        return UIColor(red: 96.0 / 255.0, green: 96.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var forestGreen: UIColor {
        return UIColor(red: 66.0 / 255.0, green: 125.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var background: UIColor {
        return UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var brownishGrey: UIColor {
        return UIColor(red: 99.0 / 255.0, green: 99.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var cocoa: UIColor {
        return UIColor(red: 143.0 / 255.0, green: 64.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightPink: UIColor {
        return UIColor(red: 1.0, green: 110.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(red: 211.0 / 255.0, green: 211.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var paleBrown: UIColor {
        return UIColor(red: 163.0 / 255.0, green: 138.0 / 255.0, blue: 117.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrownThree: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 56.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var blackThree: UIColor {
        return UIColor(red: 40.0 / 255.0, green: 34.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var whiteFive: UIColor {
        return UIColor(white: 228.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var whiteTwo: UIColor {
        return UIColor(white: 216.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var shadow: UIColor {
        return UIColor(red: 122.0 / 255.0, green: 99.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var warmGrey: UIColor {
        return UIColor(red: 146.0 / 255.0, green: 146.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var cream: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 240.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var lightcream: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 240.0 / 255.0, blue: 220.0 / 255.0, alpha: 0.6)
    }
    @nonobjc class var veryLightPinkTwo: UIColor {
        return UIColor(red: 222 / 255.0, green: 222 / 255.0, blue: 222 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightRed: UIColor {
        return UIColor(red: 254 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightBlue: UIColor {
        return UIColor(red: 245 / 255.0, green: 249 / 255.0, blue: 252 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightBrown: UIColor {
        return UIColor(red: 176 / 255.0, green: 131 / 255.0, blue: 92 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tan: UIColor {
        return UIColor(red: 213 / 255.0, green: 175 / 255.0, blue: 109 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrownSeven: UIColor {
        return UIColor(red: 77 / 255.0, green: 77 / 255.0, blue: 77 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightMaroon: UIColor {
        return UIColor(red: 155 / 255.0, green: 78 / 255.0, blue: 87 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteEleven: UIColor {
        return UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteNine: UIColor {
        return UIColor(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mushroom: UIColor {
        return UIColor(red: 181 / 255.0, green: 161 / 255.0, blue: 144 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteTen: UIColor {
        return UIColor(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var badgeCountColor: UIColor {
        return UIColor(red: 180 / 255.0, green: 97 / 255.0, blue: 105 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteFifteen: UIColor {
        return UIColor(red: 225 / 255.0, green: 225 / 255.0, blue: 225 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grassyGreen: UIColor {
        return UIColor(red: 45 / 255.0, green: 184 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmGreyFour: UIColor {
        return UIColor(red: 120 / 255.0, green: 120 / 255.0, blue: 120 / 255.0, alpha: 1.0)
    }
    @nonobjc class var appYellow: UIColor {
        return UIColor(red: 224 / 255.0, green: 173 / 255.0, blue: 6 / 255.0, alpha: 1.0)
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hexFromString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
}
