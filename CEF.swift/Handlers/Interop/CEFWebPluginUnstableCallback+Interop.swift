//
//  CEFWebPluginUnstableCallback.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFWebPluginUnstableCallback_isUnstable(ptr: UnsafeMutablePointer<cef_web_plugin_unstable_callback_t>,
                                             path: UnsafePointer<cef_string_t>,
                                             unstable: Int32) {
    guard let obj = CEFWebPluginUnstableCallbackMarshaller.get(ptr) else {
        return
    }

    obj.isUnstable(CEFStringToSwiftString(path.memory), unstable: unstable != 0)
}

