//
//  RegisterRequest.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct RegisterRequest: Content {
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let password: String
    let profileImage: UploadRequest
}

extension RegisterRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("firstName", as: String.self, is: !.empty)
        validations.add("lastName", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("username", as: String.self, is: .count(4...21))
        validations.add("password", as: String.self, is: .count(8...50))
    }
}

extension User {
    convenience init(from register: RegisterRequest, hash: String, profileImage: String) throws {
        self.init(firstName: register.firstName,
                  lastName: register.lastName,
                  email: register.email,
                  username: register.username,
                  passwordHash: hash,
                  profileImage: profileImage,
                  passwordChangeRequired: false,
                  twoFactor: nil,
                  lastLoginInstant: nil,
                  passwordLastUpdateInstant: nil)
    }
}

struct UploadRequest: Content {
    var data: Data
    var contentType: String
}
