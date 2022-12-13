//
//  EmailVerifier.swift
//  
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Queues

// TODO: Create a html body for the email
struct EmailVerifier {
    let emailTokenRepository: EmailTokenRepository
    let config: AppConfig
    let queue: Queue
    let eventLoop: EventLoop
    let generator: RandomGenerator

    func verify(for user: User) async -> Void {
        do {
            let token = generator.generate(bits: 256)
            let emailToken = try EmailToken(userID: user.requireID(), token: SHA256.hash(token))
            let verifyUrl = url(token: token)

            let parameters: [String: Any] = [
                "api_key": Environment.get("SMPT2GO_API")!,
                "to": [
                    user.email
                ],
                // Temp email till we verify the auroraeditor domain for sending
                "sender": "Security <\(Constants.SECURITY_EMAIL)",
                "subject": "Aurora Compose Verification",
                "text_body": verifyUrl,
                "html_body": "<h1>\(verifyUrl)</h1>"
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

            return await emailTokenRepository.create(emailToken)

        } catch {
            print(error)
        }
    }
    

    private func url(token: String) -> String {
        #"\#(config.frontendURL)/#/auth/email-verification?token=\#(token)"#
    }
}

extension Application {
    var emailVerifier: EmailVerifier {
        .init(emailTokenRepository: self.repositories.emailTokens, config: self.config, queue: self.queues.queue, eventLoop: eventLoopGroup.next(), generator: self.random)
    }
}

extension Request {
    var emailVerifier: EmailVerifier {
        .init(emailTokenRepository: self.emailTokens, config: application.config, queue: self.queue, eventLoop: eventLoop, generator: self.application.random)
    }
}
