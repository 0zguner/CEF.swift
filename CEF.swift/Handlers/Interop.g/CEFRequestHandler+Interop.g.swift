//
//  CEFRequestHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_handler.h.
//

import Foundation

extension cef_request_handler_t: CEFObject {}

typealias CEFRequestHandlerMarshaller = CEFMarshaller<CEFRequestHandler, cef_request_handler_t>

extension CEFRequestHandler {
    func toCEF() -> UnsafeMutablePointer<cef_request_handler_t> {
        return CEFRequestHandlerMarshaller.pass(self)
    }
}

extension cef_request_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_browse = CEFRequestHandler_on_before_browse
        on_open_urlfrom_tab = CEFRequestHandler_on_open_urlfrom_tab
        get_resource_request_handler = CEFRequestHandler_get_resource_request_handler
        get_auth_credentials = CEFRequestHandler_get_auth_credentials
        on_certificate_error = CEFRequestHandler_on_certificate_error
        on_select_client_certificate = CEFRequestHandler_on_select_client_certificate
        on_render_view_ready = CEFRequestHandler_on_render_view_ready
        on_render_process_terminated = CEFRequestHandler_on_render_process_terminated
        on_document_available_in_main_frame = CEFRequestHandler_on_document_available_in_main_frame
    }
}
