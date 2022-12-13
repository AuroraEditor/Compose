//
//  MFAEnableResponse.swift
//  
//
//  Created by Nanashi Li on 2022/11/10.
//

import Vapor

struct MFAEnableResponse: Content {
    let recoveryCodes: [String]
}
