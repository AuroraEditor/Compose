//
//  File.swift
//  
//
//  Created by Nanashi Li on 2022/10/11.
//

import Vapor

struct UserUpdateResponse: Content {
    let userId: UUID
}

struct UserDeleteResponse: Content {
    let userId: UUID
    var message: String = "User has been deleted successfully"
}

