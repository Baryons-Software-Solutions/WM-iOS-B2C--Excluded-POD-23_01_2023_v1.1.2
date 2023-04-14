//
//  FooterView.swift
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

// This FooterView class used for creating the footer table cell
import UIKit

class FooterView: UIView {
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    class var sharedInstance: FooterView {
        struct Static {
            static let instance = FooterView()
        }
        return Static.instance
    }
    
    class func defaultView() -> FooterView {
        return UINib(nibName: "FooterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? FooterView ?? FooterView()
    }
    
    class func defaultActivityView() -> FooterView {
        let view = FooterView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: UIScreen.main.bounds.width, height: 50)))
        return view
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
}
