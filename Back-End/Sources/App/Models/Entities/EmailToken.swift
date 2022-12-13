//
//  EmailToken.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Fluent

final class EmailToken: Model {
    static let schema = "email_tokens"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Field(key: "token")
    var token: String
    
    @Field(key: "expires_at")
    var expiresAt: Date
    
    init() {}
    
    init(id: UUID? = nil,
        userID: UUID,
        token: String,
        expiresAt: Date = Date().addingTimeInterval(Constants.EMAIL_TOKEN_LIFETIME)) {
        self.id = id
        self.$user.id = userID
        self.token = token
        self.expiresAt = expiresAt
    }
}
