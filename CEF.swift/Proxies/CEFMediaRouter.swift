//
//  CEFMediaRouter.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMediaRouter {
    /// Returns the MediaRouter object associated with the global request context.
    /// If |callback| is non-NULL it will be executed asnychronously on the UI
    /// thread after the manager's storage has been initialized. Equivalent to
    /// calling CefRequestContext::GetGlobalContext()->GetMediaRouter().
    /// CEF name: `GetGlobalMediaRouter`
    static func getGlobal(callback: CEFCompletionCallback? = nil) -> CEFMediaRouter {
        let cefCallbackPtr = callback?.toCEF()
        let cefRouter = cef_media_router_get_global(cefCallbackPtr)
        return CEFMediaRouter.fromCEF(cefRouter)!
    }
    
    /// Add an observer for MediaRouter events. The observer will remain registered
    /// until the returned Registration object is destroyed.
    /// CEF name: `AddObserver`
    func addObserver(_ observer: CEFMediaObserver) -> CEFRegistration {
        let cefReg = cefObject.add_observer(cefObjectPtr, observer.toCEF())
        return CEFRegistration.fromCEF(cefReg)!
    }
    
    /// Returns a MediaSource object for the specified media source URN. Supported
    /// URN schemes include "cast:" and "dial:", and will be already known by the
    /// client application (e.g. "cast:<appId>?clientId=<clientId>").
    /// CEF name: `GetSource`
    func source(for urn: String) -> CEFMediaSource? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(urn)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefSource = cefObject.get_source(cefObjectPtr, cefStrPtr)
        return CEFMediaSource.fromCEF(cefSource)
    }
    
    /// Trigger an asynchronous call to CefMediaObserver::OnSinks on all
    /// registered observers.
    /// CEF name: `NotifyCurrentSinks`
    func notifyCurrentSinks() {
        cefObject.notify_current_sinks(cefObjectPtr)
    }

    /// Create a new route between |source| and |sink|. Source and sink must be
    /// valid, compatible (as reported by CefMediaSink::IsCompatibleWith), and a
    /// route between them must not already exist. |callback| will be executed
    /// on success or failure. If route creation succeeds it will also trigger an
    /// asynchronous call to CefMediaObserver::OnRoutes on all registered
    /// observers.
    /// CEF name: `CreateRoute`
    func createRoute(from source: CEFMediaSource, to sink: CEFMediaSink, callback: CEFMediaRouteCreateCallback) {
        cefObject.create_route(cefObjectPtr, source.toCEF(), sink.toCEF(), callback.toCEF())
    }
    
    /// Trigger an asynchronous call to CefMediaObserver::OnRoutes on all
    /// registered observers.
    /// CEF name: `NotifyCurrentRoutes`
    func notifyCurrentRoutes() {
        cefObject.notify_current_routes(cefObjectPtr)
    }
}

public extension CEFMediaRouter {
    /// Create a new route between |source| and |sink|. Source and sink must be
    /// valid, compatible (as reported by CefMediaSink::IsCompatibleWith), and a
    /// route between them must not already exist. |callback| will be executed
    /// on success or failure. If route creation succeeds it will also trigger an
    /// asynchronous call to CefMediaObserver::OnRoutes on all registered
    /// observers.
    /// CEF name: `CreateRoute`
    func createRoute(from source: CEFMediaSource, to sink: CEFMediaSink, block: @escaping CEFMediaRouteCreateCallbackOnMediaRouteCreateFinishedBlock) {
        createRoute(from: source, to: sink, callback: CEFMediaRouteCreateCallbackBridge(block: block))
    }
}
