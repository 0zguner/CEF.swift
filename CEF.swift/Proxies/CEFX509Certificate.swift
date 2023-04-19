//
//  CEFX509Certificate.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFX509Certificate {
    
    /// Returns the subject of the X.509 certificate. For HTTPS server
    /// certificates this represents the web server.  The common name of the
    /// subject should match the host name of the web server.
    /// CEF name: `GetSubject`
    var subject: CEFX509CertPrincipal? {
        let cefCert = cefObject.get_subject(cefObjectPtr)
        return CEFX509CertPrincipal.fromCEF(cefCert)
    }
    
    /// Returns the issuer of the X.509 certificate.
    /// CEF name: `GetIssuer`
    var issuer: CEFX509CertPrincipal? {
        let cefCert = cefObject.get_issuer(cefObjectPtr)
        return CEFX509CertPrincipal.fromCEF(cefCert)
    }
    
    /// Returns the DER encoded serial number for the X.509 certificate. The value
    /// possibly includes a leading 00 byte.
    /// CEF name: `GetSerialNumber`
    var serialNumber: CEFBinaryValue? {
        let cefBinary = cefObject.get_serial_number(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the date before which the X.509 certificate is invalid.
    /// CefTime.GetTimeT() will return 0 if no date was specified.
    /// CEF name: `GetValidStart`
    var validFromDate: Date? {
        let basetime = cefObject.get_valid_start(cefObjectPtr)
        var cefTime = cef_time_t()
        cef_time_from_basetime(basetime, &cefTime)
        var time: time_t = 0;
        cef_time_to_timet(&cefTime, &time)
        return time != 0 ? CEFTimeToSwiftDate(cefTime) : nil
    }
    
    /// Returns the date after which the X.509 certificate is invalid.
    /// CefTime.GetTimeT() will return 0 if no date was specified.
    /// CEF name: `GetValidExpiry`
    var validUntilDate: Date? {
        let basetime = cefObject.get_valid_start(cefObjectPtr)
        var cefTime = cef_time_t()
        cef_time_from_basetime(basetime, &cefTime)
        var time: time_t = 0;
        cef_time_to_timet(&cefTime, &time)
        return time != 0 ? CEFTimeToSwiftDate(cefTime) : nil
    }

    /// Returns the DER encoded data for the X.509 certificate.
    /// CEF name: `GetDEREncoded`
    var derEncoded: CEFBinaryValue? {
        let cefBinary = cefObject.get_derencoded(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the PEM encoded data for the X.509 certificate.
    /// CEF name: `GetPEMEncoded`
    var pemEncoded: CEFBinaryValue? {
        let cefBinary = cefObject.get_pemencoded(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the number of certificates in the issuer chain.
    /// If 0, the certificate is self-signed.
    /// CEF name: `GetIssuerChainSize`
    var issuerChainSize: size_t {
        return cefObject.get_issuer_chain_size(cefObjectPtr)
    }
    
    /// Returns the DER encoded data for the certificate issuer chain.
    /// If we failed to encode a certificate in the chain it is still
    /// present in the array but is an empty string.
    /// CEF name: `GetDEREncodedIssuerChain`
    var derEncodedIssuerChain: [CEFBinaryValue] {
        var chainLength: size_t = 0
        var cefChain: UnsafeMutablePointer<cef_binary_value_t>? = nil
        cefObject.get_derencoded_issuer_chain(cefObjectPtr, &chainLength, &cefChain)
        
        var chain: [CEFBinaryValue] = []
        for i in 0..<chainLength {
            let cefBinary = cefChain!.advanced(by: i)
            chain.append(CEFBinaryValue.fromCEF(cefBinary)!)
        }
        
        return chain
    }
    
    /// Returns the PEM encoded data for the certificate issuer chain.
    /// If we failed to encode a certificate in the chain it is still
    /// present in the array but is an empty string.
    /// CEF name: `GetPEMEncodedIssuerChain`
    var pemEncodedIssuerChain: [CEFBinaryValue] {
        var chainLength: size_t = 0
        var cefChain: UnsafeMutablePointer<cef_binary_value_t>? = nil
        cefObject.get_pemencoded_issuer_chain(cefObjectPtr, &chainLength, &cefChain)
        
        var chain: [CEFBinaryValue] = []
        for i in 0..<chainLength {
            let cefBinary = cefChain!.advanced(by: i)
            chain.append(CEFBinaryValue.fromCEF(cefBinary)!)
        }
        
        return chain
    }
    
}
