//
//  ClientApplicationsError.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import NIOHTTP1
import Vapor

enum ClientApplicationsError: AppError {
    case couldNotFindApplication
}

extension ClientApplicationsError: AbortError {
    var status: HTTPResponseStatus {
        switch self {
        case .couldNotFindApplication:
            return .notFound
        }
    }

    var reason: String {
        switch self {
        case .couldNotFindApplication:
            return "Could not application with the given application name, please try again...."
        }
    }

    var identifier: String {
        switch self {
        case .couldNotFindApplication:
            return "client_application.app_not_found"
        }
    }
}
