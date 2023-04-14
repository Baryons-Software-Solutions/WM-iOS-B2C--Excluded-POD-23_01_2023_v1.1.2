//
//  DictionaryExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func string(forKey key: Key) -> String {
        guard let value = self [key] else {
            return ""
        }
        var str = ""
        if let val = value as? NSString {
            str = val as String
        } else if let val = value as? NSNumber {
            str = val.stringValue
        } else if let val = value as? Double {
            str = String.init(format: "%ld", val)
        } else if let val = value as? Int {
            str = String.init(format: "%i", val)
        } else if value is NSNull {
            str = ""
        } else {
            str = ""
        }
        return str
    }
    
    func bool(forKey key: Key) -> Bool {
        return self.string(forKey: key).boolValue()
    }
    
    func integer(forkey key: Key) -> Int {
        return self.string(forKey: key).integerValue()
    }
    
    func double(forkey key: Key) -> Double {
        return self.string(forKey: key).doubleValue()
    }
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func jsonString() -> String {
        return json
    }
}
