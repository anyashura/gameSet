//
//  CardDeck.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 20.03.2022.
//

import Foundation

struct CardDeck {

    var cards = [Card]()

        init() {
            for howMany in Card.Variant.all {
                for shape in Card.Variant.all {
                    for fill in Card.Variant.all {
                        for color in Card.Variant.all {
                            cards.append(Card(howMany: howMany, shape: shape, fill: fill, color: color))
                        }
                    }
                }
            }
        }

    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return(Int(arc4random_uniform(UInt32(self))))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs((self)))))
        } else {
            return 0
        }
    }
}
