//
//  PlayingCardsViewButton.swift
//  gameSet
//
//  Created by Anna Shuryaeva on 25.03.2022.
//

import UIKit

class PlayingCardsViewButton: UIButton {

    let colors: [UIColor] = [.magenta, .blue, .brown]
    let withAlpha = [0.15, 1.0, 0.50]
    let strokeWidths = [-8, -8, 8]
    let shape = ["●", "◼︎", "▲"]
    let number = [1, 2, 3]

    var identifier: String?

    func setAttributedTitle(for card: Card) {
        var newString: String = shape[card.shape.rawValue]
        if card.howMany.rawValue == 1 {
            newString = shape[card.shape.rawValue]
        } else if card.howMany.rawValue == 2 {
            newString = shape[card.shape.rawValue] + shape[card.shape.rawValue]
        } else {
            newString = shape[card.shape.rawValue] + shape[card.shape.rawValue] + shape[card.shape.rawValue]
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: colors[card.color.rawValue].withAlphaComponent(withAlpha[card.fill.rawValue]), .strokeWidth: strokeWidths[card.fill.rawValue], .strokeColor: colors[card.color.rawValue], .font: UIFont.preferredFont(forTextStyle: .body).withSize(25.0)]

        let name = NSAttributedString(string: newString, attributes: attributes)
        setAttributedTitle(name, for: .normal)
    }
}
