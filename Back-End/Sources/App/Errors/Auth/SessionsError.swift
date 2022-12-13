//
//  SessionsError.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import NIOHTTP1
import Vapor

enum SessionsError: AppError {
    case couldNotFindSessionWithUserID
}

extension SessionsError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .couldNotFindSessionWithUserID:
            return .notFound
        }
    }

    var reason: String {
        switch self {
        case .couldNotFindSessionWithUserID:
            return "Could not find sessions for user with given id."
        }
    }

    var identifier: String {
        switch self {
        case .couldNotFindSessionWithUserID:
            return "sessions.user_session_not_found"
        }
    }
}
