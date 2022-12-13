//
//  ClientApplications.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

final class ClientApplications: Model {
    static let schema = "client_applications"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "app_name")
    var appName: String

    @Field(key: "description")
    var description: UUID

    @Field(key: "strategies")
    var strategies: String

    @Field(key: "url")
    var url: String

    @Field(key: "color")
    var color: String

    @Field(key: "icon")
    var icon: String

    @Field(key: "announced")
    var announced: Bool

    @Field(key: "created_at")
    var createdAt: Date

    @Field(key: "created_by")
    var createdBy: UUID

    @Field(key: "updated_at")
    var updatedAt: Date

    @Field(key: "seen_at")
    var seenAt: Date

    init() {}

    init(id: UUID? = nil,
         appName: String,
         description: UUID,
         strategies: String,
         url: String,
         color: String,
         icon: String,
         announced: Bool,
         createdAt: Date,
         createdBy: UUID,
         updatedAt: Date,
         seenAt: Date) {
        self.id = id
        self.appName = appName
        self.description = description
        self.strategies = strategies
        self.url = url
        self.color = color
        self.icon = icon
        self.announced = announced
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.updatedAt = updatedAt
        self.seenAt = seenAt
    }
}
