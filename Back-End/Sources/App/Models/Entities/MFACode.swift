//
//  MFACode.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor
import Fluent

final class MFACode: Model, Authenticatable {
    static let schema = "mfa"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "userId")
    var userId: UUID

    @Field(key: "code")
    var code: String

    @Field(key: "methodValue")
    var methodValue: String

    @Field(key: "issuedAt")
    var issuedAt: Date

    @Field(key: "expiresAt")
    var expiresAt: Date

    init() {}

    init(id: UUID? = nil,
         userId: UUID,
         code: String,
         methodValue: String,
         issuedAt: Date,
         expiresAt: Date) {
        self.id = id
        self.userId = userId
        self.code = code
        self.methodValue = methodValue
        self.issuedAt = issuedAt
        self.expiresAt = expiresAt
    }
}
