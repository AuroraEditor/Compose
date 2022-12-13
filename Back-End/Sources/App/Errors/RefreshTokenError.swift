//
//  RefreshTokenError.swift
//  
//
//  Created by Nanashi Li on 2022/10/27.
//

import NIOHTTP1
import Vapor

enum RefreshTokenError: AppError {
    case unableToFindRefreshToken
    case unableToDeleteRefreshToken
    case unableToFindRefreshTokens
    case unableToCreateRefreshToken
}

extension RefreshTokenError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .unableToFindRefreshToken:
            return .notFound
        case .unableToDeleteRefreshToken:
            return .badRequest
        case .unableToFindRefreshTokens:
            return .notFound
        case .unableToCreateRefreshToken:
            return .badRequest
        }
    }

    var reason: String {
        switch self {
        case .unableToFindRefreshToken:
            return "Unable to find the required refresh token."
        case .unableToDeleteRefreshToken:
            return "Unable to delete required refresh token."
        case .unableToFindRefreshTokens:
            return "Unable to find any refresh tokens."
        case .unableToCreateRefreshToken:
            return "Unable to create a refresh token at this moment, please try again later."
        }
    }

    var identifier: String {
        switch self {
        case .unableToFindRefreshToken:
            return "refresh_token.unable_to_find"
        case .unableToDeleteRefreshToken:
            return "refresh_token.unable_to_delete"
        case .unableToFindRefreshTokens:
            return "refresh_token.unable_to_find_tokens"
        case .unableToCreateRefreshToken:
            return "refresh_token.unable_to_create"
        }
    }
}
