//
//  CEFJSONParseResult.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFJSONParseResult {
    case Success(CEFValue)
    case Failure(CEFJSONParserError, String)
}
