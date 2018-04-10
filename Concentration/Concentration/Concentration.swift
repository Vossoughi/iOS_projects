//
//  Concentration.swift
//  Concentration
//
//  Created by Kaveh Vossoughi on 3/26/18.
//  Copyright © 2018 Kaveh Vossoughi. All rights reserved.
//

import Foundation
import UIKit

class Concentration {
    
    var cards = [Card]()
    internal var score = 0
    internal var flipCount = 0
    
    lazy var emojiChoices = getRandomTheme()
    var emoji = [Int : String]()
    
    private let themes = [0 : ["👽", "👻", "🎃", "🐙", "🌚", "🍄", "🏀", "⏰", "🎲"],
                  1 : ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "💔", "💝"],
                  2: ["🏳️‍🌈", "🇧🇷", "🇨🇦", "🇬🇶", "🇫🇯", "🇯🇵", "🇰🇷", "🇬🇧", "🇺🇸"],
                  3: ["⌚️", "📱", "💻", "⌨️", "🎥", "📡", "📟", "📷", "🎞"],
                  4: ["~", "!", "#", "$", "%", "^", "&", "*", "@"],
                  5: ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
    ]
    
    private let themeViewColors = [0 : [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)],
                                   1 : [],
                                   2: [],
                                   3: [],
                                   4: [],
                                   5: []
    ]
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func getRandomTheme() -> [String] {
        return themes[Int(arc4random_uniform(UInt32(themes.count)))]!
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if (cards[index].isEverFliped) { score -= 1 }
                    if (cards[matchIndex].isEverFliped) { score -= 1 }
                    cards[index].isEverFliped = true
                    cards[matchIndex].isEverFliped = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    init(numberOfPairsOfCards: Int) {
        Card.identifierFactory = 0
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        var dic: [Int : Card] = [:]
        var randomIndex = 0
        for index in cards.indices {
            repeat {
            randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            } while (dic[randomIndex] != nil)
            dic[randomIndex] = cards[index]
        }
        cards = Array(dic.values)
    }
}
