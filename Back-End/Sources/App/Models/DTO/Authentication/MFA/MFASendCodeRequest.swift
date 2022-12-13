//
//  MFASendCodeRequest.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor

struct MFASendCodeRequest: Content, Validatable {
    let userId: UUID
    let method: MFAMethod
    let email: String

    static func validations(_ validations: inout Validations) {
        validations.add("userId", as: UUID.self)
        validations.add("email", as: String.self, is: !.empty)
        validations.add("method", as: MFAMethod.self)
    }
}
