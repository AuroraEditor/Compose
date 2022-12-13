//
//  MFAEmail.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor
import Queues

// TODO: Create a html body for the email
struct MFAEmail {
    func sendMFACodeEmail(email: String,
                          req: Request,
                          body: String,
                          htmlBody: String?) async throws -> Void {
        do {
            let parameters: [String: Any] = [
                "api_key": Environment.get("SMPT2GO_API")!,
                "to": [
                    email
                ],
                "sender": "Security <\(Constants.SECURITY_EMAIL)>",
                "subject": "Aurora Compose Login Code",
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
