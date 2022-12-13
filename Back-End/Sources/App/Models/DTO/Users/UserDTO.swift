//
//  UserDTO.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import OpenAPIReflection
import OpenAPIKit

struct UserDTO: Content {
    let id: UUID?
    let firstName: String
    let lastName: String
    let email: String
    let profileImage: String
    let role: UserRoles
    let twoFactorEnabled: Bool
    
    init(id: UUID? = nil,
         firstName: String,
         lastName: String,
         email: String,
         profileImage: String,
         role: UserRoles,
         twoFactorEnabled: Bool = false) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImage = profileImage
        self.role = role
        self.twoFactorEnabled = twoFactorEnabled
    }
    
    init(from user: User) {
        self.init(id: user.id,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  email: user.email,
                  profileImage: user.profileImage,
                  role: user.role)
    }
}

extension UserDTO: OpenAPIEncodedSchemaType {
    static func openAPISchema(using encoder: JSONEncoder) throws -> JSONSchema {
        return try genericOpenAPISchemaGuess(for: self, using: encoder)
    }
}


