//
//  ApiToken.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

final class ApiToken: Model {
    static let schema = "tokens"

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

    @Field(key: "project")
    var project: String

    @Field(key: "projects")
    var projects: [String]?

    @Field(key: "expiresAt")
    var expiresAt: Date?

    @Field(key: "createdAt")
    var createdAt: Date

    @Field(key: "seenAt")
    var seenAt: Date

    init() {}

    init(id: UUID? = nil,
         secret: String,
         username: String,
         alias: String? = nil,
         type: ApiTokenType,
         environment: String,
         project: String,
         projects: [String]? = nil,
         expiresAt: Date? = nil,
         createdAt: Date,
         seenAt: Date) {
        self.id = id
        self.secret = secret
        self.username = username
        self.alias = alias
        self.type = type
        self.environment = environment
        self.project = project
        self.projects = projects
        self.expiresAt = expiresAt
        self.createdAt = createdAt
        self.seenAt = seenAt
    }
}
