//
//  GameResult.swift
//  memo
//
//  Created by Dzimtry Navak on 1/22/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation

struct GameResult: Codable {
    let pairs: Int
    let steps: Int
    let time: TimeInterval
    
    init(pairs: Int, steps: Int, time: TimeInterval) {
        self.pairs = pairs
        self.steps = steps
        self.time = time
    }
    
    func score() -> Double {
        return Double(pairs) * Double(max(time, 10)) / Double(steps)
    }
}
