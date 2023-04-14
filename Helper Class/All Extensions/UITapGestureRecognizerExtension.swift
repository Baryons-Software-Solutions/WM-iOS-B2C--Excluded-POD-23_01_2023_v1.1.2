//
//  UITapGestureRecognizerExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UITapGestureRecognizer {
    func callBackTarget(closure: @escaping GestureCallBackClosure) {
        callBackTargetClosure = closure
    }
    
    func invokeCallBackClosure() {
        if let callBack = callBackTargetClosure {
            callBack(self)
        }
    }
    
    private var callBackTargetClosure: GestureCallBackClosure? {
        get {
            return objc_getAssociatedObject(self, &Keys.buttonClosure) as? GestureCallBackClosure
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &Keys.buttonClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                addTarget(self, action: #selector(clickOnClosureButton(_:)))
            }
        }
    }
    
    @objc private func clickOnClosureButton(_ sender: UITapGestureRecognizer) {
        if let callBack = callBackTargetClosure {
            callBack(sender)
        }
    }
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint.init(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint.init(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
                                                            locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
