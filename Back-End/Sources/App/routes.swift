import Fluent
import Vapor

func routes(_ app: Application) throws {

    let apiDocsController = APIDocsController(app: app)

    try app.group("v1") { api in
        api.group("swagger") { swagger in
            swagger.get("docs", use: apiDocsController.view)
                .summary("View API Documentation")
                .description("API Documentation is served using the Redoc web app.")
                .tags("Documentation")

            swagger.get("docs", "openapi.yml", use: apiDocsController.show)
                .summary("Download API Documentation")
                .description("Retrieve the OpenAPI documentation as a YAML file.")
                .tags("Documentation")
        }
    }
}
