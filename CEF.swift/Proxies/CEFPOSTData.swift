//
//  CEFPOSTData.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

public extension CEFPOSTData {
    
    /// Create a new CefPostData object.
    /// CEF name: `Create`
    convenience init?() {
        self.init(ptr: cef_post_data_create())
    }
    
    /// Returns true if this object is read-only.
    /// CEF name: `IsReadOnly`
    var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns true if the underlying POST data includes elements that are not
    /// represented by this CefPostData object (for example, multi-part file upload
    /// data). Modifying CefPostData objects with excluded elements may result in
    /// the request failing.
    /// CEF name: `HasExcludedElements`
    var hasExcludedElements: Bool {
        return cefObject.has_excluded_elements(cefObjectPtr) != 0
    }
    
    /// Returns the number of existing post data elements.
    /// CEF name: `GetElementCount`
    var elementCount: Int {
        return cefObject.get_element_count(cefObjectPtr)
    }
    
    /// Retrieve the post data elements.
    /// CEF name: `GetElements`
    var elements: [CEFPOSTDataElement] {
        var count: size_t = elementCount
        let cefElements = UnsafeMutablePointer<UnsafeMutablePointer<cef_post_data_element_t>?>.allocate(capacity: count)
        defer { cefElements.deallocate() }
        
        for i in 0..<count {
            cefElements.advanced(by: i).pointee = cef_post_data_element_create()
        }
        
        cefObject.get_elements(cefObjectPtr, &count, cefElements)
        
        var elements = [CEFPOSTDataElement]()
        for i in 0..<count {
            let cefPDEPtr = cefElements.advanced(by: i).pointee
            if let pde = CEFPOSTDataElement.fromCEF(cefPDEPtr) {
                elements.append(pde)
            }
        }
        
        return elements
    }
    
    /// Remove the specified post data element.  Returns true if the removal
    /// succeeds.
    /// CEF name: `RemoveElement`
    @discardableResult
    func remove(_ element: CEFPOSTDataElement) -> Bool {
        return cefObject.remove_element(cefObjectPtr, element.toCEF()) != 0
    }
    
    /// Add the specified post data element.  Returns true if the add succeeds.
    /// CEF name: `AddElement`
    @discardableResult
    func add(_ element: CEFPOSTDataElement) -> Bool {
        return cefObject.add_element(cefObjectPtr, element.toCEF()) != 0
    }
    
    /// Remove all existing post data elements.
    /// CEF name: `RemoveElements`
    func removeAll() {
        cefObject.remove_elements(cefObjectPtr)
    }

}
