//
//  SendEmailVerificationRequest.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct SendEmailVerificationRequest: Content {
    let email: String
}
