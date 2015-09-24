//
//  GeolocationUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct GeolocationUtils {
    
    /// Request a one-time geolocation update. This function bypasses any user
    /// permission checks so should only be used by code that is allowed to access
    /// location information.
    public static func getGeolocation(callback: GetGeolocationCallback) -> Bool {
        return cef_get_geolocation(callback.toCEF()) != 0
    }

    /// Request a one-time geolocation update. This function bypasses any user
    /// permission checks so should only be used by code that is allowed to access
    /// location information.
    public static func getGeolocation(block: GetGeolocationCallbackOnLocationUpdateBlock) -> Bool {
        return getGeolocation(GetGeolocationCallbackBridge(block: block))
    }

}
