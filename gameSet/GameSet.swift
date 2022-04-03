//
//  Model.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 27.03.2022.
//

import Foundation

final class GameSet {

    var isSelected = [Cards]()
    var cardsOnTable = [Cards]()
    var cardsTryMatched = [Cards]()
    var cardsRemoved = [Cards]()
    var deck = CardDeck()
    var deckCount: Int {return deck.cards.count}
    var score = 0
    var cards = [Cards]()

    func newGame() {
        score = 0
        isSelected.removeAll()
        cardsOnTable.removeAll()
        cardsTryMatched.removeAll()
        cardsRemoved.removeAll()
        deck = CardDeck()
    }

    func takeThreeCardsFromDeck() -> [Cards] {
        if let card = deck.draw() {
            for _ in 0...2 {
                cards += [card]
            }
        }
        return cards
    }
    
    func addThreeCardsOnTable() {
        cardsOnTable += takeThreeCardsFromDeck()
    }
    
//    func removeCards() {
//        if cardsTryMatched.isSet == true {
//            cardsRemoved += cardsTryMatched
//            cardsTryMatched.removeAll()
//        }
//
//    }
//
//    func replaceCards() {
//        if cardsTryMatched.isSet == true {
//            for index in cardsOnTable.indices {
////если элементы в массивах совпадают, то заменяем на новую карту                }
//            cardsRemoved.append(cardsTryMatched)
//            cardsTryMatched.removeAll()
//        }
//    }

//    func isSet(for cards: [Cards]) -> Bool {
//        guard isSelected.count == 3 else { return false }
//        cardsTryMatched = isSelected
//
//
//
//
//        isSelected.removeAll()
//        }
//
//    }

    func chooseCard() {

    }

}
