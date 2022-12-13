//
//  User.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Fluent

final class User: Model, Authenticatable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "firstName")
    var firstName: String

    @Field(key: "lastName")
    var lastName: String
    
    @Field(key: "email")
    var email: String

    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var passwordHash: String
    
    @Field(key: "role")
    var role: UserRoles
    
    @Field(key: "email_verified")
    var isEmailVerified: Bool

    @Field(key: "profile_image")
    var profileImage: String

    @Field(key: "passwordChangeRequired")
    var passwordChangeRequired: Bool

    // MARK: - MFA
    @Field(key: "twoFactorEnabled")
    var twoFactorEnabled: Bool?

    @Field(key: "twoFactor")
    var twoFactor: MFAEmailMethod?

    // MARK: - Security
    @Field(key: "lastLoginInstant")
    var lastLoginInstant: Date?

    @Field(key: "passwordLastUpdateInstant")
    var passwordLastUpdateInstant: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         firstName: String,
         lastName: String,
         email: String,
         username: String,
         passwordHash: String,
         profileImage: String,
         role: UserRoles = .user,
         isEmailVerified: Bool = false,
         passwordChangeRequired: Bool = false,
         twoFactorEnabled: Bool = false,
         twoFactor: MFAEmailMethod?,
         lastLoginInstant: Date?,
         passwordLastUpdateInstant: Date?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.passwordHash = passwordHash
        self.profileImage = profileImage
        self.role = role
        self.isEmailVerified = isEmailVerified
        self.passwordChangeRequired = passwordChangeRequired
        self.twoFactorEnabled = twoFactorEnabled
        self.twoFactor = twoFactor
        self.lastLoginInstant = lastLoginInstant
        self.passwordLastUpdateInstant = passwordLastUpdateInstant
    }
}

enum UserRoles: String, Codable {
    case user = "user"
    case moderator = "moderater"
    case maintainer = "maintainer"
    case admin = "admin"
}


// MARK: - MFA
protocol MFA: Codable {
    var id: String { get set }
    var method: String { get set }
}

//struct MFAMethods: Codable {
//    var methods: MFA
//}

struct MFAAuthenticatorMethod: Codable, MFA {
    var id: String
    var authenticator: MFAAuthenticator
    var method: String
    var secret: String
}

struct MFAAuthenticator: Codable {
    var algorithm: String
    var codeLength: Int
    var timeStep: Int
}

struct MFAPhoneMethod: Codable, MFA {
    var id: String
    var method: String
    var mobilePhone: String
}

struct MFAEmailMethod: Codable, MFA {
    var id: String
    var method: String
    var email: String
}
