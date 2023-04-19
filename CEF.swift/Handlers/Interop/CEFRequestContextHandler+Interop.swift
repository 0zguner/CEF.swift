//
//  CEFRequestContextHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRequestContextHandler_on_request_context_initialized(ptr: UnsafeMutablePointer<cef_request_context_handler_t>?,
                                                             context: UnsafeMutablePointer<cef_request_context_t>?) {
    guard let obj = CEFRequestContextHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onRequestContextInitialized(context: CEFRequestContext.fromCEF(context)!)
}

func CEFRequestContextHandler_get_resource_request_handler(ptr: UnsafeMutablePointer<cef_request_context_handler_t>?,
                                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                                           frame: UnsafeMutablePointer<cef_frame_t>?,
                                                           request: UnsafeMutablePointer<cef_request_t>?,
                                                           isNavigation: Int32,
                                                           isDownload: Int32,
                                                           initiator: UnsafePointer<cef_string_t>?,
                                                           disableDefault: UnsafeMutablePointer<Int32>?) -> UnsafeMutablePointer<cef_resource_request_handler_t>? {
    guard let obj = CEFRequestContextHandlerMarshaller.get(ptr) else {
        return nil
    }

    var disableFlag = false
    
    let handler = obj.onResourceRequest(browser: CEFBrowser.fromCEF(browser),
                                        frame: CEFFrame.fromCEF(frame),
                                        request: CEFRequest.fromCEF(request)!,
                                        isNavigation: isNavigation != 0,
                                        isDownload: isDownload != 0,
                                        initiator: initiator != nil ? CEFStringToSwiftString(initiator!.pointee) : nil,
                                        disableDefault: &disableFlag)
    
    disableDefault?.pointee = disableFlag ? 1 : 0
    return handler?.toCEF()
}
