//
//  DictionaryExtension.swift
//  EHealthHanAn
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation

extension Dictionary {
    /// transfer json
    public func toJsonString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let jsonStr = String(data: jsonData, encoding: .utf8)
            return jsonStr ?? ""
        }catch {
            return ""
        }
    }

}
