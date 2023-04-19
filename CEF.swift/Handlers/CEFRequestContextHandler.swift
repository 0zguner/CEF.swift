//
//  CEFRequestContextHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to provide handler implementations. The handler
/// instance will not be released until all objects related to the context have
/// been destroyed.
/// CEF name: `CefRequestContextHandler`
public protocol CEFRequestContextHandler {
    
    /// Called on the browser process UI thread immediately after the request
    /// context has been initialized.
    /// CEF name: `OnRequestContextInitialized`
    func onRequestContextInitialized(context: CEFRequestContext)

    /// Called on the browser process IO thread before a resource request is
    /// initiated. The |browser| and |frame| values represent the source of the
    /// request, and may be NULL for requests originating from service workers or
    /// CefURLRequest. |request| represents the request contents and cannot be
    /// modified in this callback. |is_navigation| will be true if the resource
    /// request is a navigation. |is_download| will be true if the resource request
    /// is a download. |request_initiator| is the origin (scheme + domain) of the
    /// page that initiated the request. Set |disable_default_handling| to true to
    /// disable default handling of the request, in which case it will need to be
    /// handled via CefResourceRequestHandler::GetResourceHandler or it will be
    /// canceled. To allow the resource load to proceed with default handling
    /// return NULL. To specify a handler for the resource return a
    /// CefResourceRequestHandler object. This method will not be called if the
    /// client associated with |browser| returns a non-NULL value from
    /// CefRequestHandler::GetResourceRequestHandler for the same request
    /// (identified by CefRequest::GetIdentifier).
    /// CEF name: `GetResourceRequestHandler`
    func onResourceRequest(browser: CEFBrowser?,
                           frame: CEFFrame?,
                           request: CEFRequest,
                           isNavigation: Bool,
                           isDownload: Bool,
                           initiator: String?,
                           disableDefault: inout Bool) -> CEFResourceRequestHandler?
}

public extension CEFRequestContextHandler {

    func onRequestContextInitialized(context: CEFRequestContext) {
    }

    func onResourceRequest(browser: CEFBrowser?,
                           frame: CEFFrame?,
                           request: CEFRequest,
                           isNavigation: Bool,
                           isDownload: Bool,
                           initiator: String?,
                           disableDefault: inout Bool) -> CEFResourceRequestHandler? {
        return nil
    }
}

