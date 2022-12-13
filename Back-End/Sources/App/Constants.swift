//
//  Constants.swift
//  
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

struct Constants {

    static let SMPT_URL: String = "https://api.smtp2go.com/v3/"
    static let SMPT_EMAIL: String = "email/send"

    static let GITHUB_URL: String = "https://api.github.com/"
    static func GITHUB_REPO(owner: String, repo: String) -> String {
        return "repos/\(owner)/\(repo)"
    }

    /// How long should access tokens live for. Default: 7 days (in seconds)
    static let ACCESS_TOKEN_LIFETIME: Double = 60 * 60 * 24 * 7
    /// How long should refresh tokens live for: Default: 30 days (in seconds)
    static let REFRESH_TOKEN_LIFETIME: Double = 60 * 60 * 24 * 30
    /// How long should the email tokens live for: Default 24 hours (in seconds)
    static let EMAIL_TOKEN_LIFETIME: Double = 60 * 60 * 24
    /// Lifetime of reset password tokens: Default 1 hour (seconds)
    static let RESET_PASSWORD_TOKEN_LIFETIME: Double = 60 * 60

    // Enviroment Values
    static let GOOGLE_BUCKET_ID: String = Environment.get("GOOGLE_BUCKET_ID") ?? ""
    static let SECURITY_EMAIL: String = Environment.get("SECURITY_EMAIL") ?? "security@example.com"
}
