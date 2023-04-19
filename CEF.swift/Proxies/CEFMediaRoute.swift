//
//  CEFMediaRoute.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMediaRoute {
    /// Returns the ID for this route.
    /// CEF name: `GetId`
    var id: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns the source associated with this route.
    /// CEF name: `GetSource`
    var source: CEFMediaSource? {
        let cefSource = cefObject.get_source(cefObjectPtr)
        return CEFMediaSource.fromCEF(cefSource)
    }
    
    /// Returns the sink associated with this route.
    /// CEF name: `GetSink`
    var sink: CEFMediaSink? {
        let cefSink = cefObject.get_sink(cefObjectPtr)
        return CEFMediaSink.fromCEF(cefSink)
    }

    /// Send a message over this route. |message| will be copied if necessary.
    /// CEF name: `SendRouteMessage`
    func sendRouteMessage(_ messageData: Data) {
        withUnsafeBytes(of: messageData) { ptr in
            cefObject.send_route_message(cefObjectPtr, ptr.baseAddress, messageData.count)
        }
    }
    
    /// Terminate this route. Will result in an asynchronous call to
    /// CefMediaObserver::OnRoutes on all registered observers.
    /// CEF name: `Terminate`
    func terminate() {
        cefObject.terminate(cefObjectPtr)
    }
}
