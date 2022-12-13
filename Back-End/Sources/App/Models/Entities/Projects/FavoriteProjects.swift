//
//  FavoriteProjects.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

import Vapor
import Fluent

final class FavoriteProjects: Model {
    static let schema = "favorite_projects"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "user_id")
    var userId: UUID

    @Field(key: "project")
    var project: String

    @Field(key: "created_at")
    var createdAt: Date

    init() {}

    init(id: UUID? = nil,
         userId: UUID,
         project: String,
         createdAt: Date) {
        self.id = id
        self.userId = userId
        self.project = project
        self.createdAt = createdAt
    }
}
