//
//  ApiTokensCreate.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

final class ApiTokensCreate: Model {
    static let schema = "api_tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "secret")
    var secret: String

    @Field(key: "username")
    var username: String

    @Field(key: "alias")
    var alias: String?

    @Field(key: "type")
    var type: ApiTokenType

    @Field(key: "environment")
    var environment: String

    @Field(key: "projects")
    var projects: [String]?

    @Field(key: "expiresAt")
    var expiresAt: Date

    init() {}

    init(id: UUID? = nil,
         secret: String,
         username: String,
         lias: String? = nil,
         type: ApiTokenType,
         environment: String,
         projects: [String]? = nil,
         expiresAt: Date) {
        self.id = id
        self.secret = secret
        self.username = username
        self.alias = alias
        self.type = type
        self.environment = environment
        self.projects = projects
        self.expiresAt = expiresAt
    }
}
