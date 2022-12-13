//
//  ResetPasswordRequest.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct ResetPasswordRequest: Content {
    let email: String
}

extension ResetPasswordRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
    }
}
