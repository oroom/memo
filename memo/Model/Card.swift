//
//  Card.swift
//  memo
//
//  Created by Artsiom Sadyryn on 1/8/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation

struct Card: Equatable {
    
    var isOpened: Bool
    var isMatched: Bool
    var isFlipped: Bool {
        return isOpened || isMatched
    }
    var imageName: String
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.imageName == rhs.imageName
    }

}
