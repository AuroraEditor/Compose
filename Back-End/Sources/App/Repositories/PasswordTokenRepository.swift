//
//  PasswordTokenRepository.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Fluent

protocol PasswordTokenRepository: Repository {
    func find(userID: UUID) -> EventLoopFuture<PasswordToken?>
    func find(token: String) -> EventLoopFuture<PasswordToken?>
    func count() -> EventLoopFuture<Int>
    func create(_ passwordToken: PasswordToken) async -> Void
    func delete(_ passwordToken: PasswordToken) -> EventLoopFuture<Void>
    func delete(for userID: UUID) -> EventLoopFuture<Void>
}

struct DatabasePasswordTokenRepository: PasswordTokenRepository, DatabaseRepository {
    var database: Database
    
    func find(userID: UUID) -> EventLoopFuture<PasswordToken?> {
        PasswordToken.query(on: database)
            .filter(\.$user.$id == userID)
            .first()
     }
    
    func find(token: String) -> EventLoopFuture<PasswordToken?> {
        PasswordToken.query(on: database)
            .filter(\.$token == token)
            .first()
    }
    
    func count() -> EventLoopFuture<Int> {
        PasswordToken.query(on: database).count()
    }
    
    func create(_ passwordToken: PasswordToken) async -> Void {
        do {
            return try await passwordToken.create(on: database)
        } catch {
            print(error)
        }
    }
    
    func delete(_ passwordToken: PasswordToken) -> EventLoopFuture<Void> {
        passwordToken.delete(on: database)
    }
    
    func delete(for userID: UUID) -> EventLoopFuture<Void> {
        PasswordToken.query(on: database)
            .filter(\.$user.$id == userID)
            .delete()
    }
}

extension Application.Repositories {
    var passwordTokens: PasswordTokenRepository {
        guard let factory = storage.makePasswordTokenRepository else {
            fatalError("PasswordToken repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }
    
    func use(_ make: @escaping (Application) -> (PasswordTokenRepository)) {
        storage.makePasswordTokenRepository = make
    }
}
