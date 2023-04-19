//
//  CEFPreferenceManager+Interop.swift
//  CEF.swift
//
//  Created by Joe Bay on 2/27/23.
//  Copyright © 2023 Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFPreferenceManager_has_preference(ptr: UnsafeMutablePointer<cef_preference_manager_t>?,
                                    name: UnsafePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFPreferenceManagerMarshaller.get(ptr) else {
        return 0
    }
    
    let result = obj.hasPreference(for: CEFStringToSwiftString(name!.pointee))
    return result == true ? 1 : 0
}
