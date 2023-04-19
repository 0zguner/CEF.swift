//
//  CEFMediaSink.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMediaSink {
    /// Returns the ID for this sink.
    /// CEF name: `GetId`
    var id: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns the name of this sink.
    /// CEF name: `GetName`
    var name: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns the description of this sink.
    /// CEF name: `GetDescription`
    var description: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns the icon type for this sink.
    /// CEF name: `GetIconType`
    var iconType: CEFMediaSinkIconType {
        let cefType = cefObject.get_icon_type(cefObjectPtr)
        return CEFMediaSinkIconType.fromCEF(cefType)
    }
    
    /// Asynchronously retrieves device info.
    /// CEF name: `GetDeviceInfo`
    func getDeviceInfo(callback: CEFMediaSinkDeviceInfoCallback) {
        cefObject.get_device_info(cefObjectPtr, callback.toCEF())
    }

    /// Returns true if this sink accepts content via Cast.
    /// CEF name: `IsCastSink`
    var isCastSink: Bool {
        return cefObject.is_cast_sink(cefObjectPtr) != 0
    }

    /// Returns true if this sink accepts content via DIAL.
    /// CEF name: `IsDialSink`
    var isDialSink: Bool {
        return cefObject.is_dial_sink(cefObjectPtr) != 0
    }

    /// Returns true if this sink is compatible with |source|.
    /// CEF name: `IsCompatibleWith`
    func isCompatible(with source: CEFMediaSource) -> Bool {
        return cefObject.is_compatible_with(cefObjectPtr, source.toCEF()) != 0
    }
}

public extension CEFMediaSink {
    /// Asynchronously retrieves device info.
    /// CEF name: `GetDeviceInfo`
    func getDeviceInfo(block: @escaping CEFMediaSinkDeviceInfoCallbackOnMediaSinkDeviceInfoBlock) {
        getDeviceInfo(callback: CEFMediaSinkDeviceInfoCallbackBridge(block: block))
    }
}
