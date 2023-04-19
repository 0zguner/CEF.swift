//
//  CEFNavigationEntryVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFNavigationEntryVisitorAction {
    case continueVisiting
    case stop
}

/// Callback interface for CefBrowserHost::GetNavigationEntries. The methods of
/// this class will be called on the browser process UI thread.
/// CEF name: `CefNavigationEntryVisitor`
public protocol CEFNavigationEntryVisitor {
    
    /// Method that will be executed. Do not keep a reference to |entry| outside of
    /// this callback. Return true to continue visiting entries or false to stop.
    /// |current| is true if this entry is the currently loaded navigation entry.
    /// |index| is the 0-based index of this entry and |total| is the total number
    /// of entries.
    /// CEF name: `Visit`
    func visit(entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> CEFNavigationEntryVisitorAction
    
}


public extension CEFNavigationEntryVisitor {
    
    func visit(entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> CEFNavigationEntryVisitorAction {
        return .stop
    }
    
}

