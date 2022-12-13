//
//  QueueContext.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Fluent
import Queues

extension QueueContext {
    var db: Database {
        application.databases
            .database(logger: self.logger, on: self.eventLoop)!
    }
    
    var appConfig: AppConfig {
        application.config
    }
}
