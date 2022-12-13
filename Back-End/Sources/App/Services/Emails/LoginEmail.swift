//
//  LoginEmail.swift
//  
//
//  Created by Nanashi Li on 2022/10/28.
//

import Vapor
import Queues

// TODO: Create a html body for the email
struct LoginEmail {
    func sendLoginEmail(for user: User,
                        req: Request,
                        body: String,
                        htmlBody: String?) async throws -> Void {
        do {

            guard let accountID = user.id else {
                throw AuthenticationError.userNotFound
            }

            guard let creatorEmail = try await req.users.getAccountEmail(id: accountID) else {
                throw AuthenticationError.userNotFound
            }

            let parameters: [String: Any] = [
                "api_key": Environment.get("SMPT2GO_API")!,
                "to": [
                    creatorEmail
                ],
                "sender": "Security <\(Constants.SECURITY_EMAIL)>",
                "subject": "New login to Aurora Compose",
                "text_body": body,
                "html_body": "<h1>\(htmlBody ?? body)</h1>"
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
        }
    }
}
