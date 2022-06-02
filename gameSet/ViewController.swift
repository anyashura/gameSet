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
        selectCard(for: button)
        game.selectOrDeselectCard(index: button.tag)
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
                print(game.cardsOnTable[button.tag])
                let card = game.cardsOnTable[button.tag]
                button.backgroundColor = .white
                button.setAttributedTitle(for: card)
                button.isEnabled = true
            } else {
                button.setTitle(" ", for: .normal)
                button.setAttributedTitle(NSAttributedString(" "), for: .normal)
                button.backgroundColor = .clear
                button.isEnabled = false
            }
        }
    }

    private func selectCard(for button: PlayingCardsViewButton ) {
        let isCardSelected = selectedCards.contains(button)
        isCardSelected ? selectedCards.removeAll(where: { $0 == button }) : selectedCards.append(button)
        button.layer.borderWidth = isCardSelected ? 0.0 : 3.0
        button.layer.borderColor = isCardSelected ? UIColor.clear.cgColor : UIColor.blue.cgColor
    }

    private func checkSetOrNot() {
        guard selectedCards.count == 3 else { return }
        let isSet = game.isSet()
        for card in selectedCards {
            card.layer.borderWidth = 3.0
            card.layer.borderColor = isSet ? UIColor.green.cgColor : UIColor.red.cgColor
            card.isEnabled = isSet ? false : true
        }
        selectedCards.removeAll()
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

// посмотри, пожалуйста, предупреждение про фон при билдинге, как изменить на dynamic type text style?
