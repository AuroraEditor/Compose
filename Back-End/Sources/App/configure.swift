import Fluent
import JWT
import Vapor
import FluentMongoDriver
import CloudStorage

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // MARK: - JWT
    app.jwt.signers.use(.hs256(key: Environment.get("JWT_KEY") ?? ""))

    // MARK: - MongoDB

    // TODO: Update Mongo URL with production database url
    try app.databases.use(.mongo(connectionString: Environment.get("MONGODB") ?? ""), as: .mongo)

    // MARK: - Middleware
    app.middleware = .init()

    // MARK: - CORS Middleware
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    // cors middleware should come before default error middleware using `at: .beginning`
    app.middleware.use(cors, at: .beginning)

    // MARK: - Error Middleware
    app.middleware.use(ErrorMiddleware.custom(environment: app.environment))

    // MARK: - Model Middleware

    // MARK: - Google Cloud
    app.googleCloud.credentials = try GoogleCloudCredentialsConfiguration(projectId: "aurora-editor")

    app.googleCloud.storage.configuration = .default()

    app.http.server.configuration.hostname = "127.0.0.1"
    app.http.server.configuration.port = 8081

    try routes(app)
    try services(app)
    if app.environment == .development {
        try app.autoMigrate().wait()
    }
}
