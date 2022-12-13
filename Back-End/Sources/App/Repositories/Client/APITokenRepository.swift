//
//  APITokenRepository.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

protocol APITokenRepository: Repository {
    func getAll() async throws -> [ApiToken]
    func getAllActive() async throws -> [ApiToken]
    func createToken(newToken: ApiToken) async throws
    func exists(secret: String) async throws -> Bool
    func get(key: String) async throws -> ApiToken?
    func delete(secret: String) async throws
    func deleteAll() async throws
    func setExpiry(secret: String, expiresAt: Date) async throws
    func markSeenAt(secret: String) async throws
}

struct DatabaseAPITokenRepository: APITokenRepository, DatabaseRepository {
    let database: Database

    func getAll() async throws -> [ApiToken] {
        return try await ApiToken.query(on: database)
            .all()
    }

    func getAllActive() async throws -> [ApiToken] {
        return try await ApiToken.query(on: database)
            .filter(\.$expiresAt, .equal, nil)
            .filter(\.$expiresAt, .greaterThan, Date())
            .all()
    }

    func createToken(newToken: ApiToken) async throws {
        return try await newToken.create(on: database)
    }

    func exists(secret: String) async throws -> Bool {
        return try await ApiToken.query(on: database)
            .filter(\.$secret, .equal, secret)
            .all()
            .isEmpty
    }

    func get(key: String) async throws -> ApiToken? {
        return try await ApiToken.query(on: database)
            .filter(\.$secret, .equal, key)
            .all()
            .first
    }

    func delete(secret: String) async throws {
        try await ApiToken.query(on: database)
            .filter(\.$secret, .equal, secret)
            .delete(force: true)
    }

    func deleteAll() async throws {
        try await ApiToken.query(on: database)
            .delete(force: true)
    }

    func setExpiry(secret: String, expiresAt: Date) async throws {
        try await ApiToken.query(on: database)
            .filter(\.$secret, .equal, secret)
            .set(\.$expiresAt, to: expiresAt)
            .update()
    }

    func markSeenAt(secret: String) async throws {
        try await ApiToken.query(on: database)
            .filter(\.$secret, .equal, secret)
            .set(\.$seenAt, to: Date())
            .update()
    }
}

extension Application.Repositories {
    var apiToken: APITokenRepository {
        guard let factory = storage.makeAPITokenRepository else {
            fatalError("API Token repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }

    func use(_ make: @escaping (Application) -> (APITokenRepository)) {
        storage.makeAPITokenRepository = make
    }
}
