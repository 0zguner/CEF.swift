//
//  File.swift
//  CEF.swift
//
//  Created by Joe Bay on 2/27/23.
//  Copyright © 2023 Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_preference_manager_t: CEFObject {}

typealias CEFPreferenceManagerMarshaller = CEFMarshaller<CEFPreferenceManager, cef_preference_manager_t>

extension CEFPreferenceManager {
    func toCEF() -> UnsafeMutablePointer<cef_preference_manager_t> {
        return CEFPreferenceManagerMarshaller.pass(self)
    }
}

extension cef_preference_manager_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        has_preference = CEFPreferenceManager_has_preference
        /*
        on_print_start = CEFPrintHandler_on_print_start
        on_print_settings = CEFPrintHandler_on_print_settings
        on_print_dialog = CEFPrintHandler_on_print_dialog
        on_print_job = CEFPrintHandler_on_print_job
        on_print_reset = CEFPrintHandler_on_print_reset
        get_pdf_paper_size = CEFPrintHandler_get_pdf_paper_size
         */
    }
}
