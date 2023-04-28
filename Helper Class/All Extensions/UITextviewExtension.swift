//
//  UITextviewExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
//  Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UITextView {
    
    open override func awakeFromNib() {
        dynamicFontSize = true
    }
    
    var dynamicFontSize: Bool {
        set {
                if font != nil {
                    //   font = fonts.scaleFont()
                    
                    // font = UIFont(name: (font!.fontName), size: (font?.pointSize)! * (UIScreen.main.bounds.size.width/320))
                }
        }
        get {
            return false
        }
    }
    
    func removeExtraPedding() {
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
    }
}
