//
//  LoginResponse.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct LoginResponse: Content {
    let user: UserDTO
    let accessToken: String
    let refreshToken: String
}
