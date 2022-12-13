//
//  ProjectEnviromentController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct ProjectEnviromentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("project") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.get(":projectId/environments",
                                  use: addEnvironmentToProject)
                .tags(["Projects"])
                .summary("Get project health overview")

                authenticated.get(":projectId/environments/:environment",
                                  use: removeEnvironmentFromProject)
                .tags(["Projects"])
                .summary("Get Project Health Report")
            }
        }
    }

    private func addEnvironmentToProject(_ req: Request) async throws {}

    private func removeEnvironmentFromProject(_ req: Request) async throws {}
}
