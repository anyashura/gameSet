//
//  Model.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 27.03.2022.
//

import Foundation

final class GameSet {

    var isSelected = [Card]()
    var cardsOnTable = [Card]()
    var cardsTryMatched = [Card]()
    var cardsRemoved = [Card]()
    var deck = CardDeck()
    var deckCount: Int { return deck.cards.count }
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
        cardsOnTable = [Card]()
        for _ in 1...12 {
         if let card = deck.draw() {
            cardsOnTable += [card]
            }
        }
    }

    func takeThreeCardsFromDeck() -> [Card]? {
        var threeCards = [Card]()
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

    func replaceCards() {
        if let threeCards = takeThreeCardsFromDeck(), threeCards != [] {
            for idx in 0..<3 {
                if let indexMatched = cardsOnTable.firstIndex(of: cardsTryMatched[idx]) {
                    cardsOnTable[indexMatched] = threeCards[idx]
                    print(cardsOnTable[indexMatched])
                }
            }
            cardsRemoved += cardsTryMatched
            print(cardsRemoved.count, deckCount)
            cardsTryMatched.removeAll()
        } else {
            for card in cardsTryMatched {
                if cardsOnTable.contains(card) {
                    cardsOnTable = cardsOnTable.filter { $0 == card }
                }
            }
            cardsRemoved += cardsTryMatched
            cardsTryMatched.removeAll()
        }
    }

    func isSet(for cards: [Card]) -> Bool? {
        guard isSelected.count == 3 else { return nil }
        cardsTryMatched = isSelected
        print(Card.isSet(cards: cardsTryMatched))
        return Card.isSet(cards: cardsTryMatched)

    }

    func winOrPenalty() {
        if isSet(for: cardsTryMatched) == true {
            score += Constants.win
            setsNumder += 1
            replaceCards()
        } else {
            score -= Constants.penalty
        }
    }

    func chooseCard() {
//        assert(cardsOnTable.indices.contains(index), "SetGame.chooseCard(at: \(index)) : Choosen index out of range")
//        let card = cardsOnTable[tag]
        flipCount += 1
        if isSelected.count == 3 {
            winOrPenalty()
        }
    }

    init() {
        for _ in 1...12 {
         if let card = deck.draw() {
            cardsOnTable += [card]
            }
        }
    }

    struct Constants {
        static let win = 20
        static let penalty = 10
        static let maxTimePenalty = 10
    }

}
