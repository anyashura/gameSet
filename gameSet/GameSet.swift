//
//  Model.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 27.03.2022.
//

import Foundation

final class GameSet {

    private struct Constant {
        static let win = 20
        static let penalty = 10
        static let maxTimePenalty = 10
    }

    var countOfCardsOnTable = 12

    private(set) var cardsOnTable = [Card]()
    private(set) var score = 0
    private(set) var setsNumber = 0

    private var deck = CardDeck()
    private var selectedCards = [Card]()
    private var isSetOnTable = false

    init() {
        for _ in 1...12 {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
    }

    // private ???
    func isSet() -> Bool {
        Card.isSet(cards: selectedCards)
    }

    func selectOrDeselectCard(index: Int) {
        if selectedCards.count == 3 { selectedCards.removeAll(); isSetOnTable = false }

        if selectedCards.contains(cardsOnTable[index]) {
            deleteFromSelectedCards(index: index)
        } else {
            selectedCards.append(cardsOnTable[index])
        }
        checkSet()
    }

    func addThreeCardsOnTable() {
        guard isSetOnTable == false else { return isSetOnTable = false }
        let threeCards = takeThreeCardsFromDeck()
        if deck.cards.count != 0 {
            cardsOnTable += threeCards
            countOfCardsOnTable += 3
        }
    }

    func startNewGame() {
        score = 0
        setsNumber = 0
        isSetOnTable = false
        selectedCards.removeAll()
        deck = CardDeck()
        cardsOnTable.removeAll()
        for _ in 1...12 {
            if let card = deck.draw() {
                cardsOnTable += [card]
            }
        }
    }

    private func deleteFromSelectedCards(index: Int) {
        selectedCards = selectedCards.filter { $0 != cardsOnTable[index] }
    }

    private func replaceCardsOnTable() {
        var threeCards = takeThreeCardsFromDeck()
        guard threeCards.isEmpty == false else { return }

        selectedCards.forEach {
            if let indexMatched = cardsOnTable.firstIndex(of: $0) {
                cardsOnTable[indexMatched] = threeCards.removeLast()
            }
        }

//            if let index = cardsOnTable.firstIndex(of: card) {
//                cardsOnTable[index] = threeCards.removeFirst() // удобные ф-ии поиска и замены карт
//            }
//        }

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

    private func checkSet() {
        guard selectedCards.count == 3 else { return }
        if isSet() {
            isSetOnTable = true
            replaceCardsOnTable()
        }
        changeScore()
    }

    private func changeScore() {
        if isSet() {
            score += Constant.win
            setsNumber += 1
        } else {
            score -= Constant.penalty
        }
    }

    private func takeThreeCardsFromDeck() -> [Card] {
        var threeCards = [Card]()
        for _ in 0...2 {
            if let card = deck.draw() {
                threeCards += [card]
            }
        }
        return threeCards
    }
}
