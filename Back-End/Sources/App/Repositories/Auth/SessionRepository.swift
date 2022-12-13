//
//  SessionRepository.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

protocol SessionRepository: Repository {
    func getActiveSessions(token: String) async throws -> [Sessions]
    func getSessionsForUser(userID: UUID) async throws -> [Sessions]
    func get(_ sessionID: UUID) async throws -> Sessions?
    func deleteSessionsForUser(userID: UUID) async throws
    func delete(sessionID: UUID) async throws
    func insertSession(session: Sessions) async throws
    func exists(sessionID: UUID) async throws -> HTTPStatus
    func getAll(userID: UUID) async throws -> [Sessions]
}

struct DatabaseSessionRepositoryRepository: SessionRepository, DatabaseRepository {
    let database: Database

    func getActiveSessions(token: String) async throws -> [Sessions] {
        return try await Sessions.query(on: database)
            .filter(\.$expiresAt, .greaterThan, Date())
            .sort(\.$issuedAt, .descending)
            .all()
    }

    func getSessionsForUser(userID: UUID) async throws -> [Sessions] {
        let userSessions =  try await Sessions.query(on: database)
            .filter(\.$session, .equal, userID)
            .all()

        if !userSessions.isEmpty {
            return userSessions
        }

        throw SessionsError.couldNotFindSessionWithUserID
    }

    func get(_ sessionID: UUID) async throws -> Sessions? {
        return try await Sessions.query(on: database)
            .filter(\.$id, .equal, sessionID)
            .first()
    }

    func deleteSessionsForUser(userID: UUID) async throws {
        try await Sessions.query(on: database)
            .filter(\.$session, .equal, userID)
            .delete(force: true)
    }

    func delete(sessionID: UUID) async throws {
        try await Sessions.query(on: database)
            .filter(\.$id, .equal, sessionID)
            .delete(force: true)
    }

    func insertSession(session: Sessions) async throws {
        try await session.create(on: database)
    }

    func exists(sessionID: UUID) async throws -> HTTPStatus {
        let sessionNotFound = try await Sessions.query(on: database)
            .filter(\.$id, .equal, sessionID)
            .all()
            .isEmpty

        if sessionNotFound {
            return .notFound
        } else {
            return .found
        }
    }

    func getAll(userID: UUID) async throws -> [Sessions] {
        return try await Sessions.query(on: database)
            .all()
    }
}

extension Application.Repositories {
    var session: SessionRepository {
        guard let factory = storage.makeSessionRepository else {
            fatalError("Session repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }

    func use(_ make: @escaping (Application) -> (SessionRepository)) {
        storage.makeSessionRepository = make
    }
}
