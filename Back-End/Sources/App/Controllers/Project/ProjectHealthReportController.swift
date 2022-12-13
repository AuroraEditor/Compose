//
//  ProjectHealthReportController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct ProjectHealthReportController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("health") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.get(":projectId", use: getProjectHealthOverview)
                    .description("")
                    .tags(["Projects"])
                    .summary("Get project health overview")

                authenticated.get(":projectId/health-report", use: getProjectHealthReport)
                    .description("")
                    .tags(["Projects"])
                    .summary("Get Project Health Report")
            }
        }
    }

    private func getProjectHealthOverview(_ req: Request) async throws {}

    private func getProjectHealthReport(_ req: Request) async throws {}
}
