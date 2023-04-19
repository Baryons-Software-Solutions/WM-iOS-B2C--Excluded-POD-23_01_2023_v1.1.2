//
//  UITableviewExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UITableView {
    var isShowFooter: Bool {
        get {
            return (objc_getAssociatedObject(self, &Keys.footer) != nil)
        }
        set {
            objc_setAssociatedObject(self, &Keys.footer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addActivityAtFooter(tableView: self, isShow: newValue)
        }
    }
    
    var refreshControlLower: UIRefreshControl? {
        get {
            return objc_getAssociatedObject(self, &Keys.control) as? UIRefreshControl
        }
        set {
            objc_setAssociatedObject(self, &Keys.control, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func enableRefreshControl(closure: @escaping EmptyCallBackClosure) {
        callBackOfRefreshControl = closure
    }
    
    private var callBackOfRefreshControl: EmptyCallBackClosure? {
        get {
            return objc_getAssociatedObject(self, &Keys.closure) as? EmptyCallBackClosure
        }
        set {
            objc_setAssociatedObject(self, &Keys.closure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue != nil {
                if #available(iOS 10.0, *) {
                    refreshControlLower = UIRefreshControl()
                    addSubview(self.refreshControlLower!)
                    refreshControlLower?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
                }
            }
        }
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        if let callBack = callBackOfRefreshControl {
            callBack()
        }
    }
}
