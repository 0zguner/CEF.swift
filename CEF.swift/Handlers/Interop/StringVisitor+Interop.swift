//
//  StringVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func StringVisitor_visit(ptr: UnsafeMutablePointer<cef_string_visitor_t>,
                         string: UnsafePointer<cef_string_t>) {
    guard let obj = StringVisitorMarshaller.get(ptr) else {
        return
    }
    
    obj.visit(string != nil ? CEFStringToSwiftString(string.memory) : nil)
}

