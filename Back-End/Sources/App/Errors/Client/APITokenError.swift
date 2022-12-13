//
//  APITokenError.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import NIOHTTP1
import Vapor

enum APITokenError: AppError {
    case couldNotFindAPIToken
}

extension APITokenError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .couldNotFindAPIToken:
            return .notFound
        }
    }

    var reason: String {
        switch self {
        case .couldNotFindAPIToken:
            return "Could not find given API token...."
        }
    }

    var identifier: String {
        switch self {
        case .couldNotFindAPIToken:
            return "api_token.token_not_found"
        }
    }
}
