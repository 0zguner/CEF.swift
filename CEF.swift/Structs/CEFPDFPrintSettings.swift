//
//  CEFPDFPrintSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing PDF print settings.
/// CEF name: `cef_pdf_print_settings_t`
public struct CEFPDFPrintSettings {
    public struct HeaderFooter {
        /// Page title to display in the header. Only used if |display_header_footer|
        /// is set to true (1).
        /// CEF name: `header_footer_title`
        public var title: String? = nil

        /// URL to display in the footer. Only used if |display_header_footer| is set
        /// to true (1).
        /// CEF name: `header_footer_url`
        public var url: URL? = nil
    }
    
    /// Set to true (1) to print headers and footers or false (0) to not print
    /// headers and footers.
    /// CEF name: `header_footer_enabled`
    public var headerFooter: HeaderFooter? = nil
    
    /// Output page size in microns. If either of these values is less than or
    /// equal to zero then the default paper size (A4) will be used.
    /// CEF name: `page_width`, `page_height`
    public var pageSize: NSSize = .zero
    
    /// The percentage to scale the PDF by before printing (e.g. 50 is 50%).
    /// If this value is less than or equal to zero the default value of 100
    /// will be used.
    /// CEF name: `scale_factor`
    public var scaleFactor: Double
    
    /// Margins in points. Only used if |margin_type| is set to
    /// PDF_PRINT_MARGIN_CUSTOM.
    /// CEF name: `margin_type`, `margin_top`, `margin_left`, `margin_bottom`, `margin_right`
    public var margins: CEFPDFPrintMargins = .default
    
    /// Paper ranges to print, one based, e.g., '1-5, 8, 11-13'. Pages are printed
    /// in the document order, not in the order specified, and no more than once.
    /// Defaults to empty string, which implies the entire document is printed.
    /// The page numbers are quietly capped to actual page count of the document,
    /// and ranges beyond the end of the document are ignored. If this results in
    /// no pages to print, an error is reported. It is an error to specify a range
    /// with start greater than end.
    /// CEF name: `page_ranges`
    public var pageRanges: String = ""
    
    /// Set to true (1) for landscape mode or false (0) for portrait mode.
    /// CEF name: `landscape`
    public var orientation: CEFPageOrientation = .portrait
    
    /// Set to true (1) to print background graphics or false (0) to not print
    /// background graphics.
    /// CEF name: `backgrounds_enabled`
    public var printsBackground: Bool = false
    
}

extension CEFPDFPrintSettings {
    func toCEF() -> cef_pdf_print_settings_t {
        var cefStruct = cef_pdf_print_settings_t()

        if let headerFooter = headerFooter {
            cefStruct.display_header_footer = 1
            var headerFooterTemplate = ""
            if let title = headerFooter.title {
                headerFooterTemplate += "<span class=title>\(title)</span>"
            }
            if let url = headerFooter.url {
                headerFooterTemplate += "<span class=title>\(url.absoluteString)</span>"
            }
            
            CEFStringSetFromSwiftString(headerFooterTemplate, cefStringPtr: &cefStruct.header_template)
        }
        
        cefStruct.paper_width = pageSize.width
        cefStruct.paper_height = pageSize.height
        cefStruct.scale = scaleFactor
        
        cefStruct.margin_type = margins.toCEF()
        if case .custom(let insets) = margins {
            cefStruct.margin_top = insets.top
            cefStruct.margin_left = insets.left
            cefStruct.margin_bottom = insets.bottom
            cefStruct.margin_right = insets.right
        }
        
        CEFStringSetFromSwiftString(pageRanges, cefStringPtr: &cefStruct.page_ranges)
        cefStruct.landscape = orientation == .landscape ? 1 : 0
        cefStruct.print_background = printsBackground ? 1 : 0
        
        return cefStruct
    }
}

extension cef_pdf_print_settings_t {
    mutating func clear() {
        cef_string_utf16_clear(&header_template)
        cef_string_utf16_clear(&footer_template)
    }
}


