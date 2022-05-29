//
//  Model.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 27.03.2022.
//

import Foundation

final class GameSet {

    private var isSelected = [Card]()
    private var cardsTryMatched = [Card]()
    private var cardsRemoved = [Card]()

    var cardsOnTable = [Card]()
    var deck = CardDeck()
    var deckCount: Int { return deck.cards.count }
    var score = 0
    var setsNumber = 0

    private func replaceCardsOnTable() {
        if let threeCards = takeThreeCardsFromDeck(), threeCards != [] {
            for idx in 0..<3 {
                if let indexMatched = cardsOnTable.firstIndex(of: cardsTryMatched[idx]) {
                    cardsOnTable[indexMatched] = threeCards[idx]
                }
            }
            cardsRemoved += cardsTryMatched
            print(cardsRemoved.count, deckCount)
            cardsTryMatched.removeAll()
        }
//        } else {
//            for card in cardsTryMatched {
//                if cardsOnTable.contains(card) {
//                    cardsOnTable = cardsOnTable.filter { $0 == card }
//                }
//            }
//            cardsRemoved += cardsTryMatched
//            cardsTryMatched.removeAll()
//        }
    }

    private func winOrPenalty() {
        if isSet() {
            score += Constants.win
            setsNumber += 1
            replaceCardsOnTable()
        } else {
            score -= Constants.penalty
        }
    }

    private func takeThreeCardsFromDeck() -> [Card]? {
        var threeCards = [Card]()
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            }
        }
        return threeCards
    }

    func addThreeCardsOnTable() {
        if let threeCards = takeThreeCardsFromDeck(), deckCount != 0 {
            cardsOnTable += threeCards
        }
    }

    func startNewGame() {
        score = 0
        setsNumber = 0
        isSelected.removeAll()
        cardsTryMatched.removeAll()
        cardsRemoved.removeAll()
        deck = CardDeck()
        cardsOnTable.removeAll()
        for _ in 1...12 {
         if let card = deck.draw() {
            cardsOnTable += [card]
            }
        }
    }

    func isSet() -> Bool {
        guard isSelected.count == 3 else { return false }
        cardsTryMatched = isSelected
        return Card.isSet(cards: cardsTryMatched)
    }

    func deselectAll() {
        isSelected.removeAll()
    }

    func selectOrDeselectCards(index: Int) {
        if isSelected.contains(cardsOnTable[index]) {
            isSelected = isSelected.filter { $0 != cardsOnTable[index] }
        } else {
            isSelected.append(cardsOnTable[index])
        }
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

    struct Date {

    }

}
