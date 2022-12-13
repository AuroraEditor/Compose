//
//  TeamError.swift
//  
//
//  Created by Nanashi Li on 2022/10/18.
//

import Vapor

enum TeamError: AppError {
    case singleTeamConfiguration
    case userNotFound
    case cantAddYourself
    case userAlreadyMember
    case userNotMember
    case youAreTheLastUser
    case unableToDeleteAdminTeam
    case teamNotFound
}

extension TeamError: AbortError {
    var identifier: String {
        switch self {
        case .singleTeamConfiguration:
            return "team_error.single_team_configuration"
        case .userNotFound:
            return "team_error.user_not_found"
        case .cantAddYourself:
            return "team_error.cant_add_yourself"
        case .userAlreadyMember:
            return "team_error.user_already_member"
        case .userNotMember:
            return "team_error.user_not_member"
        case .youAreTheLastUser:
            return "team_error.you_are_last_user"
        case .unableToDeleteAdminTeam:
            return "team_error.unable_delete_admin_team"
        case .teamNotFound:
            return "team_error.not.found"
        }
    }

    var reason: String {
        switch self {
        case .singleTeamConfiguration:
            return "Server is running in a single team configuration"
        case .userNotFound:
            return "User not found"
        case .cantAddYourself:
            return "One just can not add themselves to another peoples team my friend!"
        case .userAlreadyMember:
            return "User is already a member of the team"
        case .userNotMember:
            return "User is not a member of the team"
        case .youAreTheLastUser:
            return "You are the last user in this team; Please delete the team instead"
        case .unableToDeleteAdminTeam:
            return "Can't delete admin team"
        case .teamNotFound:
            return "Team not found"
        }
    }

    var status: HTTPStatus {
        switch self {
        case .userNotFound:
            return .notFound
        default:
            return .conflict
        }
    }
}
