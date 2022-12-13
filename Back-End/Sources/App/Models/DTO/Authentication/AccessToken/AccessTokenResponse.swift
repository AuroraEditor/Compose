//
//  AccessTokenResponse.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct AccessTokenResponse: Content {
    let refresh_token: String
    let access_token: String
    let token_type: String
    let refresh_token_expires_in: Double
    let expires_in: Double
}

struct AccessTokenValidationResponse: Content {
    let user_id: UUID
    let valid: Bool
}
