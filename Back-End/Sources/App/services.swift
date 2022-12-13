//
//  services.swift
//  
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

func services(_ app: Application) throws {
    app.randomGenerators.use(.random)
    app.repositories.use(.database)
}
