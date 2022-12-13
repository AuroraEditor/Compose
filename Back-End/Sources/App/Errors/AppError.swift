//
//  AppError.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor

protocol AppError: AbortError, DebuggableError {}
