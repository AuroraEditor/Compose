//
//  APITokenDTO.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor

struct APITokenDTO: Content {
    var id: UUID?
    var secret: String
    var username: String
    var alias: String?
    var type: ApiTokenType
    var environment: String
    var project: String
    var projects: [String]?
    var expiresAt: Date?
    var createdAt: Date
    var seenAt: Date

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

    init(from apiToken: ApiToken) {
        self.init(id: apiToken.id,
                  secret: apiToken.secret,
                  username: apiToken.username,
                  alias: apiToken.alias,
                  type: apiToken.type,
                  environment: apiToken.environment,
                  project: apiToken.project,
                  projects: apiToken.projects,
                  expiresAt: apiToken.expiresAt,
                  createdAt: apiToken.createdAt,
                  seenAt: apiToken.seenAt)
    }
}
