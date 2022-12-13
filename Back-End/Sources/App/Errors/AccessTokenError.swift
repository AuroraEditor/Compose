//
//  AccessTokenError.swift
//  
//
//  Created by Nanashi Li on 2022/10/27.
//

import NIOHTTP1
import Vapor

enum AccessTokenError: AppError {
    case unableToFindAccessToken
    case unableToDeleteAccessToken
    case unableToFindAccessTokens
    case unableToCreateAccessToken
    case accessTokenHasExpired
}

extension AccessTokenError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .unableToFindAccessToken:
            return .notFound
        case .unableToDeleteAccessToken:
            return .badRequest
        case .unableToFindAccessTokens:
            return .notFound
        case .unableToCreateAccessToken:
            return .badRequest
        case .accessTokenHasExpired:
            return .unauthorized
        }
    }

    var reason: String {
        switch self {
        case .unableToFindAccessToken:
            return "Unable to find the required access token."
        case .unableToDeleteAccessToken:
            return "Unable to delete required access token."
        case .unableToFindAccessTokens:
            return "Unable to find any access tokens."
        case .unableToCreateAccessToken:
            return "Unable to create a access token at this moment, please try again later."
        case .accessTokenHasExpired:
            return "Your access token has expired, please login again."
        }
    }

    var identifier: String {
        switch self {
        case .unableToFindAccessToken:
            return "access_token.unable_to_find"
        case .unableToDeleteAccessToken:
            return "access_token.unable_to_delete"
        case .unableToFindAccessTokens:
            return "access_token.unable_to_find_tokens"
        case .unableToCreateAccessToken:
            return "access_token.unable_to_create"
        case .accessTokenHasExpired:
            return "access_token.expired"
        }
    }
}
