//
//  CEFRange.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing a range.
/// CEF name: `cef_range_t`
public struct CEFRange {
    /// CEF name: `from`
    public var from: Int
    /// CEF name: `to`
    public var to: Int
}

extension CEFRange {
    func toCEF() -> cef_range_t {
        return cef_range_t(from: Int32(from), to: Int32(to))
    }
    
    static func fromCEF(_ value: cef_range_t) -> CEFRange {
        return CEFRange(from: Int(value.from), to: Int(value.to))
    }
}
