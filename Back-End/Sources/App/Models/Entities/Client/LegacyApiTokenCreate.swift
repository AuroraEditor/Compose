//
//  File.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

final class LegacyApiTokenCreate: Model {
    static let schema = "legacy_api_tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "secret")
    var secret: String

    @Field(key: "username")
    var username: String

    @Field(key: "type")
    var type: ApiTokenType

    @Field(key: "environment")
    var environment: String

    @Field(key: "project")
    var project: String?

    @Field(key: "projects")
    var projects: [String]?

    @Field(key: "expiresAt")
    var expiresAt: Date

    init() {}

    init(id: UUID? = nil,
         secret: String,
         username: String,
         type: ApiTokenType,
         environment: String,
         project: String? = nil,
         projects: [String]? = nil,
         expiresAt: Date) {
        self.id = id
        self.secret = secret
        self.username = username
        self.type = type
        self.environment = environment
        self.project = project
        self.projects = projects
        self.expiresAt = expiresAt
    }
}

enum ApiTokenType: String, Codable {
    case CLIENT = "client"
    case ADMIN = "admin"
    case FRONTEND = "frontend"
}
