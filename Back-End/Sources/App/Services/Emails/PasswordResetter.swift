//
//  PasswordResetter.swift
//  
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Queues

// TODO: Create a html body for the email
struct PasswordResetter {
    let queue: Queue
    let repository: PasswordTokenRepository
    let eventLoop: EventLoop
    let config: AppConfig
    let generator: RandomGenerator

    /// Sends a email to the user with a reset-password URL
    func reset(for user: User) async -> Void {
        do {
            let token = generator.generate(bits: 256)
            let resetPasswordToken = try PasswordToken(userID: user.requireID(), token: SHA256.hash(token))
            let url = resetURL(for: token)

            let parameters: [String: Any] = [
                "api_key": Environment.get("SMPT2GO_API")!,
                "to": [
                    user.email
                ],
                "sender": "Security <\(Constants.SECURITY_EMAIL)>",
                "subject": "Password Reset",
                "text_body": url,
                "html_body": "<h1>\(url)</h1>"
            ]

            AuroraNetworking().request(path: Constants.SMPT_EMAIL,
                                       method: .POST,
                                       parameters: parameters) { completion in
                switch completion {
                case .success:
                    print("Success")
                case .failure(let error):
                    print(error)
                }
            }

            return await repository.create(resetPasswordToken)
        } catch {
            print(error)
        }
    }

    private func resetURL(for token: String) -> String {
        "\(config.frontendURL)/#/auth/reset-password?token=\(token)"
    }
}

extension Request {
    var passwordResetter: PasswordResetter {
        .init(queue: self.queue, repository: self.passwordTokens, eventLoop: self.eventLoop, config: self.application.config, generator: self.application.random)
    }
}
