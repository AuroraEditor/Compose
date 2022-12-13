//
//  ProjectFavoritesController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct ProjectFavoritesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("project") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.post(":projectId/features/:featureName/favorites",
                                  use: addFavoriteFeature)
                .tags(["Projects"])
                .summary("Get projects")

                authenticated.delete(":projectId/features/:featureName/favorites",
                                  use: removeFavoriteFeature)
                .tags(["Projects"])
                .summary("Get projects")

                authenticated.post(":projectId/favorites",
                                  use: addFavoriteProject)
                .tags(["Projects"])
                .summary("Get projects")

                authenticated.delete(":projectId/favorites",
                                  use: removeFavoriteProject)
                .tags(["Projects"])
                .summary("Get projects")
            }
        }
    }

    private func addFavoriteFeature(_ req: Request) async throws {}

    private func removeFavoriteFeature(_ req: Request) async throws {}

    private func addFavoriteProject(_ req: Request) async throws {}

    private func removeFavoriteProject(_ req: Request) async throws {}
}
