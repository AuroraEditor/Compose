//
//  ProjectFeatureController.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor
import Fluent

struct ProjectFeatureController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("project") { user in
            user.group(AdminAuthenticator()) { authenticated in
                authenticated.get(":projectId/features/:featureName/environments/:environment",
                                  use: getFeatureEnvironment)
                .tags(["Features"])
                .summary("Get Feature Enviroment")

                // MARK: - Toggle Feature Enviroment
                authenticated.post(":projectId/features/:featureName/environments/:environment/off",
                                   use: toggleFeatureEnvironmentOff)
                .tags(["Features"])
                .summary("Toggle Feature Enviroment Off")

                authenticated.post(":projectId/features/:featureName/environments/:environment/on",
                                   use: toggleFeatureEnvironmentOn)
                .tags(["Features"])
                .summary("Toggle Feature Enviroment On")

                // MARK: - Strategies
                authenticated.get(":projectId/features/:featureName/environments/:environment/strategies",
                                  use: getFeatureStrategies)
                .tags(["Features"])
                .summary("Get Environment Feature Variants")

                authenticated.post(":projectId/features/:featureName/environments/:environment/strategies",
                                   use: addFeatureStrategy)
                .tags(["Features"])
                .summary("Patch Environments Feature Variants")

                authenticated.get(":projectId/features/:featureName/environments/:environment/strategies/:strategyId",
                                  use: getFeatureStrategy)
                .tags(["Features"])
                .summary("Overwrite Environment Feature Variants")

                authenticated.post(":projectId/features/:featureName/environments/:environment/strategies/set-sort-order",
                                   use: setStrategiesSortOrder)
                .tags(["Features"])
                .summary("Get Feature Variants")

                authenticated.put(":projectId/features/:featureName/environments/:environment/strategies/:strategyId",
                                  use: updateFeatureStrategy)
                .tags(["Features"])
                .summary("Patch Feature Variants")

                authenticated.patch(":projectId/features/:featureName/environments/:environment/strategies/:strategyId",
                                    use: patchFeatureStrategy)
                .tags(["Features"])
                .summary("Overwrite Feature Variants")

                authenticated.delete(":projectId/features/:featureName/environments/:environment/strategies/:strategyId",
                                     use: deleteFeatureStrategy)
                .tags(["Features"])
                .summary("Get Environment Feature Variants")

                // MARK: -  Features
                authenticated.get(":projectId/features",
                                  use: getFeatures)
                .tags(["Features"])
                .summary("Patch Environments Feature Variants")

                authenticated.post(":projectId/features",
                                   use: createFeature)
                .description("")
                .tags(["Features"])
                .summary("Overwrite Environment Feature Variants")

                authenticated.post(":projectId/features/:featureName/clone",
                                   use: cloneFeature)
                .tags(["Features"])
                .summary("Get Feature Variants")

                authenticated.get(":projectId/features/:featureName",
                                  use: getFeature)
                .description("This endpoint returns the information about the requested feature if the feature belongs to the specified project.")
                .tags(["Features"])
                .summary("Get a feature.")

                authenticated.put(":projectId/features/:featureName",
                                  use: updateFeature)
                .tags(["Features"])
                .summary("Overwrite Feature Variants")

                authenticated.patch(":projectId/features/:featureName",
                                  use: patchFeature)
                .tags(["Features"])
                .summary("Get Environment Feature Variants")

                authenticated.delete(":projectId/features/:featureName",
                                     use: archiveFeature)
                .description("This endpoint archives the specified feature if the feature belongs to the specified project.")
                .tags(["Features"])
                .summary("Archive a feature.")
            }
        }
    }

    private func getFeatureEnvironment(_ req: Request) async throws {}

    private func toggleFeatureEnvironmentOff(_ req: Request) async throws {}

    private func toggleFeatureEnvironmentOn(_ req: Request) async throws {}

    private func getFeatureStrategies(_ req: Request) async throws {}

    private func addFeatureStrategy(_ req: Request) async throws {}

    private func getFeatureStrategy(_ req: Request) async throws {}

    private func setStrategiesSortOrder(_ req: Request) async throws {}

    private func updateFeatureStrategy(_ req: Request) async throws {}

    private func patchFeatureStrategy(_ req: Request) async throws {}

    private func deleteFeatureStrategy(_ req: Request) async throws {}

    private func getFeatures(_ req: Request) async throws {}

    private func createFeature(_ req: Request) async throws {}

    private func cloneFeature(_ req: Request) async throws {}

    private func getFeature(_ req: Request) async throws {}

    private func updateFeature(_ req: Request) async throws {}

    private func patchFeature(_ req: Request) async throws {}

    private func archiveFeature(_ req: Request) async throws {}
}

