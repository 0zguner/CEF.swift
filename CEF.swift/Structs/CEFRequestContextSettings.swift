//
//  CEFRequestContextSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Request context initialization settings. Specify NULL or 0 to get the
/// recommended default values.
/// CEF name: `cef_request_context_settings_t`
public struct CEFRequestContextSettings {
    /// The location where cache data for this request context will be stored on
    /// disk. If this value is non-empty then it must be an absolute path that is
    /// either equal to or a child directory of CefSettings.root_cache_path. If
    /// this value is empty then browsers will be created in "incognito mode" where
    /// in-memory caches are used for storage and no data is persisted to disk.
    /// HTML5 databases such as localStorage will only persist across sessions if a
    /// cache path is specified. To share the global browser cache and related
    /// configuration set this value to match the CefSettings.cache_path value.
    /// CEF name: `cache_path`
    public var cachePath: String = ""

    /// To persist session cookies (cookies without an expiry date or validity
    /// interval) by default when using the global cookie manager set this value to
    /// true (1). Session cookies are generally intended to be transient and most
    /// Web browsers do not persist them. Can be set globally using the
    /// CefSettings.persist_session_cookies value. This value will be ignored if
    /// |cache_path| is empty or if it matches the CefSettings.cache_path value.
    /// CEF name: `persist_session_cookies`
    public var persistSessionCookies: Bool = false
    
    /// To persist user preferences as a JSON file in the cache path directory set
    /// this value to true (1). Can be set globally using the
    /// CefSettings.persist_user_preferences value. This value will be ignored if
    /// |cache_path| is empty or if it matches the CefSettings.cache_path value.
    /// CEF name: `persist_user_preferences`
    public var persistUserPreferences: Bool = false

    /// Comma delimited list of schemes supported by the associated
    /// CefCookieManager.
    /// CEF name: `cookieable_schemes_list`
    public var cookieableSchemesList: String = ""

    /// If |cookieable_schemes_exclude_defaults| is false (0) the
    /// default schemes ("http", "https", "ws" and "wss") will also be supported.
    /// Specifying a |cookieable_schemes_list| value and setting
    /// |cookieable_schemes_exclude_defaults| to true (1) will disable all loading
    /// and saving of cookies for this manager. These values will be ignored if
    /// |cache_path| matches the CefSettings.cache_path value.
    /// CEF name: `cookieable_schemes_exclude_defaults`
    public var cookieableSchemesExcludeDefaults: Bool = false

    /// Comma delimited ordered list of language codes without any whitespace that
    /// will be used in the "Accept-Language" HTTP header. Can be set globally
    /// using the CefSettings.accept_language_list value or overridden on a per-
    /// browser basis using the CefBrowserSettings.accept_language_list value. If
    /// all values are empty then "en-US,en" will be used. This value will be
    /// ignored if |cache_path| matches the CefSettings.cache_path value.
    /// CEF name: `accept_language_list`
    public var acceptLanguageList: String = ""
    
    public init() {
    }
}

extension CEFRequestContextSettings {
    func toCEF() -> cef_request_context_settings_t {
        var cefStruct = cef_request_context_settings_t()
        
        CEFStringSetFromSwiftString(cachePath, cefStringPtr: &cefStruct.cache_path)
        cefStruct.persist_session_cookies = persistSessionCookies ? 1 : 0
        cefStruct.persist_user_preferences = persistUserPreferences ? 1 : 0
        CEFStringSetFromSwiftString(cookieableSchemesList, cefStringPtr: &cefStruct.cookieable_schemes_list)
        cefStruct.cookieable_schemes_exclude_defaults = cookieableSchemesExcludeDefaults ? 1 : 0
        CEFStringSetFromSwiftString(acceptLanguageList, cefStringPtr: &cefStruct.accept_language_list)
        
        return cefStruct
    }
}

extension cef_request_context_settings_t {
    mutating func clear() {
        cef_string_utf16_clear(&cache_path)
        cef_string_utf16_clear(&cookieable_schemes_list)
        cef_string_utf16_clear(&accept_language_list)
    }
}

