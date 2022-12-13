//
//  ExtensionError.swift
//  
//
//  Created by Nanashi Li on 2022/10/13.
//

import Vapor

enum ExtensionError: AppError {
    case extensionNotFound
    case extensionStoreEmpty
    case userDoesntOwnExtension

    // GitHub Error
    case githubRepoMissing
    case githubRepoDetermineFailure

    // Admin Errors
    case extensionStateListEmpty
    case unableToUpdateState
}

extension ExtensionError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .extensionNotFound:
            return .notFound
        case .extensionStoreEmpty:
            return .notFound
        case .userDoesntOwnExtension:
            return .forbidden
        case .extensionStateListEmpty:
            return .noContent
        case .unableToUpdateState:
            return .badRequest
        case .githubRepoMissing:
            return .notFound
        case .githubRepoDetermineFailure:
            return .notFound
        }
    }

    var reason: String {
        switch self {
        case .extensionNotFound:
            return "We couldn't find an extension with the provided extension id."
        case .extensionStoreEmpty:
            return "We couldn't find any extensions in the marketplace."
        case .userDoesntOwnExtension:
            return "Current user doesn't own this extension, therefor can't delete the extension."
        case .extensionStateListEmpty:
            return "Couldn't find any extensions by provided state."
        case .unableToUpdateState:
            return "Was unable to update the state of the extension, please try again later."
        case .githubRepoMissing:
            return "We couldn't determine if the GitHub repo exists, make sure the repo is public and try again."
        case .githubRepoDetermineFailure:
            return "Failed to determine the owner and repo of the GitHub repo."
        }
    }

    var identifier: String {
        switch self {
        case .extensionNotFound:
            return "extension_not_found"
        case .extensionStoreEmpty:
            return "extension_store_empty"
        case .userDoesntOwnExtension:
            return "invalid_extension_owner"
        case .extensionStateListEmpty:
            return "empty_extension_state_list"
        case .unableToUpdateState:
            return "state_update_failure"
        case .githubRepoMissing:
            return "extension_error.missing_github_repo"
        case .githubRepoDetermineFailure:
            return "extension_error.determing_github_repo_failed"
        }
    }
}
