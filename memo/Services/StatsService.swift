//
//  StatsService.swift
//  memo
//
//  Created by Евгений Таран on 1/22/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation

extension UserDefaults {
    func save<T : Encodable>(value: T, for key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            self.setValue(encoded, forKey: key)
        }
    }
    
    func load<T : Decodable>(for key: String) -> T? {
        if let result = self.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(T.self, from: result ) {
                return decoded
            }
        }
        return nil
    }
}

class StatsService {
    
    func totalTime(games: [GameResult]) -> TimeInterval {
        return games.reduce(0) { $0 + $1.time }
    }
    
    func scores(games: [GameResult]) -> [Double] {
        return games.map { $0.score() }
    }
    
    func bestGame(games: [GameResult]) -> GameResult {
        return games.reduce(games[0], { (result, nextGame) -> GameResult in
            if nextGame.score() > result.score() {
                return nextGame
            }
            return result
        })
    }
    
    func save(results: GameResult) {
        var savedResults = getResults() ?? [GameResult]()
        savedResults.append(results)
        UserDefaults.standard.save(value: savedResults, for: "gameResults")
    }
    
    func getResults() -> [GameResult]? {
        return UserDefaults.standard.load(for: "gameResults")
    }
}
