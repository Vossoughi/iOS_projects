//
//  Card.swift
//  Concentration
//
//  Created by Kaveh Vossoughi on 3/26/18.
//  Copyright © 2018 Kaveh Vossoughi. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isEverFliped = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
