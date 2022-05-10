//
//  ViewController.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 19.03.2022.
//

import UIKit

class ViewController: UIViewController {

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
                button.backgroundColor = .clear
                button.isEnabled = false
            }
        }
    }

    @IBAction func touchCard(_ sender: PlayingCardsViewButton) {

//        updateViewFromModel()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if button.tag == sender.tag {
                if !touchingCards.contains(button), touchingCards.count <= 3 {
                    touchingCards.append(button)
                    game.isSelected.append(game.cardsOnTable[button.tag])
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                } else if touchingCards.contains(button) {
                    touchingCards = touchingCards.filter { $0 != button }
                    game.isSelected = game.isSelected.filter { $0 != game.cardsOnTable[button.tag] }
                    button.layer.borderWidth = 0.0
                    button.layer.borderColor = UIColor.clear.cgColor
                }
            }

        }
        if touchingCards.count == 3 {
            game.chooseCard()
            for card in touchingCards {
                card.layer.borderWidth = 3.0
                card.layer.borderColor = UIColor.magenta.cgColor
            }
            buttonsView()
            if game.isSet(for: game.isSelected) == true {
                for card in touchingCards {
                    card.layer.borderWidth = 3.0
                    card.layer.borderColor = UIColor.green.cgColor

                }
//                  } else {
//                      for card in touchingCards {
//                          card.layer.borderWidth = 3.0
//                          card.layer.borderColor = UIColor.red.cgColor
//                          touchingCards.removeAll()
//                    }
//                }
        }
//            for card in touchingCards {
//                card.layer.borderWidth = 0.0
//                card.layer.borderColor = UIColor.clear.cgColor
//            }
            touchingCards.removeAll()

    }
    }

//        for card in touchingCards {
//            if game.isSet(for: game.isSelected) == true {
//                card.layer.borderWidth = 3.0
//                card.layer.borderColor = UIColor.green.cgColor
//                touchingCards.removeAll()
//            } else if game.isSet(for: game.isSelected) == false {
//                card.layer.borderWidth = 3.0
//                card.layer.borderColor = UIColor.red.cgColor
//                touchingCards.removeAll()
//            }
//        }
//        print(touchingCards, game.isSelected, touchingCards.count)

    func updateViewFromModel() {
////
//        for index in game.isSelected.indices {
//            let button = cardButtons[index]
//            if button.identifier
////            let card = game.isSelected[index]
////            if game.isSelected.count <= 3 {
//////                if button.identifier == identifier {
////                    button.layer.borderWidth = 3.0
////                    button.layer.borderColor = UIColor.blue.cgColor
//////                }
////                } else {
////                    button.layer.borderWidth = 0.0
////                    button.layer.borderColor = UIColor.clear.cgColor
////            }
////        }
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
