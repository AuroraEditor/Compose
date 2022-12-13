//
//  RealRandomGenerator.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//


import Vapor

extension Application.RandomGenerators.Provider {
    static var random: Self {
        .init {
            $0.randomGenerators.use { _ in RealRandomGenerator() }
        }
    }
}

struct RealRandomGenerator: RandomGenerator {
    func generate(bits: Int) -> String {
        [UInt8].random(count: bits / 8).hex
    }
}
