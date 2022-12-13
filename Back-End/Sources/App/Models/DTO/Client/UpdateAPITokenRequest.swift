//
//  UpdateAPITokenRequest.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Vapor

struct UpdateAPITokenRequest: Content {
    let expiresAt: Date
}
