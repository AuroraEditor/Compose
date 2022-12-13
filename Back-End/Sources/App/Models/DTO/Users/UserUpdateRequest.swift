//
//  File.swift
//  
//
//  Created by Nanashi Li on 2022/10/11.
//

import Vapor

struct UserFullnameUpdateRequest: Content {
    let firstName: String
    let lastName: String
}

extension UserFullnameUpdateRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("firstName", as: String.self, is: !.empty)
        validations.add("lastName", as: String.self, is: !.empty)
    }
}

struct UserEmailUpdateRequest: Content {
    let email: String
}

extension UserEmailUpdateRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
    }
}

struct UserUsernameUpdateRequest: Content {
    let username: String
}

extension UserUsernameUpdateRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: .count(4...21))
    }
}

struct UserPasswordUpdateRequest: Content {
    let password: String
}

extension UserPasswordUpdateRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("password", as: String.self, is: .count(8...50))
    }
}
