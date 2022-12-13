//
//  ClientApplicationsRepository.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

protocol ClientApplicationsRepository: Repository {
    func exists(appName: String) async throws -> Bool
    func getAll() async throws -> [ClientApplications]
    func getApplication(appName: String) async throws -> ClientApplications?
    func deleteApplication(appName: String) async throws
    func getUnannouced() async throws -> [ClientApplications]
    func setAnnouncedStatus() async throws -> [ClientApplications]
    func delete(key: String) async throws
    func deleteAll() async throws
}

struct DatabaseClientApplicationsRepository: ClientApplicationsRepository, DatabaseRepository {
    let database: Database

    func exists(appName: String) async throws -> Bool {
        let doesExist = try await ClientApplications.query(on: database)
            .filter(\.$appName, .equal, appName)
            .all()
            .isEmpty

        return doesExist
    }

    func getAll() async throws -> [ClientApplications] {
        return try await ClientApplications.query(on: database)
            .sort(\.$appName, .ascending)
            .all()
    }

    func getApplication(appName: String) async throws -> ClientApplications? {
        let application = try await ClientApplications.query(on: database)
            .filter(\.$appName, .equal, appName)
            .all()
            .first

        if application == nil {
            throw ClientApplicationsError.couldNotFindApplication
        }

        return application
    }

    func deleteApplication(appName: String) async throws {
        try await ClientApplications.query(on: database)
            .filter(\.$appName, .equal, appName)
            .delete(force: true)
    }

    func getUnannouced() async throws -> [ClientApplications] {
        return try await ClientApplications.query(on: database)
            .filter(\.$announced, .equal, false)
            .all()
    }

    func setAnnouncedStatus() async throws -> [ClientApplications] {
        return try await ClientApplications.query(on: database)
            .filter(\.$announced, .equal, false)
            .set(\.$announced, to: true)
            .all()
    }

    func delete(key: String) async throws {
        try await ClientApplications.query(on: database)
            .filter(\.$appName, .equal, key)
            .delete(force: true)
    }

    func deleteAll() async throws {
        try await ClientApplications.query(on: database)
            .delete(force: true)
    }
}

extension Application.Repositories {
    var clientApplications: ClientApplicationsRepository {
        guard let factory = storage.makeClientApplicationsRepository else {
            fatalError("Client Applications repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }

    func use(_ make: @escaping (Application) -> (ClientApplicationsRepository)) {
        storage.makeClientApplicationsRepository = make
    }
}

