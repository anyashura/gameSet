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
    var flipCount = 0
    var setsNumder = 0

    func newGame() {
        score = 0
        flipCount = 0
        setsNumder = 0
        isSelected.removeAll()
        cardsTryMatched.removeAll()
        cardsRemoved.removeAll()
        deck = CardDeck()
        cardsOnTable = [Cards]()
        for _ in 1...12 {
         if let card = deck.draw() {
            cardsOnTable += [card]
            }
        }
    }

    func takeThreeCardsFromDeck() -> [Cards]? {
        var threeCards = [Cards]()
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            }
        }
        return threeCards
    }

    func addThreeCardsOnTable() {
        if let threeCards = takeThreeCardsFromDeck() {
            cardsOnTable += threeCards
        }
    }

    func removeCards() {
        if isSet(for: cardsTryMatched) == true {
            for index in cardsOnTable.indices {
                for ind in cardsTryMatched.indices {
                    if cardsOnTable[index] == cardsTryMatched[ind] {
                        cardsOnTable.remove(at: index)
                    }
                }
            }
            cardsRemoved += cardsTryMatched
            cardsTryMatched.removeAll()
        }
    }

    func replaceCards() {
        if isSet(for: cardsTryMatched) == true, let threeCards = takeThreeCardsFromDeck() {
            for idx in 0..<3 {
                if let indexMatched = cardsOnTable.firstIndex(of: cardsTryMatched[idx]) {
                    cardsOnTable [indexMatched ] = threeCards[idx]
                }
            }
        }
        cardsRemoved += cardsTryMatched
        cardsTryMatched.removeAll()
    }

    func isSet(for cards: [Cards]) -> Bool? {
        guard isSelected.count == 3 else { return nil }
        cardsTryMatched = isSelected
        return Cards.isSet(cards: cardsTryMatched)
    }

    func winOrPenalty() {
        if isSet(for: cardsTryMatched) == true {
            score += WinOrPenalty.win
            setsNumder += 1
        } else {
            score -= WinOrPenalty.penalty
        }
    }

    func chooseCard (at index: Int) {
        assert(cardsOnTable.indices.contains(index), "SetGame.chooseCard(at: \(index)) : Choosen index out of range")

    }

    init() {
        for _ in 1...12 {
         if let card = deck.draw() {
            cardsOnTable += [card]
            }
        }
    }

    struct WinOrPenalty {
        static let win = 20
        static let penalty = 10
        static let maxTimePenalty = 10
    }

}
