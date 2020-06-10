//
//  ArrayExtension.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

extension Array {
    
    // remove repeat
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
    
    
    
}

extension Array where Element == String {
    /// back to the first letter
    public func groupByFirstLetter() -> Dictionary<String, [String]> {
        var dic = Dictionary<String, [String]>()
        for item in self {
            let first = item.firstLetter
            if dic[first] != nil {
                dic[first]?.append(item)
            }else {
                dic[first] = [item]
            }
        }
        return dic
    }
}
