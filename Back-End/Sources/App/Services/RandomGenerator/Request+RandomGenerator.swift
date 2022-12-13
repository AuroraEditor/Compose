//
//  Request.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//


import Vapor

extension Request {
    var random: RandomGenerator {
        self.application.random
    }
}
