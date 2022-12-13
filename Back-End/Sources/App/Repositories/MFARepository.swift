//
//  MFARepository.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor
import Fluent

protocol MFARepository: Repository {
    func create(_ code: MFACode) async throws -> Void
    func find(code: String) async throws -> MFACode?
    func delete(_ code: MFACode) async throws -> Void
    func count() async throws -> Int
    func delete(for userID: UUID) async throws -> Void
}

struct DatabaseMFARepository: MFARepository, DatabaseRepository {
    let database: Database

    func create(_ code: MFACode) async throws -> Void {
        do {
            return try await code.create(on: database)
        } catch {
            throw AccessTokenError.unableToCreateAccessToken
        }
    }

    func find(code: String) async throws -> MFACode? {
        do {
            return try await MFACode.query(on: database)
                .filter(\.$code == code)
                .first()
        } catch {
            throw AccessTokenError.unableToFindAccessToken
        }
    }

    func delete(_ code: MFACode) async throws -> Void {
        do {
            return try await code.delete(on: database)
        } catch {
            throw AccessTokenError.unableToDeleteAccessToken
        }
    }

    func count() async throws -> Int {
        do {
            return try await AccessToken.query(on: database)
                .count()
        } catch {
            throw AccessTokenError.unableToFindAccessTokens
        }
    }

    func delete(for userID: UUID) async throws -> Void {
        do {
            try await AccessToken.query(on: database)
                .filter(\.$user.$id == userID)
                .delete()
        } catch {
            throw AccessTokenError.unableToDeleteAccessToken
        }
    }
}

extension Application.Repositories {
    var mfa: MFARepository {
        guard let factory = storage.makeMFARepository else {
            fatalError("MFA repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }

    func use(_ make: @escaping (Application) -> (MFARepository)) {
        storage.makeMFARepository = make
    }
}
