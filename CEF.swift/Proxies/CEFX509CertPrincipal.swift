//
//  CEFX509CertPrincipal.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFX509CertPrincipal {

    /// Returns a name that can be used to represent the issuer.  It tries in this
    /// order: CN, O and OU and returns the first non-empty one found.
    /// CEF name: `GetDisplayName`
    var displayName: String {
        let cefStrPtr = cefObject.get_display_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the common name.
    /// CEF name: `GetCommonName`
    var commonName: String {
        let cefStrPtr = cefObject.get_common_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the locality name.
    /// CEF name: `GetLocalityName`
    var localityName: String {
        let cefStrPtr = cefObject.get_locality_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the state or province name.
    /// CEF name: `GetStateOrProvinceName`
    var stateOrProvinceName: String {
        let cefStrPtr = cefObject.get_state_or_province_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the country name.
    /// CEF name: `GetCountryName`
    var countryName: String {
        let cefStrPtr = cefObject.get_country_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Retrieve the list of street addresses.
    /// CEF name: `GetStreetAddresses`
    var streetAddresses: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_street_addresses(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Retrieve the list of organization names.
    /// CEF name: `GetOrganizationNames`
    var organizationNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_organization_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Retrieve the list of organization unit names.
    /// CEF name: `GetOrganizationUnitNames`
    var organizationUnitNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_organization_unit_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Retrieve the list of domain components.
    /// CEF name: `GetDomainComponents`
    var domainComponents: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_domain_components(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }

}
