//
//  Repositories.swift
//  
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Fluent

protocol Repository: RequestService {}

protocol DatabaseRepository: Repository {
    var database: Database { get }
    init(database: Database)
}

extension DatabaseRepository {
    func `for`(_ req: Request) -> Self {
        return Self.init(database: req.db)
    }
}

extension Application {
    struct Repositories {
        struct Provider {
            static var database: Self {
                .init {
                    $0.repositories.use {
                        DatabaseUserRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseEmailTokenRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseRefreshTokenRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabasePasswordTokenRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseMFARepository(database: $0.db)
                    }

                    // Remote Config
                    $0.repositories.use {
                        DatabaseSessionRepositoryRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseFavoriteProjectsRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseFeedbackRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseClientApplicationsRepository(database: $0.db)
                    }
                    $0.repositories.use {
                        DatabaseAPITokenRepository(database: $0.db)
                    }
                }
            }

            let run: (Application) -> ()
        }

        final class Storage {
            var makeUserRepository: ((Application) -> UserRepository)?
            var makeEmailTokenRepository: ((Application) -> EmailTokenRepository)?
            var makeRefreshTokenRepository: ((Application) -> RefreshTokenRepository)?
            var makePasswordTokenRepository: ((Application) -> PasswordTokenRepository)?
            var makeMFARepository: ((Application) -> MFARepository)?

            // Remote Config
            var makeSessionRepository: ((Application) -> SessionRepository)?
            var makeFavProjectsRepository: ((Application) -> FavoriteProjectsRepository)?
            var makeFeedbackRepository: ((Application) -> FeedbackRepository)?
            var makeClientApplicationsRepository: ((Application) -> ClientApplicationsRepository)?
            var makeAPITokenRepository: ((Application) -> APITokenRepository)?
            init() { }
        }

        struct Key: StorageKey {
            typealias Value = Storage
        }

        let app: Application

        func use(_ provider: Provider) {
            provider.run(app)
        }

        var storage: Storage {
            if app.storage[Key.self] == nil {
                app.storage[Key.self] = .init()
            }

            return app.storage[Key.self]!
        }
    }

    var repositories: Repositories {
        .init(app: self)
    }
}
