//
//  APITokenController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct APITokenController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("token") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.get("",
                                  use: getAllApiTokens)
                .tags(["API Tokens"])
                .summary("Get All API Tokens")

                authenticated.post("",
                                  use: createApiToken)
                .tags(["API Tokens"])
                .summary("Create API Token")

                authenticated.put(":token",
                                  use: updateApiToken)
                .tags(["API Tokens"])
                .summary("Update API Token")

                authenticated.delete(":token",
                                  use: deleteApiToken)
                .tags(["API Tokens"])
                .summary("Delete API Token")
            }
        }
    }

    private func getAllApiTokens(_ req: Request) async throws -> [APITokenDTO] {
        let apiTokens = try await req.apiTokens.getAll()

        var tokens: [APITokenDTO] = []

        for token in apiTokens {
            tokens.append(APITokenDTO(from: token))
        }

        return tokens
    }

    private func createApiToken(_ req: Request) async throws -> APITokenCreationResponse {
        try APITokenCreationRequest.validate(content: req)

        let createToken = try req.content.decode(APITokenCreationRequest.self)

        let tokenSecret = generateAPISecretKey()

        try await req.apiTokens.createToken(newToken: ApiToken(from: createToken, secret: tokenSecret))

        return APITokenCreationResponse(secret: tokenSecret,
                                        username: createToken.username,
                                        type: createToken.type,
                                        enviroment: createToken.enviroment,
                                        project: createToken.project,
                                        projects: createToken.projects ?? [],
                                        expiresAt: createToken.expiresAt,
                                        createdAt: createToken.createdAt,
                                        seenAt: createToken.seenAt,
                                        alias: createToken.alias)
    }

    private func updateApiToken(_ req: Request) async throws -> HTTPStatus {
        guard let token = req.parameters.get("token", as: String.self) else {
            throw APITokenError.couldNotFindAPIToken
        }

        let updateAPITokenRequest = try req.content.decode(UpdateAPITokenRequest.self)

        if updateAPITokenRequest.expiresAt == nil {
            return .badRequest
        }

        try await req.apiTokens.setExpiry(secret: token,
                                          expiresAt: updateAPITokenRequest.expiresAt)

        return .ok
    }

    private func deleteApiToken(_ req: Request) async throws -> HTTPStatus {
        guard let token = req.parameters.get("token", as: String.self) else {
            throw APITokenError.couldNotFindAPIToken
        }

        if try await req.apiTokens.exists(secret: token) {
            let apiKey = try await req.apiTokens.get(key: token)

            try await req.apiTokens.delete(secret: token)
        }

        return .ok
    }

    private func generateAPISecretKey() -> String {
        "compose-\(String(describing: String.apiSecretKey))"
    }
}
