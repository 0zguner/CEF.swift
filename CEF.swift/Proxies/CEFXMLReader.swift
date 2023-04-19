//
//  CEFXMLReader.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFXMLReader {

    /// Create a new CefXmlReader object. The returned object's methods can only
    /// be called from the thread that created the object.
    /// CEF name: `Create`
    convenience init?(stream: CEFStreamReader, encoding: CEFXMLEncodingType, uri: URL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(uri.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        self.init(ptr: cef_xml_reader_create(stream.toCEF(), encoding.toCEF(), cefURLPtr))
    }
    
    /// Moves the cursor to the next node in the document. This method must be
    /// called at least once to set the current cursor position. Returns true if
    /// the cursor position was set successfully.
    /// CEF name: `MoveToNextNode`
    @discardableResult
    func moveToNextNode() -> Bool {
        return cefObject.move_to_next_node(cefObjectPtr) != 0
    }

    /// Close the document. This should be called directly to ensure that cleanup
    /// occurs on the correct thread.
    /// CEF name: `Close`
    @discardableResult
    func close() -> Bool {
        return cefObject.close(cefObjectPtr) != 0
    }

    /// Returns true if an error has been reported by the XML parser.
    /// CEF name: `HasError`
    var hasError: Bool {
        return cefObject.has_error(cefObjectPtr) != 0
    }

    /// Returns the error string.
    /// CEF name: `GetError`
    var errorString: String? {
        let cefStrPtr = cefObject.get_error(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    // The below methods retrieve data for the node at the current cursor
    // position.
    
    /// Returns the node type.
    /// CEF name: `GetType`
    var type: CEFXMLNodeType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFXMLNodeType.fromCEF(cefType)
    }

    /// Returns the node depth. Depth starts at 0 for the root node.
    /// CEF name: `GetDepth`
    var depth: Int {
        return Int(cefObject.get_depth(cefObjectPtr))
    }

    /// Returns the local name. See
    /// http://www.w3.org/TR/REC-xml-names/#NT-LocalPart for additional details.
    /// CEF name: `GetLocalName`
    var localName: String {
        let cefStrPtr = cefObject.get_local_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the namespace prefix. See http://www.w3.org/TR/REC-xml-names/ for
    /// additional details.
    /// CEF name: `GetPrefix`
    var prefix: String? {
        let cefStrPtr = cefObject.get_prefix(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns the qualified name, equal to (Prefix:)LocalName. See
    /// http://www.w3.org/TR/REC-xml-names/#ns-qualnames for additional details.
    /// CEF name: `GetQualifiedName`
    var qualifiedName: String {
        let cefStrPtr = cefObject.get_qualified_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the URI defining the namespace associated with the node. See
    /// http://www.w3.org/TR/REC-xml-names/ for additional details.
    /// CEF name: `GetNamespaceURI`
    var namespaceURI: URL? {
        let cefStrPtr = cefObject.get_namespace_uri(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        guard let str = CEFStringPtrToSwiftString(cefStrPtr) else {
            return nil
        }
        return URL(string: str)
    }
    
    /// Returns the base URI of the node. See http://www.w3.org/TR/xmlbase/ for
    /// additional details.
    /// CEF name: `GetBaseURI`
    var baseURI: URL? {
        let cefStrPtr = cefObject.get_base_uri(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        guard let str = CEFStringPtrToSwiftString(cefStrPtr) else {
            return nil
        }
        return URL(string: str)
    }
    
    /// Returns the xml:lang scope within which the node resides. See
    /// http://www.w3.org/TR/REC-xml/#sec-lang-tag for additional details.
    /// CEF name: `GetXmlLang`
    var xmlLang: String? {
        let cefStrPtr = cefObject.get_xml_lang(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns true if the node represents an empty element. <a/> is considered
    /// empty but <a></a> is not.
    /// CEF name: `IsEmptyElement`
    var isEmptyElement: Bool {
        return cefObject.is_empty_element(cefObjectPtr) != 0
    }
    
    /// Returns true if the node has a text value.
    /// CEF name: `HasValue`
    var hasValue: Bool {
        return cefObject.has_value(cefObjectPtr) != 0
    }

    /// Returns the text value.
    /// CEF name: `GetValue`
    var value: String {
        let cefStrPtr = cefObject.get_value(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns true if the node has attributes.
    /// CEF name: `HasAttributes`
    var hasAttributes: Bool {
        return cefObject.has_attributes(cefObjectPtr) != 0
    }

    /// Returns the number of attributes.
    /// CEF name: `GetAttributeCount`
    func attributeCount() -> size_t {
        return cefObject.get_attribute_count(cefObjectPtr)
    }

    /// Returns the value of the attribute at the specified 0-based index.
    /// CEF name: `GetAttribute`
    func attribute(at index: Int) -> String? {
        let cefStrPtr = cefObject.get_attribute_byindex(cefObjectPtr, Int32(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns the value of the attribute with the specified qualified name.
    /// CEF name: `GetAttribute`
    func attribute(for qualifiedName: String) -> String? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(qualifiedName)
        let cefStrPtr = cefObject.get_attribute_byqname(cefObjectPtr, cefNamePtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefStrPtr)
        }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns the value of the attribute with the specified local name and
    /// namespace URI.
    /// CEF name: `GetAttribute`
    func attribute(for name: String, namespaceURI: URL) -> String? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefURIPtr = CEFStringPtrCreateFromSwiftString(namespaceURI.absoluteString)
        let cefStrPtr = cefObject.get_attribute_bylname(cefObjectPtr, cefNamePtr, cefURIPtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefURIPtr)
            CEFStringPtrRelease(cefStrPtr)
        }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns an XML representation of the current node's children.
    /// CEF name: `GetInnerXml`
    var innerXML: String {
        let cefStrPtr = cefObject.get_inner_xml(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns an XML representation of the current node including its children.
    /// CEF name: `GetOuterXml`
    var outerXML: String {
        let cefStrPtr = cefObject.get_outer_xml(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the line number for the current node.
    /// CEF name: `GetLineNumber`
    var lineNumber: Int {
        return Int(cefObject.get_line_number(cefObjectPtr))
    }

    // Attribute nodes are not traversed by default. The below methods can be
    // used to move the cursor to an attribute node. MoveToCarryingElement() can
    // be called afterwards to return the cursor to the carrying element. The
    // depth of an attribute node will be 1 + the depth of the carrying element.
    
    /// Moves the cursor to the attribute at the specified 0-based index. Returns
    /// true if the cursor position was set successfully.
    /// CEF name: `MoveToAttribute`
    @discardableResult
    func moveToAttribute(at index: Int) -> Bool {
        return cefObject.move_to_attribute_byindex(cefObjectPtr, Int32(index)) != 0
    }

    /// Moves the cursor to the attribute with the specified qualified name.
    /// Returns true if the cursor position was set successfully.
    /// CEF name: `MoveToAttribute`
    @discardableResult
    func moveToAttribute(_ qualifiedName: String) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(qualifiedName)
        defer { CEFStringPtrRelease(cefNamePtr) }
        return cefObject.move_to_attribute_byqname(cefObjectPtr, cefNamePtr) != 0
    }
    
    /// Moves the cursor to the attribute with the specified local name and
    /// namespace URI. Returns true if the cursor position was set successfully.
    /// CEF name: `MoveToAttribute`
    @discardableResult
    func moveToAttribute(_ name: String, namespaceURI: URL) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefURIPtr = CEFStringPtrCreateFromSwiftString(namespaceURI.absoluteString)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefURIPtr)
        }
        return cefObject.move_to_attribute_bylname(cefObjectPtr, cefNamePtr, cefURIPtr) != 0
    }
    
    /// Moves the cursor to the first attribute in the current element. Returns
    /// true if the cursor position was set successfully.
    /// CEF name: `MoveToFirstAttribute`
    @discardableResult
    func moveToFirstAttribute() -> Bool {
        return cefObject.move_to_first_attribute(cefObjectPtr) != 0
    }

    /// Moves the cursor to the next attribute in the current element. Returns
    /// true if the cursor position was set successfully.
    /// CEF name: `MoveToNextAttribute`
    @discardableResult
    func moveToNextAttribute() -> Bool {
        return cefObject.move_to_next_attribute(cefObjectPtr) != 0
    }
    
    /// Moves the cursor back to the carrying element. Returns true if the cursor
    /// position was set successfully.
    /// CEF name: `MoveToCarryingElement`
    @discardableResult
    func moveToCarryingElement() -> Bool {
        return cefObject.move_to_carrying_element(cefObjectPtr) != 0
    }

}
