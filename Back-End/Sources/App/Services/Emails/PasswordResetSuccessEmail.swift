//
//  PasswordResetSuccessEmail.swift
//  
//
//  Created by Nanashi Li on 2022/10/26.
//

import Vapor
import Queues

// TODO: Create a html body for the email
struct PasswordResetSuccessEmail {
    func verify(for user: User) async -> Void {
        do {
            let parameters: [String: Any] = [
                "api_key": Environment.get("SMPT2GO_API")!,
                "to": [
                    user.email
                ],
                "sender": "Security <\(Constants.SECURITY_EMAIL)",
                "subject": "Password Reset Confirmation",
                "text_body": "Password was reset successfully",
                "html_body": "<h1>Password was reset successfully</h1>"
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
