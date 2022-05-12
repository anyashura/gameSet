//
//  ViewController.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 19.03.2022.
//

import UIKit

class ViewController: UIViewController {
//    score, timer, clear backround color, replacing cards after set

    var game = GameSet()

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGame: UIButton!
    @IBOutlet private weak var addThreeCards: UIButton!
    @IBOutlet private weak var timeLabel: UILabel!
    var howManyCards = 12
    var deck = CardDeck()
    var touchingCards = [PlayingCardsViewButton]()
//
    @IBOutlet var cardButtons: [PlayingCardsViewButton]!

    @IBAction private func addThreeCardsButton(_ sender: UIButton) {
        if cardButtons.count > howManyCards, game.deckCount != 0 {
            game.addThreeCardsOnTable()
        } else {
            addThreeCards.backgroundColor = .gray
        }
        howManyCards += 3
        buttonsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsView()
        addThreeCards.backgroundColor = .yellow
        newGame.backgroundColor = .yellow
    }

    func buttonsView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < howManyCards {
                let card = game.cardsOnTable[button.tag]
                button.setAttributedTitle(button.attributedName(for: card, fontSize: 25.0), for: .normal)
                button.isEnabled = true
            } else {
                button.setTitle("  ", for: .normal)
                button.setAttributedTitle(NSAttributedString("  "), for: .normal)
                // почему фон не становится прозрачным?
                button.backgroundColor = .clear
                button.isEnabled = false
            }
        }
    }

    @IBAction func touchCard(_ sender: PlayingCardsViewButton) {
//        updateViewFromModel()
        if touchingCards.count == 0 {
            for button in cardButtons {
                button.layer.borderWidth = 0.0
                button.layer.borderColor = UIColor.clear.cgColor
            }
        }
        for button in cardButtons {
            if button.tag == sender.tag {
                if !touchingCards.contains(button) {
                    touchingCards.append(button)
                    game.isSelected.append(game.cardsOnTable[button.tag])
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                } else {
                    touchingCards = touchingCards.filter { $0 != button }
                    game.isSelected = game.isSelected.filter { $0 != game.cardsOnTable[button.tag] }
                    button.layer.borderWidth = 0.0
                    button.layer.borderColor = UIColor.clear.cgColor
                }
            }
        }
        if touchingCards.count == 3 {
            game.chooseCard()
            buttonsView()
            for card in touchingCards {
                card.layer.borderWidth = 3.0
                card.layer.borderColor = game.isSet(for: game.isSelected) == true ? UIColor.green.cgColor : UIColor.red.cgColor
            }
            touchingCards.removeAll()
            game.isSelected.removeAll()
        }
    }

    func updateViewFromModel() {

    }

    @IBAction private func newGameButton(_ sender: UIButton) {
        howManyCards = 12
        game.flipCount = 0
        game.score = 0
        addThreeCards.backgroundColor = .yellow
        game.newGame()
        buttonsView()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.layer.borderWidth = 0.0
            button.layer.borderColor = UIColor.clear.cgColor
        }
        touchingCards.removeAll()
//        updateViewFromModel()

    }

}
