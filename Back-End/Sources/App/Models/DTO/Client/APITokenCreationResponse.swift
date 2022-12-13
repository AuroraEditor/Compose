//
//  APITokenCreationResponse.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor

struct APITokenCreationResponse: Content {
    let secret: String
    let username: String
    let type: ApiTokenType
    let enviroment: String
    let project: String
    let projects: [String]
    let expiresAt: Date
    let createdAt: Date
    let seenAt: Date
    let alias: String?
}
