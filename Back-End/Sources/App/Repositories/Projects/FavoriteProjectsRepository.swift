//
//  FavoriteProjectsRepository.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

protocol FavoriteProjectsRepository: Repository {
    func addFavoriteProject(project: FavoriteProjects) async throws
    func delete(userID: UUID) async throws
    func deleteAll() async throws
    func exists(project: String, userID: UUID) async throws -> HTTPStatus
    func get(project: String, userID: UUID) async throws -> FavoriteProjects?
    func getAll() async throws -> [FavoriteProjects]
}

struct DatabaseFavoriteProjectsRepository: FavoriteProjectsRepository, DatabaseRepository {

    let database: Database

    func addFavoriteProject(project: FavoriteProjects) async throws {
        try await project.create(on: database)
    }

    func delete(userID: UUID) async throws {
        try await FavoriteProjects.query(on: database)
            .filter(\.$userId, .equal, userID)
            .delete(force: true)
    }

    func deleteAll() async throws {
        try await FavoriteProjects.query(on: database)
            .delete(force: true)
    }

    func exists(project: String, userID: UUID) async throws -> HTTPStatus {
        let favProjectNotFound = try await FavoriteProjects.query(on: database)
            .filter(\.$project, .equal, project)
            .filter(\.$userId, .equal, userID)
            .all()
            .isEmpty

        if favProjectNotFound {
            return .notFound
        } else {
            return .found
        }
    }

    func get(project: String, userID: UUID) async throws -> FavoriteProjects? {
        return try await FavoriteProjects.query(on: database)
            .filter(\.$project, .equal, project)
            .filter(\.$userId, .equal, userID)
            .first()
    }

    func getAll() async throws -> [FavoriteProjects] {
        return try await FavoriteProjects.query(on: database)
            .all()
    }
}

extension Application.Repositories {
    var favProjects: FavoriteProjectsRepository {
        guard let factory = storage.makeFavProjectsRepository else {
            fatalError("Favorite Projects repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }

    func use(_ make: @escaping (Application) -> (FavoriteProjectsRepository)) {
        storage.makeFavProjectsRepository = make
    }
}
