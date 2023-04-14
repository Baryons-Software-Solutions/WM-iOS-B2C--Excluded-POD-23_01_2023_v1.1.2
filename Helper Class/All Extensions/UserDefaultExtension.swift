//
//  UserDefaultExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UserDefaults {
    // MARK: user default
    func removeDataForKey(_ key: UserDefaultsKeys) {
        self.removeObject(forKey: key.rawValue)
    }
    
    func setDataForKey(_ data: Any, _ key: UserDefaultsKeys) {
        self.set(data, forKey: key.rawValue)
    }
    
    func getDataForKey( _ key: UserDefaultsKeys) -> AnyObject {
        return object(forKey: key.rawValue) as AnyObject
    }
    
    func getDoubleForKey( _ key: UserDefaultsKeys) -> Double {
        return double(forKey: key.rawValue)
    }
    func getIntegerForKey( _ key: UserDefaultsKeys) -> Int {
        return Int(key.rawValue)!
    }
}
