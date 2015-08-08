//
//  CEFFocusHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_focus_handler_t: CEFObject {
}

typealias CEFFocusHandlerMarshaller = CEFMarshaller<CEFFocusHandler, cef_focus_handler_t>

extension CEFFocusHandler {
    func toCEF() -> UnsafeMutablePointer<cef_focus_handler_t> {
        return CEFFocusHandlerMarshaller.pass(self)
    }
}

extension cef_focus_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_take_focus = CEFFocusHandler_onTakeFocus
        on_set_focus = CEFFocusHandler_onSetFocus
        on_got_focus = CEFFocusHandler_onGotFocus
    }
}


func CEFFocusHandler_onTakeFocus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 next: Int32) {
    guard let obj = CEFFocusHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onTakeFocus(CEFBrowser.fromCEF(browser)!, next: next != 0)
}

func CEFFocusHandler_onSetFocus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 source: cef_focus_source_t) -> Int32 {
    guard let obj = CEFFocusHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onSetFocus(CEFBrowser.fromCEF(browser)!,
                          source: CEFFocusSource.fromCEF(source)) ? 1 : 0
}

func CEFFocusHandler_onGotFocus(ptr: UnsafeMutablePointer<cef_focus_handler_t>,
                                browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFFocusHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onGotFocus(CEFBrowser.fromCEF(browser)!)
}

