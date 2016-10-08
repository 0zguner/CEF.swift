//
//  CEFTaskUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFTaskUtils {
    
    /// Returns true if called on the specified thread. Equivalent to using
    /// CefTaskRunner::GetForThread(threadId)->BelongsToCurrentThread().
    /// CEF name: `CefCurrentlyOn`
    public static func isCurrentlyOnThread(threadID: CEFThreadID) -> Bool {
        return cef_currently_on(threadID.toCEF()) != 0
    }

    /// Post a task for execution on the specified thread. Equivalent to
    /// using CefTaskRunner::GetForThread(threadId)->PostTask(task).
    /// CEF name: `CefPostTask`
    public static func postTask(task: CEFTask, onThread threadID: CEFThreadID) -> Bool {
        return cef_post_task(threadID.toCEF(), task.toCEF()) != 0
    }

    /// Post a task for execution on the specified thread. Equivalent to
    /// using CefTaskRunner::GetForThread(threadId)->PostTask(task).
    /// CEF name: `CefPostTask`
    public static func postTaskOnThread(threadID: CEFThreadID, block: @escaping CEFTaskExecuteBlock) -> Bool {
        let task = CEFTaskBridge(block: block)
        return cef_post_task(threadID.toCEF(), task.toCEF()) != 0
    }

    /// Post a task for delayed execution on the specified thread. Equivalent to
    /// using CefTaskRunner::GetForThread(threadId)->PostDelayedTask(task, delay_ms).
    /// CEF name: `CefPostDelayedTask`
    public static func postTask(task: CEFTask, onThread threadID: CEFThreadID, withDelay delay: TimeInterval) -> Bool {
        return cef_post_delayed_task(threadID.toCEF(), task.toCEF(), Int64(delay * 1000)) != 0
    }

    /// Post a task for delayed execution on the specified thread. Equivalent to
    /// using CefTaskRunner::GetForThread(threadId)->PostDelayedTask(task, delay_ms).
    /// CEF name: `CefPostDelayedTask`
    public static func postTaskOnThread(threadID: CEFThreadID, withDelay delay: TimeInterval, block: @escaping CEFTaskExecuteBlock) -> Bool {
        let task = CEFTaskBridge(block: block)
        return cef_post_delayed_task(threadID.toCEF(), task.toCEF(), Int64(delay * 1000)) != 0
    }

}
