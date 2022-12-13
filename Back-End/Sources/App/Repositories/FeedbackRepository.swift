//
//  FeedbackRepository.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

protocol FeedbackRepository: Repository {
    func getAllUserFeedback(userId: UUID) async throws -> [Feedback]
    func getFeedback(feedbaackId: UUID, userID: UUID) async throws -> Feedback?
    func updateFeedback(feedback: Feedback) async throws
    func delete(feedbaackId: UUID, userID: UUID) async throws
    func deleteAll() async throws
    func exists(feedbaackId: UUID, userID: UUID) async throws -> HTTPStatus
    func getAll() async throws -> [Feedback]
}

struct DatabaseFeedbackRepository: FeedbackRepository, DatabaseRepository {

    let database: Database

    func getAllUserFeedback(userId: UUID) async throws -> [Feedback] {
        return try await Feedback.query(on: database)
            .filter(\.$userId, .equal, userId)
            .all()
    }

    func getFeedback(feedbaackId: UUID, userID: UUID) async throws -> Feedback? {
        return try await Feedback.query(on: database)
            .filter(\.$id, .equal, feedbaackId)
            .filter(\.$userId, .equal, userID)
            .first()
    }

    func updateFeedback(feedback: Feedback) async throws {
        try await feedback.update(on: database)
    }

    func delete(feedbaackId: UUID, userID: UUID) async throws  {
        try await Feedback.query(on: database)
            .filter(\.$id, .equal, feedbaackId)
            .filter(\.$userId, .equal, userID)
            .delete(force: true)
    }

    func deleteAll() async throws {
        try await Feedback.query(on: database)
            .delete(force: true)
    }

    func exists(feedbaackId: UUID, userID: UUID) async throws -> HTTPStatus {
        let feedbackNotFound = try await Feedback.query(on: database)
            .filter(\.$id, .equal, feedbaackId)
            .filter(\.$userId, .equal, userID)
            .all()
            .isEmpty

        if feedbackNotFound {
            return .notFound
        } else {
            return .found
        }
    }

    func getAll() async throws -> [Feedback] {
        return try await Feedback.query(on: database)
            .all()
    }
}

extension Application.Repositories {
    var feedback: FeedbackRepository {
        guard let factory = storage.makeFeedbackRepository else {
            fatalError("Feedback repository not configured, use: app.repositories.use")
        }
        return factory(app)
    }

    func use(_ make: @escaping (Application) -> (FeedbackRepository)) {
        storage.makeFeedbackRepository = make
    }
}
