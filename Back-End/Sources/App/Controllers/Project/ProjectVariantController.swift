//
//  ProjectVariantController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct ProjectVariantController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("project") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.get(":projectId/features/:featureName/variants",
                                  use: getVariants)
                    .description("")
                    .tags(["Features"])
                    .summary("Get Feature Variants")

                authenticated.patch(":projectId/features/:featureName/variants",
                                    use: patchVariants)
                    .description("")
                    .tags(["Features"])
                    .summary("Patch Feature Variants")

                authenticated.put(":projectId/features/:featureName/variants",
                                  use: overwriteVariants)
                    .description("")
                    .tags(["Features"])
                    .summary("Overwrite Feature Variants")

                authenticated.get("/:projectId/features/:featureName/environments/:environment/variants",
                                  use: getVariantsOnEnv)
                    .description("")
                    .tags(["Features"])
                    .summary("Get Environment Feature Variants")

                authenticated.patch("/:projectId/features/:featureName/environments/:environment/variants",
                                  use: patchVariantsOnEnv)
                    .description("")
                    .tags(["Features"])
                    .summary("Patch Environments Feature Variants")

                authenticated.put("/:projectId/features/:featureName/environments/:environment/variants",
                                  use: overwriteVariantsOnEnv)
                    .description("")
                    .tags(["Features"])
                    .summary("Overwrite Environment Feature Variants")
            }
        }
    }

    private func getVariants(_ req: Request) async throws {}

    private func patchVariants(_ req: Request) async throws {}

    private func overwriteVariants(_ req: Request) async throws {}

    private func getVariantsOnEnv(_ req: Request) async throws {}

    private func patchVariantsOnEnv(_ req: Request) async throws {}

    private func overwriteVariantsOnEnv(_ req: Request) async throws {}
}
