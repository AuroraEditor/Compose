//
//  Payload.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import JWT

struct Payload: JWTPayload, Authenticatable {
    // User-releated stuff
    var userID: UUID
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    var role: UserRoles
    var profileImage: String
    
    // JWT stuff
    var exp: ExpirationClaim
    
    func verify(using signer: JWTSigner) throws {
        try self.exp.verifyNotExpired()
    }
    
    init(with user: User) throws {
        self.userID = try user.requireID()
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
        self.username = user.username
        self.role = user.role
        self.profileImage = user.profileImage
        self.exp = ExpirationClaim(value: Date().addingTimeInterval(Constants.ACCESS_TOKEN_LIFETIME))
    }
}

extension User {
    convenience init(from payload: Payload) {
        self.init(id: payload.userID,
                  firstName: payload.firstName,
                  lastName: payload.lastName,
                  email: payload.email,
                  username: payload.username,
                  passwordHash: "",
                  profileImage: payload.profileImage,
                  role: payload.role,
                  passwordChangeRequired: false,
                  twoFactor: nil,
                  lastLoginInstant: nil,
                  passwordLastUpdateInstant: nil)
    }
}
