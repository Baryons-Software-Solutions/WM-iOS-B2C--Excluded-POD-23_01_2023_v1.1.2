//
//  StringProtocolExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.

import Foundation
extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert(separator: Self, every intValue: Int) {
        for index in indices.reversed() where index != startIndex &&
        distance(from: startIndex, to: index) % intValue == 0 {
            insert(contentsOf: separator, at: index)
        }
    }
    
    func inserting(separator: Self, every intValue: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: intValue)
        return string
    }
}
