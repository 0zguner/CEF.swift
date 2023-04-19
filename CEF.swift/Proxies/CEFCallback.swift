//
//  CEFCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 04..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFCallback {

    /// Continue processing.
    /// CEF name: `Continue`
    func doContinue() {
        cefObject.cont(cefObjectPtr)
    }
    
    /// Cancel processing.
    /// CEF name: `Cancel`
    func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }

}

