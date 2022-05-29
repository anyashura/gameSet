//
//  ViewController.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 19.03.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Private

    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var addThreeCardsButton: UIButton!
    @IBOutlet private weak var numberOfSetsLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private var cardButtons: [PlayingCardsViewButton]!

    private let game = GameSet()

    private var countOfCardsOnTable = 12
    private var selectedCards = [PlayingCardsViewButton]()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        addThreeCardsButton.backgroundColor = .yellow
        newGameButton.backgroundColor = .yellow
        scoreLabel.text = "Score: \(game.score)"
        numberOfSetsLabel.text = "Sets: \(game.setsNumber)"
    }

    // MARK: Actions

    @IBAction private func addThreeCards(_ sender: UIButton) {
        if selectedCards.count == 0 {
            deleteSelection()
        }
        if cardButtons.count > countOfCardsOnTable {
            game.addThreeCardsOnTable()
            countOfCardsOnTable += 3
            configureButtons()
        } else {
            addThreeCardsButton.backgroundColor = .gray
        }
    }

    @IBAction private func touchCard(_ sender: PlayingCardsViewButton) {
        configureButtons()
        // чтобы после выбора 3х карт убиралось выделение карт
        if selectedCards.count == 0 {
            deleteSelection()
        }
        guard let button = cardButtons.first(where: { $0 == sender }) else { return }
        selectCards(for: button)
        game.selectOrDeselectCards(index: button.tag)
        checkSetOrNot()
    }

    @IBAction private func startNewGame(_ sender: UIButton) {
        countOfCardsOnTable = 12
        selectedCards.removeAll()
        addThreeCardsButton.backgroundColor = .yellow
        deleteSelection()
        game.startNewGame()
        scoreLabel.text = "Score: \(game.score)"
        numberOfSetsLabel.text = "Sets: \(game.setsNumber)"
        configureButtons()
    }

    private func configureButtons() {
        // расположение фигур на карточке, замена в случае replace
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.layer.cornerRadius = 16.0
            button.clipsToBounds = true
            if index < countOfCardsOnTable {
                let card = game.cardsOnTable[button.tag]
                button.backgroundColor = .white
                button.setAttributedTitle(button.attributedName(for: card, fontSize: 25.0), for: .normal) // button.setAttributedTitle(for card: Card)
                button.isEnabled = true
            } else {
                button.setTitle(" ", for: .normal)
                button.setAttributedTitle(NSAttributedString(" "), for: .normal)
                button.backgroundColor = .clear
                button.isEnabled = false
            }
        }
    }

    private func selectCards(for button: PlayingCardsViewButton ) {
        let isCardSelected = selectedCards.contains(button)
        isCardSelected ? selectedCards.removeAll(where: { $0 == button }) : selectedCards.append(button)
        button.layer.borderWidth = isCardSelected ? 0.0 : 3.0
        button.layer.borderColor = isCardSelected ? UIColor.clear.cgColor : UIColor.blue.cgColor
    }

    private func checkSetOrNot() {
        guard selectedCards.count == 3 else { return }
        let isSet =  game.isSet()
        for card in selectedCards {
            card.layer.borderWidth = 3.0
            card.layer.borderColor = isSet ? UIColor.green.cgColor : UIColor.red.cgColor
            card.isEnabled = isSet ? false : true
        }
        selectedCards.removeAll()
        game.deselectAll()
        scoreLabel.text = "Score: \(game.score)"
        numberOfSetsLabel.text = "Sets: \(game.setsNumber)"
    }

    private func deleteSelection() {
        for button in cardButtons {
            button.layer.borderWidth = 0.0
            button.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

// all game's methods except here –> private
// all game's methods used here –> private if possible
