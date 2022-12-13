//
//  RefreshTokenRepository.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Fluent

protocol RefreshTokenRepository: Repository {
    func create(_ token: RefreshToken) async throws -> Void
    func find(id: UUID?) async throws -> RefreshToken?
    func find(token: String) async throws -> RefreshToken?
    func delete(_ token: RefreshToken) async throws -> Void
    func count() async throws -> Int
    func delete(for userID: UUID) async throws -> Void
}

struct DatabaseRefreshTokenRepository: RefreshTokenRepository, DatabaseRepository {
    let database: Database
    
    func create(_ token: RefreshToken) async throws -> Void {
        do {
            return try await token.create(on: database)
        } catch {
            throw RefreshTokenError.unableToCreateRefreshToken
        }
    }

    func find(id: UUID?) async throws -> RefreshToken? {
        do {
            return try await RefreshToken.find(id, on: database)
        } catch {
            throw RefreshTokenError.unableToFindRefreshToken
        }
    }

    func find(token: String) async throws -> RefreshToken? {
        do {
            return try await RefreshToken.query(on: database)
                .filter(\.$token == token)
                .first()
        } catch {
            throw RefreshTokenError.unableToFindRefreshToken
        }
    }

    func delete(_ token: RefreshToken) async throws -> Void {
        do {
            return try await token.delete(on: database)
        } catch {
            throw RefreshTokenError.unableToDeleteRefreshToken
        }
    }

    func count() async throws -> Int {
        do {
            return try await RefreshToken.query(on: database)
                .count()
        } catch {
            throw RefreshTokenError.unableToFindRefreshTokens
        }
    }

    func delete(for userID: UUID) async throws -> Void {
        do {
            try await RefreshToken.query(on: database)
                .filter(\.$user.$id == userID)
                .delete()
        } catch {
            throw RefreshTokenError.unableToDeleteRefreshToken
        }
    }
}

extension Application.Repositories {
    var refreshTokens: RefreshTokenRepository {
        guard let factory = storage.makeRefreshTokenRepository else {
            fatalError("RefreshToken repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }
    
    func use(_ make: @escaping (Application) -> (RefreshTokenRepository)) {
        storage.makeRefreshTokenRepository = make
    }
}
