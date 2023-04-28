//
//  DataSequenceExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension Data {
    var hexString: String {
        let hexString1 = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString1
    }
}

extension Sequence {
    func group<U: Hashable>(by: (Element) -> U) -> [(U, [Element])] {
        var groupCategorized: [(U, [Element])] = []
        for item in self {
            let groupKey = by(item)
            guard let index = groupCategorized.firstIndex(where: { $0.0 == groupKey }) else { groupCategorized.append((groupKey, [item])); continue }
            groupCategorized[index].1.append(item)
        }
        return groupCategorized
    }
}
