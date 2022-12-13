//
//  Request.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

extension Request {
    // MARK: Repositories
    var users: UserRepository { application.repositories.users.for(self) }
    var refreshTokens: RefreshTokenRepository { application.repositories.refreshTokens.for(self) }
    var accessTokens: AccessTokenRepository { application.repositories.accessTokens.for(self) }
    var emailTokens: EmailTokenRepository { application.repositories.emailTokens.for(self) }
    var passwordTokens: PasswordTokenRepository { application.repositories.passwordTokens.for(self) }
    var extensions: ExtensionRepository { application.repositories.extensions.for(self) }
    var extensionIdeas: ExtensionIdeaRepository { application.repositories.extensionIdeas.for(self) }
    var teams: TeamsRepository { application.repositories.teams.for(self) }
    var bans: BanRepository { application.repositories.bans.for(self) }
    var mfa: MFARepository { application.repositories.mfa.for(self) }

    // Remote Config
    var apiTokens: APITokenRepository { application.repositories.apiToken.for(self) }
}
