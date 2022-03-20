//
//  CardDeck.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 20.03.2022.
//

import Foundation

struct CardDeck {
   
    var cards = [Cards]()
    
        init() {
            for howMany in Cards.HowMany.all{
                for shape in Cards.Shape.all{
                    for fill in Cards.Fill.all{
                        for color in Cards.Color.all {
                            cards.append(Cards(howMany : howMany, shape : shape, fill : fill, color : color))
                        }
                    }
                }
            }
        }
    
    mutating func draw() -> Cards? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
        
    }
}

extension Int {
    var arc4random : Int {
        if self > 0 {
            return(Int(arc4random_uniform(UInt32(self))))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs((self)))))
        } else {
            return 0
        }
    }
}
