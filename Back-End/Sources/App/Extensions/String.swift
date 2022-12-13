//
//  File.swift
//  
//
//  Created by Nanashi Li on 2022/12/13.
//

import Foundation

extension String {
    func apiSecretKey() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<28).map{ _ in letters.randomElement()! })
    }
}
