//
//  EmailVerificationTokenRequest.swift
//  
//
//  Created by Nanashi Li on 2022/10/10.
//

import Vapor

struct EmailVerificationTokenRequest: Content {
    let token: String
}
