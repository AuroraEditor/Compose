//
//  UserAuthenticator.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import JWT

struct UserAuthenticator: AsyncJWTAuthenticator {
    typealias Payload = App.Payload

    func authenticate(jwt: Payload, for request: Request) async throws -> Void {
        // Get the `bearer` token from the request
        guard let token = request.headers.bearerAuthorization?.token else {
            throw Abort(.badRequest)
        }

        // Once we have the bearer token we check to see if the token exists in the database
        // else if it doesn't we throw an error saying that we couldn't find it.
        guard let accessToken = try await request.accessTokens.find(token: token) else {
            throw AccessTokenError.unableToFindAccessToken
        }

        // If the access token does exist in the database we check the expire date of the token
        // if it's older than the current date we delete the token and and throw an error saying
        // that their access token has expired and that they need to login again.
        if accessToken.expiresAt < Date() {
            try await request.accessTokens.delete(accessToken)
            throw AccessTokenError.accessTokenHasExpired
        }

        // Once the check for full token validation is done we fetch the user id from the payload.
        // If for some odd reason the user's id is not attached to the payload we throw an error
        // notifying the user their account couldn't be found and that they need to login again.
        //
        // As a security precaution we will also delete the token if no user id is attached since the
        // token is basically useless to us and the user, but could pose a risk if made public/exploited.
        guard let accountId = User(from: jwt).id else {
            try await request.accessTokens.delete(accessToken)
            throw AuthenticationError.userNotFound
        }

        // If the user id is valid we make a check to see if the users account is not banned, if the users
        // account is banned to some kind of reason we throw an error telling the user their account is banned,
        // this will also block the user from making any request to the api that requires them to be authenticated.
        if try await request.bans.checkIfUserIsBanned(accountId: accountId) {
            throw AuthenticationError.accountIsBanned
        }

        // If all checks pass we login the user with their jwt token
        return request.auth.login(jwt)
    }
}
