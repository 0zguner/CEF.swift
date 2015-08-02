//
//  CEFSetCookieCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFSetCookieCallback {
    
    func onComplete(success: Bool)
    
}


public extension CEFSetCookieCallback {
    
    func onComplete(success: Bool) {
    }
    
}
