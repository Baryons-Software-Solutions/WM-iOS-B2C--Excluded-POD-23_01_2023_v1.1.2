//
//  UIFontExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UIFont {
    func scaleFont() -> UIFont {
        return UIFont.init(name: self.fontName, size: self.pointSize.scaledFontSize)!
    }
}
