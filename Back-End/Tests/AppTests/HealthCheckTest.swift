//
//  HealthCheckTest.swift
//  
//
//  Created by Nanashi Li on 2022/12/09.
//

@testable import App
import XCTVapor

final class HealthCheckTest: XCTestCase {
    func testHealth() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "v1/health", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
}
