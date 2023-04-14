//
//  AppStaticTetManager.swift
//  TraderPhD
//
//  Created by tech.us on 5/6/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 tech.us. All rights reserved.
//

//This AppStaticTextManger class is used common string file

import UIKit



enum AppStaticTextManager: String {
    
    case supplierName          = "Suppliers"
    case searchPlaceholder     = ""
    case supplierNotFound      = "Supplier List Not Found."
    
    var text: String {
        if let instructionValue = AppSingleton.shared.AppStaticTextManager?["\(self)"] {
            return instructionValue ?? self.rawValue
        }
        return self.rawValue
    }
}

class AppSingleton {
    static let shared = AppSingleton()
    var AppStaticTextManager: [String:String?]?
}
