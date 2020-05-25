//
//  MBFunctionsDefine.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation

/// Debug print
func DPrint(_ items: Any...) {
    #if DEBUG
    debugPrint(items, separator: "\n", terminator: "\n")
    #else
    #endif
}
/// debug print
func DPrintWithoutLineBreak(_ items: Any...) {
    #if DEBUG
    debugPrint(items, separator: "\n", terminator: "")
    #else
    #endif
}
