//
//  ProjectController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct ProjectController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("project") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.get("",
                                  use: getProjects)
                .tags(["Projects"])
                .summary("Get projects")
            }
        }
    }

    private func getProjects(_ req: Request) async throws {}
}
