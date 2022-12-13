//
//  MFAEnableRequest.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor

/// Examples of enabling a MFA by type:
///
/// Example Request JSON Enabling a TOTP Factor:
/// ```swift
/// {
///     "code": "435612",
///     "method": "authenticator",
///     "secret": "8MJJfCY4ERBtotvenSc3"
/// }```
///
/// Example Request JSON Enabling an Email Factor:
/// ```swift
/// {
///     "code": "435612",
///     "method": "email",
///     "email": "nanashili@auroraeditor.com"
///}

struct MFAEnableRequest: Content, Validatable {
    let code: String
    let method: MFAMethod

    let email: String?
    let mobilePhone: String?

    let secret: String?
    let secretBase32Encoded: String?

    static func validations(_ validations: inout Validations) {
        validations.add("code", as: String.self, is: !.empty)
        validations.add("method", as: MFAMethod.self)
    }
}

enum MFAMethod: String, Codable {
    case sms = "sms"
    case email = "email"
    case authenticator = "authenticator"
}
