//
//  Feedback.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

final class Feedback: Model {
    static let schema = "user_feedback"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "given")
    var given: Date

    @Field(key: "user_id")
    var userId: UUID

    @Field(key: "nevershow")
    var nevershow: Bool

    init() {}

    init(id: UUID? = nil,
         given: Date,
         userId: UUID,
         nevershow: Bool) {
        self.id = id
        self.given = given
        self.userId = userId
        self.nevershow = nevershow
    }
}
