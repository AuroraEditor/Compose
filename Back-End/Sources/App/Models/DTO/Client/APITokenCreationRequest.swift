//
//  APITokenCreationRequest.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor

struct APITokenCreationRequest: Content, Validatable {
    let username: String
    let type: ApiTokenType
    let enviroment: String
    let project: String
    let projects: [String]?
    let expiresAt: Date
    let createdAt: Date
    let seenAt: Date
    let alias: String?

    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self)
        validations.add("type", as: ApiTokenType.self)
        validations.add("enviroment", as: String.self)
        validations.add("project", as: String.self)
        validations.add("projects", as: [String].self, required: false)
        validations.add("expiresAt", as: Date.self, required: false)
        validations.add("createdAt", as: Date.self)
        validations.add("seenAt", as: Date.self)
        validations.add("alias", as: String.self, required: false)
    }
}

extension ApiToken {
    convenience init(from apiToken: APITokenCreationRequest, secret: String) throws {
        self.init(secret: secret,
                  username: apiToken.username,
                  alias: apiToken.alias,
                  type: apiToken.type,
                  environment: apiToken.enviroment,
                  project: apiToken.project,
                  projects: apiToken.projects,
                  expiresAt: apiToken.expiresAt,
                  createdAt: apiToken.createdAt,
                  seenAt: apiToken.seenAt)
    }
}
