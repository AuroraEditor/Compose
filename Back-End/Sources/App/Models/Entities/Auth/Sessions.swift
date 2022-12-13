//
//  Sessions.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

final class Sessions: Model {
    static let schema = "sessions"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "session")
    var session: UUID

    @Field(key: "expires_at")
    var expiresAt: Date

    @Field(key: "issued_at")
    var issuedAt: Date

    init() {}

    init(id: UUID? = nil,
         session: UUID,
         expiresAt: Date = Date().addingTimeInterval(Constants.REFRESH_TOKEN_LIFETIME),
         issuedAt: Date = Date()) {
        self.id = id
        self.session = session
        self.expiresAt = expiresAt
        self.issuedAt = issuedAt
    }
}
