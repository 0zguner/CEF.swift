//
//  CEFDragData.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDragData {

    /// Create a new CefDragData object.
    /// CEF name: `Create`
    convenience init?() {
        self.init(ptr: cef_drag_data_create())
    }
    
    /// Returns a copy of the current object.
    /// CEF name: `Clone`
    func clone() -> CEFDragData? {
        let cefData = cefObject.clone(cefObjectPtr)
        return CEFDragData.fromCEF(cefData)
    }

    /// Returns true if this object is read-only.
    /// CEF name: `IsReadOnly`
    var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns true if the drag data is a link.
    /// CEF name: `IsLink`
    var isLink: Bool {
        return cefObject.is_link(cefObjectPtr) != 0
    }

    /// Returns true if the drag data is a text or html fragment.
    /// CEF name: `IsFragment`
    var isFragment: Bool {
        return cefObject.is_fragment(cefObjectPtr) != 0
    }
    
    /// Returns true if the drag data is a file.
    /// CEF name: `IsFile`
    var isFile: Bool {
        return cefObject.is_file(cefObjectPtr) != 0
    }

    /// Return the link URL that is being dragged.
    /// CEF name: `GetLinkURL`
    var linkURL: URL? {
        let cefStrPtr = cefObject.get_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        guard let str = CEFStringPtrToSwiftString(cefStrPtr) else {
            return nil
        }
        return URL(string: str)
    }

    /// Return the title associated with the link being dragged.
    /// CEF name: `GetLinkTitle`
    var linkTitle: String? {
        let cefStrPtr = cefObject.get_link_title(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Return the metadata, if any, associated with the link being dragged.
    /// CEF name: `GetLinkMetadata`
    var linkMetadata: String? {
        let cefStrPtr = cefObject.get_link_metadata(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Return the plain text fragment that is being dragged.
    /// CEF name: `GetFragmentText`
    var fragmentText: String? {
        let cefStrPtr = cefObject.get_fragment_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Return the text/html fragment that is being dragged.
    /// CEF name: `GetFragmentHtml`
    var fragmentHTML: String? {
        let cefStrPtr = cefObject.get_fragment_html(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Return the base URL that the fragment came from. This value is used for
    /// resolving relative URLs and may be empty.
    /// CEF name: `GetFragmentBaseURL`
    var fragmentBaseURL: URL? {
        let cefStrPtr = cefObject.get_fragment_base_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        guard let str = CEFStringPtrToSwiftString(cefStrPtr) else {
            return nil
        }
        return URL(string: str)
    }
    
    /// Return the name of the file being dragged out of the browser window.
    /// CEF name: `GetFileName`
    var fileName: String? {
        let cefStrPtr = cefObject.get_file_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Write the contents of the file being dragged out of the web view into
    /// |writer|. Returns the number of bytes sent to |writer|. If |writer| is
    /// NULL this method will return the size of the file contents in bytes.
    /// Call GetFileName() to get a suggested name for the file.
    /// CEF name: `GetFileContents`
    func getFileContents(writer: CEFStreamWriter? = nil) -> size_t {
        let cefWriter = writer?.toCEF()
        return cefObject.get_file_contents(cefObjectPtr, cefWriter)
    }
    
    /// Retrieve the list of file names that are being dragged into the browser
    /// window.
    /// CEF name: `GetFileNames`
    var fileNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { CEFStringListRelease(cefList) }
        _ = cefObject.get_file_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Set the link URL that is being dragged.
    /// CEF name: `SetLinkURL`
    func setLinkURL(_ url: URL?)  {
        let cefStrPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_url(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the title associated with the link being dragged.
    /// CEF name: `SetLinkTitle`
    func setLinkTitle(_ title: String?)  {
        let cefStrPtr = title != nil ? CEFStringPtrCreateFromSwiftString(title!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_title(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the metadata associated with the link being dragged.
    /// CEF name: `SetLinkMetadata`
    func setLinkMetadata(_ metadata: String?)  {
        let cefStrPtr = metadata != nil ? CEFStringPtrCreateFromSwiftString(metadata!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_metadata(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the plain text fragment that is being dragged.
    /// CEF name: `SetFragmentText`
    func setFragmentText(_ text: String?)  {
        let cefStrPtr = text != nil ? CEFStringPtrCreateFromSwiftString(text!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_fragment_text(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the text/html fragment that is being dragged.
    /// CEF name: `SetFragmentHtml`
    func setFragmentHTML(_ html: String?)  {
        let cefStrPtr = html != nil ? CEFStringPtrCreateFromSwiftString(html!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_fragment_html(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the base URL that the fragment came from.
    /// CEF name: `SetFragmentBaseURL`
    func setFragmentBaseURL(_ url: URL?)  {
        let cefStrPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_metadata(cefObjectPtr, cefStrPtr)
    }
    
    /// Reset the file contents. You should do this before calling
    /// CefBrowserHost::DragTargetDragEnter as the web view does not allow us to
    /// drag in this kind of data.
    /// CEF name: `ResetFileContents`
    func resetFileContents() {
        cefObject.reset_file_contents(cefObjectPtr)
    }

    /// Add a file that is being dragged into the webview.
    /// CEF name: `AddFile`
    func addFile(path: String, displayName: String? = nil)  {
        let cefPathPtr = CEFStringPtrCreateFromSwiftString(path)
        let cefNamePtr = displayName != nil ? CEFStringPtrCreateFromSwiftString(displayName!) : nil
        defer {
            CEFStringPtrRelease(cefPathPtr)
            CEFStringPtrRelease(cefNamePtr)
        }
        cefObject.add_file(cefObjectPtr, cefPathPtr, cefNamePtr)
    }

    /// Get the image representation of drag data. May return NULL if no image
    /// representation is available.
    /// CEF name: `GetImage`
    var image: CEFImage? {
        let cefImage = cefObject.get_image(cefObjectPtr)
        return CEFImage.fromCEF(cefImage)
    }
    
    /// Get the image hotspot (drag start location relative to image dimensions).
    /// CEF name: `GetImageHotspot`
    var imageHotspot: NSPoint {
        let cefPoint = cefObject.get_image_hotspot(cefObjectPtr)
        return NSPoint.fromCEF(cefPoint)
    }
    
    /// Returns true if an image representation of drag data is available.
    /// CEF name: `HasImage`
    var hasImage: Bool {
        return cefObject.has_image(cefObjectPtr) != 0
    }
}
