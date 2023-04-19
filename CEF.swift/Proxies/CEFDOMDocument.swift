//
//  CEFDOMDocument.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDOMDocument {
    
    /// Returns the document type.
    /// CEF name: `GetType`
    var type: CEFDOMDocumentType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFDOMDocumentType.fromCEF(cefType)
    }

    /// Returns the root document node.
    /// CEF name: `GetDocument`
    var document: CEFDOMNode? {
        let cefNode = cefObject.get_document(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the BODY node of an HTML document.
    /// CEF name: `GetBody`
    var body: CEFDOMNode? {
        let cefNode = cefObject.get_body(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the HEAD node of an HTML document.
    /// CEF name: `GetHead`
    var head: CEFDOMNode? {
        let cefNode = cefObject.get_head(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    /// Returns the title of an HTML document.
    /// CEF name: `GetTitle`
    var title: String {
        let cefStrPtr = cefObject.get_title(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }

    /// Returns the document element with the specified ID value.
    /// CEF name: `GetElementById`
    func element(id: String) -> CEFDOMNode? {
        let cefIDPtr = CEFStringPtrCreateFromSwiftString(id)
        defer { CEFStringPtrRelease(cefIDPtr) }
        let cefNode = cefObject.get_element_by_id(cefObjectPtr, cefIDPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the node that currently has keyboard focus.
    /// CEF name: `GetFocusedNode`
    var focusedNode: CEFDOMNode? {
        let cefNode = cefObject.get_focused_node(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    /// Returns true if a portion of the document is selected.
    /// CEF name: `HasSelection`
    var hasSelection: Bool {
        return cefObject.has_selection(cefObjectPtr) != 0
    }
    
    /// Returns the selection offset within the start node.
    /// CEF name: `GetSelectionStartOffset`
    var selectionStartOffset: Int {
        return Int(cefObject.get_selection_start_offset(cefObjectPtr))
    }

    /// Returns the selection offset within the end node.
    /// CEF name: `GetSelectionEndOffset`
    var selectionEndOffset: Int {
        return Int(cefObject.get_selection_end_offset(cefObjectPtr))
    }

    /// Returns the contents of this selection as markup.
    /// CEF name: `GetSelectionAsMarkup`
    var selectionAsMarkup: String {
        let cefStrPtr = cefObject.get_selection_as_markup(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the contents of this selection as text.
    /// CEF name: `GetSelectionAsText`
    var selectionAsText: String {
        let cefStrPtr = cefObject.get_selection_as_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the base URL for the document.
    /// CEF name: `GetBaseURL`
    var baseURL: URL? {
        let cefURLPtr = cefObject.get_base_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        guard let str = CEFStringPtrToSwiftString(cefURLPtr) else {
            return nil
        }
        return URL(string: str)
    }
    
    /// Returns a complete URL based on the document base URL and the specified
    /// partial URL.
    /// CEF name: `GetCompleteURL`
    func completeURLWithRelativePart(relativePart: String) -> URL? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(relativePart)
        let cefURLPtr = cefObject.get_complete_url(cefObjectPtr, cefStrPtr)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        guard let str = CEFStringPtrToSwiftString(cefURLPtr) else {
            return nil
        }
        return URL(string: str)
    }
    
}

