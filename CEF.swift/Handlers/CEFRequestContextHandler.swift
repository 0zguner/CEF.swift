//
//  CEFRequestContextHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnBeforePluginLoadAction {
    case overridePolicy(CEFPluginPolicy)
    case useDefaultPolicy
}

extension CEFOnBeforePluginLoadAction {
    public var boolValue: Bool {
        if case .useDefaultPolicy = self {
            return false
        }
        return true
    }
}

/// Implement this interface to provide handler implementations. The handler
/// instance will not be released until all objects related to the context have
/// been destroyed.
/// CEF name: `CefRequestContextHandler`
public protocol CEFRequestContextHandler {
    
    /// Called on the browser process IO thread to retrieve the cookie manager. If
    /// this method returns NULL the default cookie manager retrievable via
    /// CefRequestContext::GetDefaultCookieManager() will be used.
    /// CEF name: `GetCookieManager`
    var cookieManager: CEFCookieManager? { get }
    
    /// Called on multiple browser process threads before a plugin instance is
    /// loaded. |mime_type| is the mime type of the plugin that will be loaded.
    /// |plugin_url| is the content URL that the plugin will load and may be empty.
    /// |top_origin_url| is the URL for the top-level frame that contains the
    /// plugin when loading a specific plugin instance or empty when building the
    /// initial list of enabled plugins for 'navigator.plugins' JavaScript state.
    /// |plugin_info| includes additional information about the plugin that will be
    /// loaded. |plugin_policy| is the recommended policy. Modify |plugin_policy|
    /// and return true to change the policy. Return false to use the recommended
    /// policy. The default plugin policy can be set at runtime using the
    /// `--plugin-policy=[allow|detect|block]` command-line flag. Decisions to mark
    /// a plugin as disabled by setting |plugin_policy| to PLUGIN_POLICY_DISABLED
    /// may be cached when |top_origin_url| is empty. To purge the plugin list
    /// cache and potentially trigger new calls to this method call
    /// CefRequestContext::PurgePluginListCache.
    /// CEF name: `OnBeforePluginLoad`
    func onBeforePluginLoad(mimeType: String,
                            pluginURL: NSURL?,
                            topOriginURL: NSURL?,
                            pluginInfo: CEFWebPluginInfo,
                            defaultPolicy: CEFPluginPolicy) -> CEFOnBeforePluginLoadAction

}


public extension CEFRequestContextHandler {
    
    var cookieManager: CEFCookieManager? { return nil }

    func onBeforePluginLoad(mimeType: String,
                            pluginURL: NSURL?,
                            topOriginURL: NSURL?,
                            pluginInfo: CEFWebPluginInfo,
                            defaultPolicy: CEFPluginPolicy) -> CEFOnBeforePluginLoadAction {
        return .useDefaultPolicy
    }
}

