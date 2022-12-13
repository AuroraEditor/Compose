//
//  BanError.swift
//  
//
//  Created by Nanashi Li on 2022/10/27.
//

import Vapor

enum BanError: AppError {
    case failedToBan
    case cantBanAdmin
    case incorrectPermission
    case unableToFetchBanInfo
    case userBannedAlready
}

extension BanError: AbortError {
    var identifier: String {
        switch self {
        case .failedToBan:
            return "ban_error.failed_to_ban_user"
        case .cantBanAdmin:
            return "ban_error.cant_ban_admin"
        case .incorrectPermission:
            return "ban_error.incorrect_permission"
        case .unableToFetchBanInfo:
            return "ban_error.data_not_available"
        case .userBannedAlready:
            return "ban_error.user_banned_already"
        }
    }

    var reason: String {
        switch self {
        case .failedToBan:
            return "Failed to ban user, please try again."
        case .cantBanAdmin:
            return "You can't ban admins."
        case .incorrectPermission:
            return "Your don't have succifient permission to perform this request."
        case .unableToFetchBanInfo:
            return "Unable to fetch ban info for the current ID."
        case .userBannedAlready:
            return "User has been banned already, can't ban the user again."
        }
    }

    var status: HTTPStatus {
        switch self {
        case .incorrectPermission:
            return .unauthorized
        default:
            return .conflict
        }
    }
}

