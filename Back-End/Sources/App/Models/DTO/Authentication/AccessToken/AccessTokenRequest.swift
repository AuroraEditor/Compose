//
//  AccessTokenRequest.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct AccessTokenRequest: Content {
    let refreshToken: String
}
