//
//  FloatExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension Float {
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
extension CGFloat {
    var scaledFontSize: CGFloat {
        var width = UIScreen.main.bounds.width // portrait
        if UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
            width = UIScreen.main.bounds.size.height // landscap
        }
        return CGFloat(self) * (width / (iPAD ? 750 : 320))
    }
    
    var intergerValue: Int {
        return Int(self)
    }
}
