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
//
    @IBOutlet var cardButtons: [PlayingCardsViewButton]!

    @IBAction private func addThreeCardsButton(_ sender: UIButton) {
        if cardButtons.count > howManyCards {
            howManyCards += 3
            buttonsView()
        } else {
            addThreeCards.backgroundColor = .gray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsView()
    }

    @IBAction func touchCard(_ sender: PlayingCardsViewButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard()
            game.isSelected.append(contentsOf: cardNumber)
            for index in cardButtons[index] {
                let card = game.isSelected[index]
                let button = cardButtons[index]
                guard game.isSelected.count < 3 else {}
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.blue.cgColor
            }
        }
    }

    func setOrNot () {

    }

    func buttonsView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < 12 {
                let card = deck.draw()
                button.setAttributedTitle(button.attributedName(for: card!, fontSize: 25.0), for: .normal)
                button.isEnabled = true
            } else {
                button.setTitle("  ", for: .normal)
                button.setAttributedTitle(NSAttributedString("  "), for: .normal)
                button.backgroundColor = .clear
                button.isEnabled = false
            }
        }
    }

    @IBAction private func newGame(_ sender: UIButton) {
        game.newGame()
        buttonsView()
    }



}
