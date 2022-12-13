//
//  MFAErrors.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor

enum MFAErrors: AppError {
    case userDoesnNotExist
    case codeRequestInvalid
    case codeInvalid
    case enablingMFAForWrongUser

    // Email MFA Errors
    case emailIsEmpty
}

extension MFAErrors: AbortError {
    var identifier: String {
        switch self {
        case .userDoesnNotExist:
            return "mfa_error.user_doesnt_exist"
        case .codeRequestInvalid:
            return "mfa_error.invalid_code"
        case .codeInvalid:
            return "mfa_error.code_invalid"
        case .enablingMFAForWrongUser:
            return "mfa_error.invalid_user"
        case .emailIsEmpty:
            return "mfa_error.email_empty"
        }
    }

    var reason: String {
        switch self {
        case .userDoesnNotExist:
            return "The User does not exist."
        case .codeRequestInvalid:
            return "The code request parameter is not valid."
        case .codeInvalid:
            return "The given MFA code is invalid."
        case .enablingMFAForWrongUser:
            return "The user id doesn't match with the account id requesting the MFA request."
        case .emailIsEmpty:
            return "No email was found in the body request"
        }
    }

    var status: HTTPStatus {
        switch self {
        case .userDoesnNotExist:
            return .notFound
        case .codeRequestInvalid:
            return .conflict
        case .codeInvalid:
            return .notFound
        case .enablingMFAForWrongUser:
            return .conflict
        case .emailIsEmpty:
            return .conflict
        }
    }
}
