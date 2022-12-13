//
//  RequestService.swift
//  
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

protocol RequestService {
    func `for`(_ req: Request) -> Self
}
