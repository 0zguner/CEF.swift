//
//  CEFTime.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFTimeToSwiftDate(_ cefTime: cef_time_t) -> Date {
    var time: Double = 0;
    var tmpTime = cefTime
    cef_time_to_doublet(&tmpTime, &time)
    return Date(timeIntervalSince1970: time)
}

func BasetimeToSwiftDate(_ basetime: cef_basetime_t) -> Date {
    var cefTime = cef_time_t()
    cef_time_from_basetime(basetime, &cefTime)
    return CEFTimeToSwiftDate(cefTime)
}

func TimeToSwiftDate(_ cefTime: cef_time_t) -> Date {
    var time: Double = 0;
    var tmpTime = cefTime
    cef_time_to_doublet(&tmpTime, &time)
    return Date(timeIntervalSince1970: time)
}


func CEFTimePtrCreateFromSwiftDate(_ date: Date) -> UnsafeMutablePointer<cef_time_t> {
    let cefTime = UnsafeMutablePointer<cef_time_t>.allocate(capacity: 1)
    CEFTimeSetFromSwiftDate(date, cefTimePtr: cefTime)
    return cefTime
}

func CEFBasetimePtrCreateFromSwiftDate(_ date: Date) -> UnsafeMutablePointer<cef_basetime_t> {
    let basetime = UnsafeMutablePointer<cef_basetime_t>.allocate(capacity: 1)
    CEFBasetimeSetFromSwiftDate(date, basetimePtr: basetime)
    return basetime
}

func CEFTimePtrRelease(_ ptr: UnsafeMutablePointer<cef_time_t>?) {
    if let ptr = ptr {
        ptr.deallocate()
    }
}

func CEFBasetimePtrRelease(_ ptr: UnsafeMutablePointer<cef_basetime_t>?) {
    if let ptr = ptr {
        ptr.deallocate()
    }
}

func CEFTimeSetFromSwiftDate(_ date: Date, cefTimePtr ptr: UnsafeMutablePointer<cef_time_t>) {
    cef_time_from_doublet(date.timeIntervalSince1970, ptr)
}

func CEFBasetimeSetFromSwiftDate(_ date: Date, basetimePtr ptr: UnsafeMutablePointer<cef_basetime_t>) {
    var cefTime = cef_time_t()
    cef_time_from_doublet(date.timeIntervalSince1970, &cefTime)
    cef_time_to_basetime(&cefTime, ptr)
}
